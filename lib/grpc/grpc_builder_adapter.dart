import '../builder/transaction_builder_client.dart';
import '../types/coins.dart';
import '../types/normalized.dart';
import '../types/objects.dart';
import '../types/transactions.dart';
import 'grpc_core_client.dart';
import 'proto/sui/rpc/v2/move_package.pb.dart';
import 'proto/sui/rpc/v2/owner.pb.dart';

/// Adapts [GrpcCoreClient] to the [TransactionBuilderClient] interface so the
/// existing [Transaction] builder can resolve objects and Move function
/// signatures over gRPC-web (enabling `moveCall` with object arguments).
///
/// Object resolution and Move-function lookup are fully implemented. Gas-coin
/// selection and budget dry-run are intentionally left to
/// `GrpcTransactionExecutor` (which sets gas explicitly and estimates the
/// budget via `simulateTransaction`), so those interface methods are not used
/// on the executor path.
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

  // --- Not used on the executor path (gas is set explicitly there). ---

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
  }) {
    throw UnsupportedError(
      'GrpcBuilderAdapter.getCoins is not implemented; set gas payment '
      'explicitly or use GrpcTransactionExecutor.signAndExecuteTransaction.',
    );
  }

  @override
  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(
    T tx, {
    String? signerAddress,
  }) {
    throw UnsupportedError(
      'GrpcBuilderAdapter.dryRunTransaction is not implemented; set a gas '
      'budget explicitly or use GrpcTransactionExecutor.signAndExecuteTransaction '
      '(which estimates the budget via simulateTransaction).',
    );
  }
}
