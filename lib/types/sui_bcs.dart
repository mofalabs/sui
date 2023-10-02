
import 'dart:convert';

import 'package:bcs/bcs.dart';
import 'package:sui/types/objects.dart';

/// A reference to a shared object.
class SharedObjectRef {
  /// Hex code as string representing the object id
  String objectId;

  /// The version the object was shared at
  dynamic initialSharedVersion;

  /// Whether reference is mutable
  bool mutable;

  SharedObjectRef(this.objectId, this.initialSharedVersion, this.mutable);
}

typedef ObjectArg = dynamic;

typedef PureArg = dynamic;

bool isPureArg(PureArg arg) {
  return (arg as PureArg)["Pure"] != null;
}

typedef CallArg = dynamic;

/// Kind of a TypeTag which is represented by a Move type identifier.
class StructTag {
  String address;
  String module;
  String name;
  List<TypeTag> typeParams;

  StructTag(this.address, this.module, this.name, this.typeParams);
}

/// Sui TypeTag object. A decoupled `0x...::module::Type<???>` parameter.
typedef TypeTag = dynamic;

/// The GasData to be used in the transaction.
class GasData {
  List<SuiObjectRef> payment;
  String owner;
  int price;
  int budget;

  GasData(this.payment, this.owner, this.price, this.budget);
}

typedef TransactionExpiration = dynamic;

// Move name of the Vector type.
const VECTOR = 'vector';

// Imported to explicitly tell typescript that types match
class TypeSchema {
  Map<String, StructTypeDefinition>? structs;
  Map<String,EnumTypeDefinition>? enums;
  Map<String, String>? aliases;

  TypeSchema(this.structs, this.enums, this.aliases);
}

final BCS_SPEC = BcsConfigTypes(
  enums: {
    'Option<T>': {
      "None": null,
      "Some": 'T',
    },
    "ObjectArg": {
      "ImmOrOwned": 'SuiObjectRef',
      "Shared": 'SharedObjectRef',
    },
    "CallArg": {
      "Pure": [VECTOR, BCS.U8],
      "Object": 'ObjectArg',
      "ObjVec": [VECTOR, 'ObjectArg'],
    },
    "TypeTag": {
      "bool": null,
      "u8": null,
      "u64": null,
      "u128": null,
      "address": null,
      "signer": null,
      "vector": 'TypeTag',
      "struct": 'StructTag',
      "u16": null,
      "u32": null,
      "u256": null,
    },
    "TransactionKind": {
      // can not be called from sui.js; dummy placement
      // to set the enum counter right for ProgrammableTransact
      "ProgrammableTransaction": 'ProgrammableTransaction',
      "ChangeEpoch": null,
      "Genesis": null,
      "ConsensusCommitPrologue": null,
    },
    "TransactionExpiration": {
      "None": null,
      "Epoch": BCS.U64,
    },
    "TransactionData": {
      "V1": 'TransactionDataV1',
    },
  },
  structs: {
    "SuiObjectRef": {
      "objectId": BCS.ADDRESS,
      "version": BCS.U64,
      "digest": 'ObjectDigest',
    },
    "SharedObjectRef": {
      "objectId": BCS.ADDRESS,
      "initialSharedVersion": BCS.U64,
      "mutable": BCS.BOOL,
    },
    "StructTag": {
      "address": BCS.ADDRESS,
      "module": BCS.STRING,
      "name": BCS.STRING,
      "typeParams": [VECTOR, 'TypeTag'],
    },
    "GasData": {
      "payment": [VECTOR, 'SuiObjectRef'],
      "owner": BCS.ADDRESS,
      "price": BCS.U64,
      "budget": BCS.U64,
    },
    // Signed transaction data needed to generate transaction digest.
    "SenderSignedData": {
      "data": 'TransactionData',
      "txSignatures": [VECTOR, [VECTOR, BCS.U8]],
    },
    "TransactionDataV1": {
      "kind": 'TransactionKind',
      "sender": BCS.ADDRESS,
      "gasData": 'GasData',
      "expiration": 'TransactionExpiration',
    }
  },
  aliases: {
    "ObjectDigest": BCS.BASE58,
  }
);

final config = getSuiMoveConfig()..types = BCS_SPEC;
final bcs = BCS(config)..registerType(
  'utf8string',
  (writer, str, _, __) {
    final bytes = utf8.encode(str);
    return writer.writeVec(bytes, (writer, el, _, __) => writer.write8(el));
  },
  (reader, _, __) {
    final bytes = reader.readVec((reader, _, __) => reader.read8());
    return utf8.decode(bytes.cast<int>());
  },
)..registerStructType('ZkLoginSignature', {
    "inputs": {
      "proofPoints": {
        "a": [BCS.VECTOR, BCS.STRING],
        "b": [BCS.VECTOR, [BCS.VECTOR, BCS.STRING]],
        "c": [BCS.VECTOR, BCS.STRING],
      },
      "issBase64Details": {
        "value": BCS.STRING,
        "indexMod4": BCS.U8,
      },
      "headerBase64": BCS.STRING,
      "addressSeed": BCS.STRING,
    },
    "maxEpoch": BCS.U64,
    "userSignature": [BCS.VECTOR, BCS.U8],
  });
