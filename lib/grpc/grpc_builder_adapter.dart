import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:dio/dio.dart';
import '../utils/proto_int.dart';
import '../client/errors.dart';

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
class GrpcBuilderAdapter
    implements
        TransactionBuilderClient,
        TransactionNameResolver,
        TransactionFinalizer,
        TransactionKindResolver {
  GrpcBuilderAdapter(this.core, {this.cancelToken});

  final GrpcCoreClient core;
  final CancelToken? cancelToken;

  @override
  Future<String> resolveType(String type) =>
      core.resolveType(type, cancelToken: cancelToken);
  @override
  Future<String> resolvePackage(String package) =>
      core.resolvePackage(package, cancelToken: cancelToken);

  @override
  Future<void> finalizeTransaction(TransactionBlockDataBuilder data) async {
    if (data.gasData.payment?.isEmpty != true || data.expiration != null) {
      return;
    }
    final epoch = await core.getEpoch(
      readMask: const ['epoch'],
      cancelToken: cancelToken,
    );
    await _setAddressBalanceExpiration(data, epoch.epoch.toInt());
  }

  Future<void> _setAddressBalanceExpiration(
    TransactionBlockDataBuilder data,
    int epoch,
  ) async {
    data.expiration = TransactionExpiration(
      validDuring: {
        'minEpoch': epoch.toString(),
        'maxEpoch': (epoch + 1).toString(),
        'minTimestamp': null,
        'maxTimestamp': null,
        'chain': await core.getChainIdentifier(cancelToken: cancelToken),
        'nonce': Random.secure().nextInt(0x100000000),
      },
    );
  }

  @override
  Future<List<SuiObjectResponse>> multiGetObjects(
    List<String> objectIds, {
    SuiObjectDataOptions? options,
  }) async {
    final results = await core.getObjects(
      objectIds,
      cancelToken: cancelToken,
      readMask: [
        'object_id',
        'version',
        'digest',
        'owner',
        'object_type',
        if (options?.showBcs == true || options?.showContent == true)
          'contents',
      ],
    );
    return results.map((r) {
      if (r.hasError()) {
        return SuiObjectResponse.fromJson({
          'error': {'code': 'notExists', 'object_id': null},
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
          if (options?.showBcs == true)
            'bcs': {
              'dataType': 'moveObject',
              'type': o.objectType,
              'hasPublicTransfer': false,
              'version': o.version.toInt(),
              'bcsBytes': base64Encode(o.contents.value),
            },
        },
      });
    }).toList();
  }

  dynamic _ownerJson(Owner? owner) {
    if (owner == null) return null;
    return switch (owner.kind) {
      Owner_OwnerKind.ADDRESS => {'AddressOwner': owner.address},
      // Party (consensus-address-owned) objects, e.g. coin_registry
      // Currencies, are consensus objects: transaction inputs must use the
      // SharedObject form with the owner's start version — mirroring the TS
      // core-resolver, which treats ConsensusAddressOwner like Shared.
      Owner_OwnerKind.CONSENSUS_ADDRESS => {
        'Shared': {'initial_shared_version': owner.version.toInt()},
      },
      Owner_OwnerKind.OBJECT => {'ObjectOwner': owner.address},
      Owner_OwnerKind.SHARED => {
        'Shared': {'initial_shared_version': owner.version.toInt()},
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
    final fn = await core.getFunction(
      package,
      moduleName,
      functionName,
      cancelToken: cancelToken,
    );
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
      'Vector': _mapSignatureBody(b.typeParameterInstantiation.first),
    },
    OpenSignatureBody_Type.DATATYPE => _datatypeStruct(b),
    OpenSignatureBody_Type.TYPE_PARAMETER => {'TypeParameter': b.typeParameter},
    _ => throw ArgumentError('Unsupported Move type: ${b.type}'),
  };

  Map<String, dynamic> _datatypeStruct(OpenSignatureBody b) {
    final parts = b.typeName.split('::');
    return {
      'Struct': {
        'address': parts.isNotEmpty ? parts[0] : '',
        'module': parts.length > 1 ? parts[1] : '',
        'name': parts.length > 2 ? parts[2] : '',
        'typeArguments': b.typeParameterInstantiation
            .map(_mapSignatureBody)
            .toList(),
      },
    };
  }

  @override
  Future<BigInt> getReferenceGasPrice() async =>
      uint64ToBigInt(await core.getReferenceGasPrice(cancelToken: cancelToken));

  @override
  Future<void> resolveTransactionKind(TransactionBlockDataBuilder data) async {
    final sender = data.sender;
    final request = transactionDataToGrpcTransaction(data, includeGas: false);
    // The node needs a placeholder for resolution, but it must not become the
    // sender of a transaction that the caller intends to sponsor later.
    if (!request.hasSender()) request.sender = '0x${'0' * 64}';
    final response = await core.simulateStructured(
      request,
      doGasSelection: false,
      checksEnabled: false,
      cancelToken: cancelToken,
      readMask: const ['transaction.transaction.kind'],
    );
    if (!response.transaction.transaction.hasKind()) {
      throw const SuiSimulationException(
        'Simulation did not return a transaction kind',
      );
    }
    final resolved = grpcTransactionToTransactionData(
      response.transaction.transaction,
    );
    data.inputs = resolved.inputs!;
    data.commands = resolved.commands!;
    data.sender = sender;
  }

  @override
  Future<ResolvedGasData?> resolveGasData(
    TransactionBlockDataBuilder data,
  ) async {
    // Structured message (not BCS, which cannot express an unset budget) +
    // `doGasSelection` — mirrors Mysten's TS gRPC `resolveTransactionPlugin`.
    // Omit any preset (e.g. dApp-supplied) budget so the node estimates it
    // rather than selecting coins to satisfy that budget.
    final grpcTx = transactionDataToGrpcTransaction(data, includeBudget: false);
    final sim = await core.simulateStructured(
      grpcTx,
      doGasSelection: true,
      cancelToken: cancelToken,
      readMask: const [
        'transaction.transaction.gas_payment',
        'transaction.transaction.expiration',
        'transaction.transaction.kind',
        'transaction.effects.status',
        'transaction.effects.epoch',
      ],
    );
    final status = sim.transaction.effects.status;
    if (!status.success) {
      throw SuiSimulationException(
        'Gas resolution simulation failed: ${status.error.description}',
      );
    }
    final gp = sim.transaction.transaction.gasPayment;
    final returned = sim.transaction.transaction;
    if (returned.hasKind()) {
      final resolvedData = grpcTransactionToTransactionData(returned);
      data.inputs = resolvedData.inputs!;
      data.commands = resolvedData.commands!;
    }
    if (returned.hasExpiration()) {
      data.expiration = transactionExpirationFromGrpc(returned.expiration);
    }
    final budget = uint64ToBigInt(gp.budget);
    if (gp.objects.isEmpty) {
      if (data.expiration == null) {
        await _setAddressBalanceExpiration(
          data,
          sim.transaction.effects.epoch.toInt(),
        );
      }
    }
    return ResolvedGasData(
      budget: budget,
      price: gp.hasPrice() ? uint64ToBigInt(gp.price) : null,
      expiration: data.expiration,
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
      cancelToken: cancelToken,
    );
    final coins = page.coins
        .map(
          (c) => CoinStruct(
            c.coinType,
            c.coinObjectId,
            c.version.toInt(),
            c.digest,
            c.balance.toString(),
            '',
          ),
        )
        .toList();
    return PaginatedCoins(coins, page.cursor, page.hasNextPage);
  }

  @override
  Future<CoinBalanceBreakdown> getBalanceBreakdown(
    String owner,
    String coinType,
  ) async {
    // The gRPC Balance message carries the total plus its address-balance and
    // coin-object components, which the CoinWithBalance resolver needs to pick
    // between the gasless (address-balance) and coin-object sources.
    final b = await core.getBalance(
      owner,
      coinType: coinType,
      cancelToken: cancelToken,
    );
    return CoinBalanceBreakdown(
      total: uint64ToBigInt(b.balance),
      addressBalance: uint64ToBigInt(b.addressBalance),
      coinBalance: uint64ToBigInt(b.coinBalance),
    );
  }

  @override
  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(
    T tx, {
    String? signerAddress,
  }) async {
    // The builder passes already-built TransactionData bytes here to estimate a
    // gas budget; simulate them and surface the gas cost + status.
    final sim = await core.simulateTransaction(
      tx as Uint8List,
      cancelToken: cancelToken,
    );
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
          },
        },
      },
    });
  }
}
