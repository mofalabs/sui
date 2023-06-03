import 'dart:convert';

import 'package:bcs/bcs.dart';

void registerBCSTypes() {

  BCS.registerVectorType('vector<u8>', 'u8');
  BCS.registerVectorType('vector<u64>', 'u64');
  BCS.registerVectorType('vector<u128>', 'u128');
  BCS.registerVectorType('vector<vector<u8>>', 'vector<u8>');
  BCS.registerAddressType('ObjectID', 20);
  BCS.registerAddressType('SuiAddress', 20);
  BCS.registerAddressType('address', 20);
  BCS.registerType(
    'utf8string',
    (writer, str) {
      final bytes = utf8.encode(str);
      return writer.writeVec(bytes, (writer, el, _a, _b) => writer.write8(el));
    },
    (reader) {
      final bytes = reader.readVec((reader, _a, _b) => reader.read8()).cast<int>();
      return utf8.decode(bytes);
    }
  );
  BCS.registerType(
    'ObjectDigest',
    (writer, str) {
      final bytes = base64Decode(str);
      return writer.writeVec(bytes, (writer, el, _a, _b) => writer.write8(el));
    },
    (reader) {
      final bytes = reader.readVec((reader, _a, _b) => reader.read8()).cast<int>();
      return base64Encode(bytes);
    }
  );

  BCS.registerStructType('SuiObjectRef', {
    'objectId': 'ObjectID',
    'version': 'u64',
    'digest': 'ObjectDigest',
  });

  BCS.registerStructType('TransferObjectTx', {
    'recipient': 'SuiAddress',
    'object_ref': 'SuiObjectRef',
  });

  BCS
    .registerVectorType('vector<SuiAddress>', 'SuiAddress')
    .registerVectorType('vector<SuiObjectRef>', 'SuiObjectRef')
    .registerStructType('PayTx', {
      'coins': 'vector<SuiObjectRef>',
      'recipients': 'vector<SuiAddress>',
      'amounts': 'vector<u64>',
    });

  BCS.registerEnumType('Option<u64>', {
    'None': null,
    'Some': 'u64',
  });

  BCS.registerStructType('TransferSuiTx', {
    'recipient': 'SuiAddress',
    'amount': 'Option<u64>',
  });

  BCS.registerStructType('PublishTx', {
    'modules': 'vector<vector<u8>>',
  });

  BCS
    .registerStructType('SharedObjectRef', {
      'objectId': 'ObjectID',
      'initialSharedVersion': 'u64',
    })
    .registerEnumType('ObjectArg', {
      'ImmOrOwned': 'SuiObjectRef',
      'Shared': 'SharedObjectRef',
    })
    .registerVectorType('vector<ObjectArg>', 'ObjectArg')
    .registerEnumType('CallArg', {
      'Pure': 'vector<u8>',
      'Object': 'ObjectArg',
      'ObjVec': 'vector<ObjectArg>',
    });

  BCS
    .registerEnumType('TypeTag', {
      'bool': null,
      'u8': null,
      'u64': null,
      'u128': null,
      'address': null,
      'signer': null,
      'vector': 'TypeTag',
      'struct': 'StructTag',
    })
    .registerVectorType('vector<TypeTag>', 'TypeTag')
    .registerStructType('StructTag', {
      'address': 'SuiAddress',
      'module': 'string',
      'name': 'string',
      'typeParams': 'vector<TypeTag>',
    });

  BCS
    .registerVectorType('vector<CallArg>', 'CallArg')
    .registerStructType('MoveCallTx', {
      'package': 'SuiObjectRef',
      'module': 'string',
      'function': 'string',
      'typeArguments': 'vector<TypeTag>',
      'arguments': 'vector<CallArg>',
    });

  BCS.registerEnumType('Transaction', {
    'TransferObject': 'TransferObjectTx',
    'Publish': 'PublishTx',
    'Call': 'MoveCallTx',
    'TransferSui': 'TransferSuiTx',
    'Pay': 'PayTx',
  });

  BCS
    .registerVectorType('vector<Transaction>', 'Transaction')
    .registerEnumType('TransactionKind', {
      'Single': 'Transaction',
      'Batch': 'vector<Transaction>',
    });

  BCS.registerStructType('TransactionData', {
    'kind': 'TransactionKind',
    'sender': 'SuiAddress',
    'gasPayment': 'SuiObjectRef',
    'gasPrice': 'u64',
    'gasBudget': 'u64',
  });

}
