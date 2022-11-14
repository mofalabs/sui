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

  /**
   * Transaction type used for transferring objects.
   * For this transaction to be executed, and `SuiObjectRef` should be queried
   * upfront and used as a parameter.
   */
  // export type TransferObjectTx = {
  //   TransferObject: {
  //     recipient: string;
  //     object_ref: SuiObjectRef;
  //   };
  // };

  BCS.registerStructType('TransferObjectTx', {
    'recipient': 'SuiAddress',
    'object_ref': 'SuiObjectRef',
  });

  /**
   * Transaction type used for transferring Sui.
   */
  // export type TransferSuiTx = {
  //   TransferSui: {
  //     recipient: string;
  //     amount: { Some: number } | { None: null };
  //   };
  // };

  /**
   * Transaction type used for Pay transaction.
   */
  // export type PayTx = {
  //   Pay: {
  //     coins: SuiObjectRef[];
  //     recipients: string[];
  //     amounts: number[];
  //   };
  // };

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

  /**
   * Transaction type used for publishing Move modules to the Sui.
   * Should be already compiled using `sui-move`, example:
   * ```
   * $ sui-move build
   * $ cat build/project_name/bytecode_modules/module.mv
   * ```
   * In JS:
   * ```
   * let file = fs.readFileSync('./move/build/project_name/bytecode_modules/module.mv');
   * let bytes = Array.from(bytes);
   * let modules = [ bytes ];
   *
   * // ... publish logic ...
   * ```
   *
   * Each module should be represented as a sequence of bytes.
   */
  // export type PublishTx = {
  //   Publish: {
  //     modules: ArrayLike<ArrayLike<number>>;
  //   };
  // };

  BCS.registerStructType('PublishTx', {
    'modules': 'vector<vector<u8>>',
  });

  // ========== Move Call Tx ===========

  /**
   * A reference to a shared object.
   */
  // export type SharedObjectRef = {
  //   /** Hex code as string representing the object id */
  //   objectId: string;

  //   /** The version the object was shared at */
  //   initialSharedVersion: number;
  // };

  /**
   * An object argument.
   */
  // export type ObjectArg =
  //   | { ImmOrOwned: SuiObjectRef }
  //   | { Shared: SharedObjectRef }
  //   | { Shared_Deprecated: string };

  /**
   * An argument for the transaction. It is a 'meant' enum which expects to have
   * one of the optional properties. If not, the BCS error will be thrown while
   * attempting to form a transaction.
   *
   * Example:
   * ```js
   * let arg1: CallArg = { Object: { Shared: {
   *   objectId: '5460cf92b5e3e7067aaace60d88324095fd22944',
   *   initialSharedVersion: 1,
   * } } };
   * let arg2: CallArg = { Pure: bcs.set(bcs.STRING, 100000).toBytes() };
   * let arg3: CallArg = { Object: { ImmOrOwned: {
   *   objectId: '4047d2e25211d87922b6650233bd0503a6734279',
   *   version: 1,
   *   digest: 'bCiANCht4O9MEUhuYjdRCqRPZjr2rJ8MfqNiwyhmRgA='
   * } } };
   * ```
   *
   * For `Pure` arguments BCS is required. You must encode the values with BCS according
   * to the type required by the called function. Pure accepts only serialized values
   */
  // export type CallArg =
  //   | { Pure: ArrayLike<number> }
  //   | { Object: ObjectArg }
  //   | { ObjVec: ArrayLike<ObjectArg> };

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

  /**
   * Kind of a TypeTag which is represented by a Move type identifier.
   */
  // export type StructTag = {
  //   address: string;
  //   module: string;
  //   name: string;
  //   typeParams: TypeTag[];
  // };

  /**
   * Sui TypeTag object. A decoupled `0x...::module::Type<???>` parameter.
   */
  // export type TypeTag =
  //   | { bool: null }
  //   | { u8: null }
  //   | { u64: null }
  //   | { u128: null }
  //   | { address: null }
  //   | { signer: null }
  //   | { vector: TypeTag }
  //   | { struct: StructTag };

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

  /**
   * Transaction type used for calling Move modules' functions.
   * Should be crafted carefully, because the order of type parameters and
   * arguments matters.
   */
  // export type MoveCallTx = {
  //   Call: {
  //     package: SuiObjectRef;
  //     module: string;
  //     function: string;
  //     typeArguments: TypeTag[];
  //     arguments: CallArg[];
  //   };
  // };

  BCS
    .registerVectorType('vector<CallArg>', 'CallArg')
    .registerStructType('MoveCallTx', {
      'package': 'SuiObjectRef',
      'module': 'string',
      'function': 'string',
      'typeArguments': 'vector<TypeTag>',
      'arguments': 'vector<CallArg>',
    });

  // ========== TransactionData ===========

  // export type Transaction =
  //   | MoveCallTx
  //   | PayTx
  //   | PublishTx
  //   | TransferObjectTx
  //   | TransferSuiTx;

  BCS.registerEnumType('Transaction', {
    'TransferObject': 'TransferObjectTx',
    'Publish': 'PublishTx',
    'Call': 'MoveCallTx',
    'TransferSui': 'TransferSuiTx',
    'Pay': 'PayTx',
  });
  /**
   * Transaction kind - either Batch or Single.
   *
   * Can be improved to change serialization automatically based on
   * the passed value (single Transaction or an array).
   */
  // export type TransactionKind =
  //   | { Single: Transaction }
  //   | { Batch: Transaction[] };

  BCS
    .registerVectorType('vector<Transaction>', 'Transaction')
    .registerEnumType('TransactionKind', {
      'Single': 'Transaction',
      'Batch': 'vector<Transaction>',
    });

  /**
   * The TransactionData to be signed and sent to the RPC service.
   *
   * Field `sender` is made optional as it can be added during the signing
   * process and there's no need to define it sooner.
   */
  // export type TransactionData = {
  //   sender?: string; //
  //   gasBudget: number;
  //   gasPrice: number;
  //   kind: TransactionKind;
  //   gasPayment: SuiObjectRef;
  // };

  BCS.registerStructType('TransactionData', {
    'kind': 'TransactionKind',
    'sender': 'SuiAddress',
    'gasPayment': 'SuiObjectRef',
    'gasPrice': 'u64',
    'gasBudget': 'u64',
  });

}
