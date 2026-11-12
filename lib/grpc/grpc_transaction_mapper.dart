import 'dart:convert';

import 'package:fixnum/fixnum.dart';

import '../builder/transaction_block_data.dart' hide TransactionExpiration;
import '../builder/transaction_block_data.dart' as builder;
import '../bcs/sui_bcs.dart';
import '../types/objects.dart';
import '../utils/proto_int.dart';
import 'proto/google/protobuf/timestamp.pb.dart';
import 'proto/sui/rpc/v2/argument.pb.dart';
import 'proto/sui/rpc/v2/input.pb.dart';
import 'proto/sui/rpc/v2/object_reference.pb.dart';
import 'proto/sui/rpc/v2/transaction.pb.dart';

/// The variant tag of a tagged-union node (input / argument / command).
///
/// The builder's own nodes carry an explicit `$kind`, but a transaction parsed
/// from a dApp's serialized JSON (`@mysten/sui`'s `toJSON()`) uses the
/// unwrapped form — e.g. `{Pure: {...}}`, `{Input: 0}`, `{MoveCall: {...}}` —
/// with no `$kind` field. Fall back to the sole non-`$kind` key so both forms
/// map correctly.
///
/// [node] is `dynamic`, not `Map`: builder arguments can be a [TransactionResult]
/// (a `Result`/`NestedResult` that behaves like a map via `operator []` but is
/// not one), so a typed `Map` parameter would fail its implicit downcast.
String? _kindOf(dynamic node) {
  final kind = node[r'$kind'];
  if (kind is String) return kind;
  if (node is Map) {
    return node.keys.cast<String>().firstWhere(
      (k) => k != r'$kind',
      orElse: () => '',
    );
  }
  return null;
}

/// Maps the transaction builder's internal (`$kind`-tagged map) representation
/// to the gRPC structured `Transaction` message, so it can be simulated with
/// the gas payment/budget left unset for server-side gas selection — mirroring
/// Mysten's TS `transactionDataToGrpcTransaction`.
///
/// Inputs must already be resolved (no `UnresolvedPure` / `UnresolvedObject`);
/// `Transaction.build`'s `_prepare` does that before gas resolution.
Transaction transactionDataToGrpcTransaction(
  TransactionBlockDataBuilder data, {
  bool includeGas = true,
  bool includeBudget = true,
}) {
  final inputs = (data.inputs).map(_callArgToGrpcInput).toList();
  final commands = (data.commands).map(_commandToGrpcCommand).toList();

  final tx = Transaction(
    version: 1,
    kind: TransactionKind(
      programmableTransaction: ProgrammableTransaction(
        inputs: inputs,
        commands: commands,
      ),
    ),
  );

  if (data.sender != null) {
    tx.sender = data.sender!;
  }

  if (includeGas) {
    final gas = data.gasData;
    final payment = GasPayment(
      objects: (gas.payment ?? const [])
          .map(
            (ref) => ObjectReference(
              objectId: ref.objectId,
              version: Int64(ref.version),
              digest: ref.digest,
            ),
          )
          .toList(),
    );
    final owner = gas.owner ?? data.sender;
    if (owner != null) payment.owner = owner;
    if (gas.price != null) payment.price = Int64.parseInt(gas.price.toString());
    // For server-side gas selection (`doGasSelection`) the budget is omitted so
    // the node estimates it from the simulation. Honoring a caller/dApp-supplied
    // budget here would make the node select coins to satisfy that budget (often
    // a conservative 50_000_000 ceiling), which fails for accounts holding less
    // than it even though the transaction's real gas is tiny.
    if (includeBudget && gas.budget != null) {
      payment.budget = Int64.parseInt(gas.budget.toString());
    }
    tx.gasPayment = payment;
  }

  final expiration = data.expiration?.toJson();
  if (expiration != null && expiration['Epoch'] != null) {
    tx.expiration = TransactionExpiration(
      kind: TransactionExpiration_TransactionExpirationKind.EPOCH,
      epoch: Int64.parseInt(expiration['Epoch'].toString()),
    );
  } else if (expiration != null &&
      (expiration['ValidDuring'] != null || expiration['Validity'] != null)) {
    final isValidity = expiration['Validity'] != null;
    final vd = (expiration['Validity'] ?? expiration['ValidDuring']) as Map;
    final allowed = vd['allowedProposers'] as Map?;
    if (allowed != null) {
      SuiBcs.validateAllowedProposers(
        List<int>.from(allowed['proposers'] as List),
      );
    }
    tx.expiration = TransactionExpiration(
      kind: isValidity
          ? TransactionExpiration_TransactionExpirationKind.VALIDITY
          : TransactionExpiration_TransactionExpirationKind.VALID_DURING,
      minEpoch: vd['minEpoch'] == null
          ? null
          : Int64.parseInt('${vd['minEpoch']}'),
      // The structured message reuses `epoch` as the ValidDuring max epoch.
      epoch: vd['maxEpoch'] == null
          ? null
          : Int64.parseInt('${vd['maxEpoch']}'),
      chain: vd['chain'] as String?,
      nonce: vd['nonce'] as int?,
      minTimestamp: _millisecondsToTimestamp(vd['minTimestamp']),
      maxTimestamp: _millisecondsToTimestamp(vd['maxTimestamp']),
      allowedProposers: allowed == null
          ? null
          : AllowedProposers(
              epoch: Int64.parseInt(allowed['epoch'].toString()),
              proposers: List<int>.from(allowed['proposers'] as List),
            ),
    );
  } else if (expiration != null) {
    tx.expiration = TransactionExpiration(
      kind: TransactionExpiration_TransactionExpirationKind.NONE,
    );
  }

  return tx;
}

Timestamp? _millisecondsToTimestamp(dynamic value) {
  if (value == null) return null;
  final milliseconds = BigInt.parse(value.toString());
  return Timestamp(
    seconds: Int64.parseInt((milliseconds ~/ BigInt.from(1000)).toString()),
    nanos: (milliseconds % BigInt.from(1000)).toInt() * 1000000,
  );
}

/// Converts resolved structured transactions into the builder's Dart model.
/// Unknown variants fail instead of silently discarding transaction restrictions.
TransactionData grpcTransactionToTransactionData(Transaction transaction) {
  if (!transaction.kind.hasProgrammableTransaction()) {
    throw const FormatException(
      'Only programmable transactions can be rebuilt',
    );
  }
  final programmable = transaction.kind.programmableTransaction;
  final gas = transaction.gasPayment;
  return TransactionData(
    version: 2,
    sender: transaction.hasSender() ? transaction.sender : null,
    expiration: transaction.hasExpiration()
        ? transactionExpirationFromGrpc(transaction.expiration)
        : null,
    gasData: GasConfig(
      owner: gas.hasOwner() ? gas.owner : null,
      budget: gas.hasBudget() ? uint64ToBigInt(gas.budget) : null,
      price: gas.hasPrice() ? uint64ToBigInt(gas.price) : null,
      payment: transaction.hasGasPayment()
          ? gas.objects
                .map(
                  (object) => SuiObjectRef(
                    object.digest,
                    object.objectId,
                    object.version.toInt(),
                  ),
                )
                .toList()
          : null,
    ),
    inputs: programmable.inputs.map(_inputFromGrpc).toList(),
    commands: programmable.commands.map(_commandFromGrpc).toList(),
  );
}

Map<String, dynamic> _inputFromGrpc(Input input) {
  switch (input.kind) {
    case Input_InputKind.PURE:
      return {
        'Pure': {'bytes': base64Encode(input.pure)},
      };
    case Input_InputKind.IMMUTABLE_OR_OWNED:
    case Input_InputKind.RECEIVING:
      final kind = input.kind == Input_InputKind.RECEIVING
          ? 'Receiving'
          : 'ImmOrOwnedObject';
      return {
        'Object': {
          kind: {
            'objectId': input.objectId,
            'version': input.version.toString(),
            'digest': input.digest,
          },
        },
      };
    case Input_InputKind.SHARED:
      return {
        'Object': {
          'SharedObject': {
            'objectId': input.objectId,
            'initialSharedVersion': input.version.toString(),
            'mutable': input.mutable,
          },
        },
      };
    case Input_InputKind.FUNDS_WITHDRAWAL:
      final value = input.fundsWithdrawal;
      final Map<String, dynamic> from;
      switch (value.source) {
        case FundsWithdrawal_Source.SENDER:
          from = {'Sender': true};
        case FundsWithdrawal_Source.SPONSOR:
          from = {'Sponsor': true};
        case FundsWithdrawal_Source.SENDER_ALLOWANCE:
          if (!value.hasFunder() || !value.hasAllowance()) {
            throw const FormatException(
              'Allowance withdrawal metadata missing',
            );
          }
          from = {
            'SenderAllowance': {
              'funder': value.funder,
              'allowance': value.allowance,
            },
          };
        default:
          throw FormatException('Unknown withdrawal source: ${value.source}');
      }
      return {
        'FundsWithdrawal': {
          'reservation': {
            'MaxAmountU64': uint64ToBigInt(value.amount).toString(),
          },
          'typeArg': {'Balance': value.coinType},
          'withdrawFrom': from,
        },
      };
    default:
      throw FormatException('Unknown gRPC input kind: ${input.kind}');
  }
}

Map<String, dynamic> _argumentFromGrpc(Argument argument) =>
    switch (argument.kind) {
      Argument_ArgumentKind.GAS => {'GasCoin': true},
      Argument_ArgumentKind.INPUT => {'Input': argument.input},
      Argument_ArgumentKind.RESULT =>
        argument.hasSubresult()
            ? {
                'NestedResult': [argument.result, argument.subresult],
              }
            : {'Result': argument.result},
      _ => throw FormatException(
        'Unknown gRPC argument kind: ${argument.kind}',
      ),
    };

Map<String, dynamic> _commandFromGrpc(Command command) {
  if (command.hasMoveCall()) {
    final call = command.moveCall;
    return {
      'MoveCall': {
        'package': call.package,
        'module': call.module,
        'function': call.function,
        'typeArguments': call.typeArguments.toList(),
        'arguments': call.arguments.map(_argumentFromGrpc).toList(),
      },
    };
  }
  if (command.hasTransferObjects()) {
    return {
      'TransferObjects': {
        'objects': command.transferObjects.objects
            .map(_argumentFromGrpc)
            .toList(),
        'address': _argumentFromGrpc(command.transferObjects.address),
      },
    };
  }
  if (command.hasSplitCoins()) {
    return {
      'SplitCoins': {
        'coin': _argumentFromGrpc(command.splitCoins.coin),
        'amounts': command.splitCoins.amounts.map(_argumentFromGrpc).toList(),
      },
    };
  }
  if (command.hasMergeCoins()) {
    return {
      'MergeCoins': {
        'destination': _argumentFromGrpc(command.mergeCoins.coin),
        'sources': command.mergeCoins.coinsToMerge
            .map(_argumentFromGrpc)
            .toList(),
      },
    };
  }
  if (command.hasPublish()) {
    return {
      'Publish': {
        'modules': command.publish.modules.map(base64Encode).toList(),
        'dependencies': command.publish.dependencies.toList(),
      },
    };
  }
  if (command.hasMakeMoveVector()) {
    return {
      'MakeMoveVec': {
        'type': command.makeMoveVector.hasElementType()
            ? command.makeMoveVector.elementType
            : null,
        'elements': command.makeMoveVector.elements
            .map(_argumentFromGrpc)
            .toList(),
      },
    };
  }
  if (command.hasUpgrade()) {
    return {
      'Upgrade': {
        'modules': command.upgrade.modules.map(base64Encode).toList(),
        'dependencies': command.upgrade.dependencies.toList(),
        'package': command.upgrade.package,
        'ticket': _argumentFromGrpc(command.upgrade.ticket),
      },
    };
  }
  throw const FormatException('Unknown gRPC transaction command');
}

/// Preserves every expiration restriction returned by simulation.
builder.TransactionExpiration transactionExpirationFromGrpc(
  TransactionExpiration value,
) {
  switch (value.kind) {
    case TransactionExpiration_TransactionExpirationKind.NONE:
      return builder.TransactionExpiration();
    case TransactionExpiration_TransactionExpirationKind.EPOCH:
      return builder.TransactionExpiration(epoch: value.epoch.toInt());
    case TransactionExpiration_TransactionExpirationKind.VALID_DURING:
    case TransactionExpiration_TransactionExpirationKind.VALIDITY:
      String milliseconds(Timestamp timestamp) =>
          (BigInt.parse(timestamp.seconds.toString()) * BigInt.from(1000) +
                  BigInt.from(timestamp.nanos ~/ 1000000))
              .toString();
      final window = <String, dynamic>{
        'minEpoch': value.hasMinEpoch()
            ? uint64ToBigInt(value.minEpoch).toString()
            : null,
        'maxEpoch': value.hasEpoch()
            ? uint64ToBigInt(value.epoch).toString()
            : null,
        'minTimestamp': value.hasMinTimestamp()
            ? milliseconds(value.minTimestamp)
            : null,
        'maxTimestamp': value.hasMaxTimestamp()
            ? milliseconds(value.maxTimestamp)
            : null,
        'chain': value.chain,
        'nonce': value.nonce,
      };
      if (value.kind ==
          TransactionExpiration_TransactionExpirationKind.VALIDITY) {
        window['allowedProposers'] = value.hasAllowedProposers()
            ? {
                'epoch': uint64ToBigInt(
                  value.allowedProposers.epoch,
                ).toString(),
                'proposers': value.allowedProposers.proposers.toList(),
              }
            : null;
        return builder.TransactionExpiration.fromJson({'Validity': window});
      }
      return builder.TransactionExpiration(validDuring: window);
    default:
      throw FormatException(
        'Unsupported gRPC transaction expiration: ${value.kind}',
      );
  }
}

Argument _argToGrpcArgument(dynamic arg) {
  final kind = _kindOf(arg);
  switch (kind) {
    case 'GasCoin':
      return Argument(kind: Argument_ArgumentKind.GAS);
    case 'Input':
      return Argument(kind: Argument_ArgumentKind.INPUT, input: arg['Input']);
    case 'Result':
      return Argument(
        kind: Argument_ArgumentKind.RESULT,
        result: arg['Result'],
      );
    case 'NestedResult':
      final nr = arg['NestedResult'] as List;
      return Argument(
        kind: Argument_ArgumentKind.RESULT,
        result: nr[0],
        subresult: nr[1],
      );
    default:
      throw ArgumentError('Unknown Argument kind: $arg');
  }
}

Input _callArgToGrpcInput(Map<String, dynamic> arg) {
  final kind = _kindOf(arg);
  switch (kind) {
    case 'Pure':
      return Input(
        kind: Input_InputKind.PURE,
        pure: base64Decode(arg['Pure']['bytes'] as String),
      );
    case 'Object':
      final obj = arg['Object'] as Map;
      if (obj['ImmOrOwnedObject'] != null) {
        final o = obj['ImmOrOwnedObject'] as Map;
        return Input(
          kind: Input_InputKind.IMMUTABLE_OR_OWNED,
          objectId: o['objectId'],
          version: Int64.parseInt(o['version'].toString()),
          digest: o['digest'],
        );
      } else if (obj['SharedObject'] != null) {
        final o = obj['SharedObject'] as Map;
        return Input(
          kind: Input_InputKind.SHARED,
          objectId: o['objectId'],
          version: Int64.parseInt(o['initialSharedVersion'].toString()),
          mutable: o['mutable'] ?? false,
        );
      } else if (obj['Receiving'] != null) {
        final o = obj['Receiving'] as Map;
        return Input(
          kind: Input_InputKind.RECEIVING,
          objectId: o['objectId'],
          version: Int64.parseInt(o['version'].toString()),
          digest: o['digest'],
        );
      }
      throw ArgumentError('Unknown Object input kind: $arg');
    case 'FundsWithdrawal':
      // Address-balance withdrawal (gasless stablecoin transfer). The BCS
      // reservation/typeArg/withdrawFrom shape collapses to the structured
      // message's (amount, coinType, source).
      final fw = arg['FundsWithdrawal'] as Map;
      final amount = (fw['reservation'] as Map)['MaxAmountU64'].toString();
      final coinType = (fw['typeArg'] as Map)['Balance'] as String;
      final from = fw['withdrawFrom'] as Map;
      final allowance = from['SenderAllowance'] as Map?;
      return Input(
        kind: Input_InputKind.FUNDS_WITHDRAWAL,
        fundsWithdrawal: FundsWithdrawal(
          amount: Int64.parseInt(amount),
          coinType: coinType,
          funder: allowance?['funder'] as String?,
          allowance: allowance?['allowance'] as String?,
          source: allowance != null
              ? FundsWithdrawal_Source.SENDER_ALLOWANCE
              : from.containsKey('Sponsor')
              ? FundsWithdrawal_Source.SPONSOR
              : FundsWithdrawal_Source.SENDER,
        ),
      );
    default:
      throw ArgumentError(
        'Input kind "$kind" must be resolved before gRPC conversion: $arg',
      );
  }
}

Command _commandToGrpcCommand(Map<dynamic, dynamic> cmd) {
  final kind = _kindOf(cmd);
  switch (kind) {
    case 'MoveCall':
      final c = cmd['MoveCall'] as Map;
      return Command(
        moveCall: MoveCall(
          package: c['package'],
          module: c['module'],
          function: c['function'],
          typeArguments: (c['typeArguments'] as List? ?? const [])
              .cast<String>(),
          arguments: (c['arguments'] as List? ?? const []).map(
            _argToGrpcArgument,
          ),
        ),
      );
    case 'TransferObjects':
      final c = cmd['TransferObjects'] as Map;
      return Command(
        transferObjects: TransferObjects(
          objects: (c['objects'] as List).map(_argToGrpcArgument),
          address: _argToGrpcArgument(c['address']),
        ),
      );
    case 'SplitCoins':
      final c = cmd['SplitCoins'] as Map;
      return Command(
        splitCoins: SplitCoins(
          coin: _argToGrpcArgument(c['coin']),
          amounts: (c['amounts'] as List).map(_argToGrpcArgument),
        ),
      );
    case 'MergeCoins':
      final c = cmd['MergeCoins'] as Map;
      return Command(
        mergeCoins: MergeCoins(
          coin: _argToGrpcArgument(c['destination']),
          coinsToMerge: (c['sources'] as List).map(_argToGrpcArgument),
        ),
      );
    case 'MakeMoveVec':
      final c = cmd['MakeMoveVec'] as Map;
      return Command(
        makeMoveVector: MakeMoveVector(
          elementType: c['type'] as String?,
          elements: (c['elements'] as List).map(_argToGrpcArgument),
        ),
      );
    case 'Publish':
      final c = cmd['Publish'] as Map;
      return Command(
        publish: Publish(
          modules: (c['modules'] as List).map((m) => base64Decode(m as String)),
          dependencies: (c['dependencies'] as List).cast<String>(),
        ),
      );
    case 'Upgrade':
      final c = cmd['Upgrade'] as Map;
      return Command(
        upgrade: Upgrade(
          modules: (c['modules'] as List).map((m) => base64Decode(m as String)),
          dependencies: (c['dependencies'] as List).cast<String>(),
          package: c['package'],
          ticket: _argToGrpcArgument(c['ticket']),
        ),
      );
    default:
      throw ArgumentError('Unknown/unsupported Command kind "$kind": $cmd');
  }
}
