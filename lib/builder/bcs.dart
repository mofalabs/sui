
import 'dart:convert';

import 'package:bcs/index.dart';
import 'package:sui/builder/type_tag_serializer.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/sui_bcs.dart';

const ARGUMENT_INNER = 'Argument';
const VECTOR = 'vector';
const OPTION = 'Option';
const CALL_ARG = 'CallArg';
const TYPE_TAG = 'TypeTag';
const OBJECT_ARG = 'ObjectArg';
const PROGRAMMABLE_TX_BLOCK = 'ProgrammableTransaction';
const PROGRAMMABLE_CALL_INNER = 'ProgrammableMoveCall';
const TRANSACTION_INNER = 'Transaction';
const ENUM_KIND = 'EnumKind';

const TRANSACTION = [ENUM_KIND, TRANSACTION_INNER];
const ARGUMENT = [ENUM_KIND, ARGUMENT_INNER];
const PROGRAMMABLE_CALL = 'SimpleProgrammableMoveCall';

final builder = getBuilder();

BCS getBuilder() {
var _builder = bcs
  .registerStructType(PROGRAMMABLE_TX_BLOCK, {
    "inputs": [VECTOR, CALL_ARG],
    "transactions": [VECTOR, TRANSACTION],
  })
  .registerEnumType(ARGUMENT_INNER, {
    "GasCoin": null,
    "Input": { "index": BCS.U16 },
    "Result": { "index": BCS.U16 },
    "NestedResult": { "index": BCS.U16, "resultIndex": BCS.U16 },
  })
  .registerStructType(PROGRAMMABLE_CALL_INNER, {
    "package": BCS.ADDRESS,
    "module": BCS.STRING,
    "function": BCS.STRING,
    "type_arguments": [VECTOR, TYPE_TAG],
    "arguments": [VECTOR, ARGUMENT],
  })
  // Keep this in sync with crates/sui-types/src/messages.rs
  .registerEnumType(TRANSACTION_INNER, {
    /// A Move Call - any public Move function can be called via
    /// this transaction. The results can be used that instant to pass
    /// into the next transaction.
    "MoveCall": PROGRAMMABLE_CALL,
    /// Transfer vector of objects to a receiver.
    "TransferObjects": {
      "objects": [VECTOR, ARGUMENT],
      "address": ARGUMENT,
    },
    /// Split `amount` from a `coin`.
    "SplitCoins": { "coin": ARGUMENT, "amounts": [VECTOR, ARGUMENT] },
    /// Merge Vector of Coins (`sources`) into a `destination`.
    "MergeCoins": { "destination": ARGUMENT, "sources": [VECTOR, ARGUMENT] },
    /// Publish a Move module.
    "Publish": {
      "modules": [VECTOR, [VECTOR, BCS.U8]],
      "dependencies": [VECTOR, BCS.ADDRESS],
    },
    /// Build a vector of objects using the input arguments.
    /// It is impossible to construct a `vector<T: key>` otherwise,
    /// so this call serves a utility function.
    "MakeMoveVec": {
      "type": [OPTION, TYPE_TAG],
      "objects": [VECTOR, ARGUMENT],
    },
    "Upgrade": {
      "modules": [VECTOR, [VECTOR, BCS.U8]],
      "dependencies": [VECTOR, BCS.ADDRESS],
      "packageId": BCS.ADDRESS,
      "ticket": ARGUMENT,
    },
  });

  /// Wrapper around Enum, which transforms any `T` into an object with `kind` property:
  /// ```dart
  /// final bcsEnum = { TransferObjects: { objects: [], address: ... } }
  /// // becomes
  /// final translatedEnum = { kind: 'TransferObjects', objects: [], address: ... };
  /// ```
  _builder.registerType(
    [ENUM_KIND, 'T'],
    (writer, data, typeParams, typeMap) {
      final kind = data["kind"];
      final invariant = { kind: data };
      final enumType = typeParams.first.toString();

      return _builder.getTypeInterface(enumType).encodeRaw(
        writer,
        invariant,
        typeParams,
        typeMap,
      );
    },
    (reader, typeParams, typeMap) {
      final enumType = typeParams.first.toString();
      final data = _builder.getTypeInterface(enumType).decodeRaw(
        reader,
        typeParams,
        typeMap,
      );

      // enum invariant can only have one `key` field
      final kind = (data as Map).keys.first;
      if (data[kind] is Map) {
        return {
          "kind": kind,
          ...data[kind]
        };
      } else {
        return { "kind": kind };
      }
    },
    (data) {
      if (data is Map && !data.containsKey("kind")) {
        throw ArgumentError(
          'EnumKind: Missing property "kind" in the input ${jsonEncode(
            data,
          )}',
        );
      }

      return true;
    },
  );

  /// Custom deserializer for the ProgrammableCall.
  ///
  /// Hides the inner structure and gives a simpler, more convenient
  /// interface to encode and decode this struct as a part of `TransactionData`.
  ///
  /// - `(package)::(module)::(function)` are now `target` property.
  /// - `TypeTag[]` array is now passed as strings, not as a struct.
  _builder.registerType(
    PROGRAMMABLE_CALL,
    (writer, data, typeParams, typeMap) {
      final target = data["target"].split("::");
      final pkg = target[0];
      final module = target[1];
      final fun = target[2];
      final typeArguments = data["typeArguments"].map((tag) =>
        TypeTagSerializer.parseFromStr(tag, true)
      ).toList();

      return _builder.getTypeInterface(PROGRAMMABLE_CALL_INNER).encodeRaw(
        writer,
        {
          "package": normalizeSuiAddress(pkg),
          "module": module,
          "function": fun,
          "type_arguments": typeArguments,
          "arguments": data["arguments"]
        },
        typeParams,
        typeMap,
      );
    },
    (reader, typeParams, typeMap) {
      final data = _builder
        .getTypeInterface(PROGRAMMABLE_CALL_INNER)
        .decodeRaw(reader, typeParams, typeMap);

      return {
        "target": [data["package"], data["module"], data["function"]].join('::'),
        "arguments": data["arguments"],
        "typeArguments": data["type_arguments"].map(TypeTagSerializer.tagToString),
      };
    },
    // Validation callback to error out if the data format is invalid.
    // TODO: make sure TypeTag can be parsed.
    (data) {
      return data["target"].split('::').length == 3;
    },
  );

  return _builder;
}


