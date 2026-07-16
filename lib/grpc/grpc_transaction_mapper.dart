import 'dart:convert';

import 'package:fixnum/fixnum.dart';

import '../builder/transaction_block_data.dart';
import 'proto/sui/rpc/v2/argument.pb.dart';
import 'proto/sui/rpc/v2/input.pb.dart';
import 'proto/sui/rpc/v2/object_reference.pb.dart';
import 'proto/sui/rpc/v2/transaction.pb.dart';

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
          .map((ref) => ObjectReference(
                objectId: ref.objectId,
                version: Int64(ref.version),
                digest: ref.digest,
              ))
          .toList(),
    );
    final owner = gas.owner ?? data.sender;
    if (owner != null) payment.owner = owner;
    if (gas.price != null) payment.price = Int64.parseInt(gas.price.toString());
    if (gas.budget != null) {
      payment.budget = Int64.parseInt(gas.budget.toString());
    }
    tx.gasPayment = payment;
  }

  return tx;
}

Argument _argToGrpcArgument(dynamic arg) {
  final kind = arg['\$kind'];
  switch (kind) {
    case 'GasCoin':
      return Argument(kind: Argument_ArgumentKind.GAS);
    case 'Input':
      return Argument(kind: Argument_ArgumentKind.INPUT, input: arg['Input']);
    case 'Result':
      return Argument(
          kind: Argument_ArgumentKind.RESULT, result: arg['Result']);
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
  final kind = arg['\$kind'];
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
    default:
      throw ArgumentError(
          'Input kind "$kind" must be resolved before gRPC conversion: $arg');
  }
}

Command _commandToGrpcCommand(Map<dynamic, dynamic> cmd) {
  final kind = cmd['\$kind'];
  switch (kind) {
    case 'MoveCall':
      final c = cmd['MoveCall'] as Map;
      return Command(
        moveCall: MoveCall(
          package: c['package'],
          module: c['module'],
          function: c['function'],
          typeArguments:
              (c['typeArguments'] as List? ?? const []).cast<String>(),
          arguments:
              (c['arguments'] as List? ?? const []).map(_argToGrpcArgument),
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
