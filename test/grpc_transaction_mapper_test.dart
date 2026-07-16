import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/grpc/grpc_transaction_mapper.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/argument.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/input.pb.dart';

Map<String, dynamic> pureArg(int index) =>
    {'\$kind': 'Input', 'Input': index, 'type': 'pure'};
Map<String, dynamic> gasArg() => {'\$kind': 'GasCoin', 'GasCoin': true};
Map<String, dynamic> resultArg(int i) => {'\$kind': 'Result', 'Result': i};
Map<String, dynamic> nestedArg(int i, int j) => {
      '\$kind': 'NestedResult',
      'NestedResult': [i, j]
    };

void main() {
  test('maps every input / command / argument variant to gRPC proto', () {
    final data = TransactionBlockDataBuilder();
    data.sender =
        '0x0000000000000000000000000000000000000000000000000000000000000abc';

    final pureBytes = base64Encode([1, 2, 3, 4]);
    data.inputs = [
      {
        '\$kind': 'Pure',
        'Pure': {'bytes': pureBytes}
      },
      {
        '\$kind': 'Object',
        'Object': {
          '\$kind': 'ImmOrOwnedObject',
          'ImmOrOwnedObject': {
            'digest': 'DiGeSt1',
            'version': 7,
            'objectId': '0x111'
          }
        }
      },
      {
        '\$kind': 'Object',
        'Object': {
          '\$kind': 'SharedObject',
          'SharedObject': {
            'mutable': true,
            'initialSharedVersion': 3,
            'objectId': '0x222'
          }
        }
      },
      {
        '\$kind': 'Object',
        'Object': {
          '\$kind': 'Receiving',
          'Receiving': {'digest': 'DiGeSt2', 'version': 9, 'objectId': '0x333'}
        }
      },
    ];

    data.commands = [
      {
        '\$kind': 'MoveCall',
        'MoveCall': {
          'package': '0x2',
          'module': 'coin',
          'function': 'value',
          'typeArguments': ['0x2::sui::SUI'],
          'arguments': [pureArg(0), gasArg(), nestedArg(1, 2)],
        }
      },
      {
        '\$kind': 'SplitCoins',
        'SplitCoins': {
          'coin': gasArg(),
          'amounts': [pureArg(0)],
        }
      },
      {
        '\$kind': 'TransferObjects',
        'TransferObjects': {
          'objects': [resultArg(1)],
          'address': pureArg(0),
        }
      },
      {
        '\$kind': 'MergeCoins',
        'MergeCoins': {
          'destination': resultArg(1),
          'sources': [resultArg(2), gasArg()],
        }
      },
      {
        '\$kind': 'MakeMoveVec',
        'MakeMoveVec': {
          'type': '0x2::sui::SUI',
          'elements': [resultArg(1), resultArg(2)],
        }
      },
      {
        '\$kind': 'Publish',
        'Publish': {
          'modules': [
            base64Encode([9, 9])
          ],
          'dependencies': ['0x1', '0x2'],
        }
      },
      {
        '\$kind': 'Upgrade',
        'Upgrade': {
          'modules': [
            base64Encode([8, 8])
          ],
          'dependencies': ['0x1'],
          'package': '0xabc',
          'ticket': resultArg(0),
        }
      },
    ];

    final tx = transactionDataToGrpcTransaction(data);

    // Sender + kind
    expect(tx.sender, data.sender);
    final pt = tx.kind.programmableTransaction;

    // Inputs
    expect(pt.inputs.length, 4);
    expect(pt.inputs[0].kind, Input_InputKind.PURE);
    expect(pt.inputs[0].pure, [1, 2, 3, 4]);
    expect(pt.inputs[1].kind, Input_InputKind.IMMUTABLE_OR_OWNED);
    expect(pt.inputs[1].objectId, '0x111');
    expect(pt.inputs[1].version.toInt(), 7);
    expect(pt.inputs[1].digest, 'DiGeSt1');
    expect(pt.inputs[2].kind, Input_InputKind.SHARED);
    expect(pt.inputs[2].version.toInt(), 3);
    expect(pt.inputs[2].mutable, true);
    expect(pt.inputs[3].kind, Input_InputKind.RECEIVING);
    expect(pt.inputs[3].version.toInt(), 9);

    // Commands
    expect(pt.commands.length, 7);

    final mv = pt.commands[0].moveCall;
    expect(mv.package, '0x2');
    expect(mv.module, 'coin');
    expect(mv.function, 'value');
    expect(mv.typeArguments, ['0x2::sui::SUI']);
    expect(mv.arguments[0].kind, Argument_ArgumentKind.INPUT);
    expect(mv.arguments[0].input, 0);
    expect(mv.arguments[1].kind, Argument_ArgumentKind.GAS);
    expect(mv.arguments[2].kind, Argument_ArgumentKind.RESULT);
    expect(mv.arguments[2].result, 1);
    expect(mv.arguments[2].subresult, 2);

    final sc = pt.commands[1].splitCoins;
    expect(sc.coin.kind, Argument_ArgumentKind.GAS);
    expect(sc.amounts.length, 1);

    final to = pt.commands[2].transferObjects;
    expect(to.objects[0].kind, Argument_ArgumentKind.RESULT);
    expect(to.objects[0].result, 1);
    expect(to.address.kind, Argument_ArgumentKind.INPUT);

    final mc = pt.commands[3].mergeCoins;
    expect(mc.coin.result, 1);
    expect(mc.coinsToMerge.length, 2);
    expect(mc.coinsToMerge[1].kind, Argument_ArgumentKind.GAS);

    final mmv = pt.commands[4].makeMoveVector;
    expect(mmv.elementType, '0x2::sui::SUI');
    expect(mmv.elements.length, 2);

    final pub = pt.commands[5].publish;
    expect(pub.modules.first, [9, 9]);
    expect(pub.dependencies, ['0x1', '0x2']);

    final up = pt.commands[6].upgrade;
    expect(up.modules.first, [8, 8]);
    expect(up.package, '0xabc');
    expect(up.ticket.kind, Argument_ArgumentKind.RESULT);
  });
}
