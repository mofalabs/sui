import 'dart:convert';
import 'dart:typed_data';

import '../builder/transaction_block_data.dart';
import '../builder/transaction_builder_client.dart';
import 'grpc_transaction_mapper.dart';
import '../types/coins.dart';
import '../types/normalized.dart';
import '../types/objects.dart';
import '../types/transactions.dart';
import 'grpc_core_client.dart';
import 'proto/sui/rpc/v2/move_package.pb.dart';
import 'proto/sui/rpc/v2/owner.pb.dart';

/// Adapts [GrpcCoreClient] to the [TransactionBuilderClient] interface so the
/// [Transaction] builder can resolve objects, Move function signatures and gas
/// (via server-side [resolveGasData]) over gRPC-web.
class GrpcBuilderAdapter implements TransactionBuilderClient {
  GrpcBuilderAdapter(this.core);

  final GrpcCoreClient core;

  @override
  Future<List<SuiObjectResponse>> multiGetObjects(
    List<String> objectIds, {
    SuiObjectDataOptions? options,
  }) async {
    final results = await core.getObjects(
      objectIds,
      readMask: const [
        'object_id',
        'version',
        'digest',
        'owner',
        'object_type',
      ],
    );
    return results.map((r) {
      if (r.hasError()) {
        return SuiObjectResponse.fromJson({
          'error': {
            'code': 'notExists',
            'object_id': null,
          },
        });
      }
      final o = r.object;
      return SuiObjectResponse.fromJson({
        'data': {
          'objectId': o.objectId,
          'digest': o.digest,
          'version': o.version.toString(),
          'type': o.hasObjectType() ? o.objectType : null,
          'owner': _ownerJson(o.hasOwner() ? o.owner : null),
        },
      });
    }).toList();
  }

  dynamic _ownerJson(Owner? owner) {
    if (owner == null) return null;
    return switch (owner.kind) {
      Owner_OwnerKind.ADDRESS || Owner_OwnerKind.CONSENSUS_ADDRESS => {
          'AddressOwner': owner.address
        },
      Owner_OwnerKind.OBJECT => {'ObjectOwner': owner.address},
      Owner_OwnerKind.SHARED => {
          'Shared': {'initial_shared_version': owner.version.toInt()}
        },
      Owner_OwnerKind.IMMUTABLE => 'Immutable',
      _ => null,
    };
  }

  @override
  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String package,
    String moduleName,
    String functionName,
  ) async {
    final fn = await core.getFunction(package, moduleName, functionName);
    final parameters = fn.parameters.map<dynamic>(_mapOpenSignature).toList();
    final returns = fn.returns.map<dynamic>(_mapOpenSignature).toList();
    return SuiMoveNormalizedFunction(
      switch (fn.visibility) {
        FunctionDescriptor_Visibility.PUBLIC => SuiMoveVisibility.Public,
        FunctionDescriptor_Visibility.FRIEND => SuiMoveVisibility.Friend,
        _ => SuiMoveVisibility.Private,
      },
      fn.isEntry,
      const <SuiMoveAbilitySet>[],
      parameters,
      returns,
    );
  }

  /// proto [OpenSignature] -> legacy `SuiMoveNormalizedType` (dynamic) shape.
  dynamic _mapOpenSignature(OpenSignature sig) {
    final body = _mapSignatureBody(sig.body);
    return switch (sig.reference) {
      OpenSignature_Reference.IMMUTABLE => {'Reference': body},
      OpenSignature_Reference.MUTABLE => {'MutableReference': body},
      _ => body,
    };
  }

  dynamic _mapSignatureBody(OpenSignatureBody b) => switch (b.type) {
        OpenSignatureBody_Type.ADDRESS => 'Address',
        OpenSignatureBody_Type.BOOL => 'Bool',
        OpenSignatureBody_Type.U8 => 'U8',
        OpenSignatureBody_Type.U16 => 'U16',
        OpenSignatureBody_Type.U32 => 'U32',
        OpenSignatureBody_Type.U64 => 'U64',
        OpenSignatureBody_Type.U128 => 'U128',
        OpenSignatureBody_Type.U256 => 'U256',
        OpenSignatureBody_Type.VECTOR => {
            'Vector': _mapSignatureBody(b.typeParameterInstantiation.first)
          },
        OpenSignatureBody_Type.DATATYPE => _datatypeStruct(b),
        OpenSignatureBody_Type.TYPE_PARAMETER => {
            'TypeParameter': b.typeParameter
          },
        _ => throw ArgumentError('Unsupported Move type: ${b.type}'),
      };

  Map<String, dynamic> _datatypeStruct(OpenSignatureBody b) {
    final parts = b.typeName.split('::');
    return {
      'Struct': {
        'address': parts.isNotEmpty ? parts[0] : '',
        'module': parts.length > 1 ? parts[1] : '',
        'name': parts.length > 2 ? parts[2] : '',
        'typeArguments':
            b.typeParameterInstantiation.map(_mapSignatureBody).toList(),
      }
    };
  }

  @override
  Future<BigInt> getReferenceGasPrice() async =>
      BigInt.from((await core.getReferenceGasPrice()).toInt());

  @override
  Future<ResolvedGasData?> resolveGasData(
      TransactionBlockDataBuilder data) async {
    // Structured message (not BCS, which cannot express an unset budget) +
    // `doGasSelection` — mirrors Mysten's TS gRPC `resolveTransactionPlugin`.
    // Omit any preset (e.g. dApp-supplied) budget so the node estimates it
    // rather than selecting coins to satisfy that budget.
    final grpcTx = transactionDataToGrpcTransaction(data, includeBudget: false);
    final sim = await core.simulateStructured(
      grpcTx,
      doGasSelection: true,
      readMask: const [
        'transaction.transaction.gas_payment',
        'transaction.effects.status',
      ],
    );
    final status = sim.transaction.effects.status;
    if (!status.success) {
      throw StateError(
          'Gas resolution simulation failed: ${status.error.description}');
    }
    final gp = sim.transaction.transaction.gasPayment;
    if (gp.objects.isEmpty) {
      // Server did not resolve a gas payment; let the caller fall back.
      return null;
    }
    return ResolvedGasData(
      budget: BigInt.parse(gp.budget.toString()),
      price: gp.hasPrice() ? BigInt.parse(gp.price.toString()) : null,
      payment: gp.objects
          .map((o) => SuiObjectRef(o.digest, o.objectId, o.version.toInt()))
          .toList(),
    );
  }

  @override
  Future<dynamic> getProtocolConfig([String? version]) async {
    // Returning null lets the builder fall back to its offline limit defaults.
    return null;
  }

  @override
  Future<PaginatedCoins> getCoins(
    String owner, {
    String? coinType,
    String? cursor,
    int? limit,
  }) async {
    // Used by the offline build path to pick gas payment coins (e.g. dApp
    // transactions that don't set gas explicitly).
    final page = await core.listCoins(
      owner,
      coinType: coinType ?? '0x2::sui::SUI',
      cursor: cursor == null ? null : base64Decode(cursor),
      limit: limit,
    );
    final coins = page.coins
        .map((c) => CoinStruct(
              c.coinType,
              c.coinObjectId,
              c.version.toInt(),
              c.digest,
              c.balance.toString(),
              '',
            ))
        .toList();
    return PaginatedCoins(coins, page.cursor, page.hasNextPage);
  }

  @override
  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(
    T tx, {
    String? signerAddress,
  }) async {
    // The builder passes already-built TransactionData bytes here to estimate a
    // gas budget; simulate them and surface the gas cost + status.
    final sim = await core.simulateTransaction(tx as Uint8List);
    final effects = sim.transaction.effects;
    final st = effects.status;
    final g = effects.gasUsed;
    const zero =
        '0x0000000000000000000000000000000000000000000000000000000000000000';
    return DryRunTransactionBlockResponse.fromJson({
      'effects': {
        'messageVersion': 'v1',
        'status': {
          'status': st.success ? 'success' : 'failure',
          if (!st.success) 'error': st.error.description,
        },
        'gasUsed': {
          'computationCost': g.computationCost.toInt().toString(),
          'storageCost': g.storageCost.toInt().toString(),
          'storageRebate': g.storageRebate.toInt().toString(),
          'nonRefundableStorageFee': '0',
        },
        'transactionDigest': '',
        'gasObject': {
          'owner': {'AddressOwner': zero},
          'reference': {
            'objectId': zero,
            'version': 0,
            'digest': '11111111111111111111111111111111',
          }
        },
      },
    });
  }
}
