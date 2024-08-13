
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:bcs/bcs_type.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/builder/commands.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/pure.dart';
import 'package:sui/builder/serializer.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/builder/v1.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/sui_bcs.dart';
import 'package:sui/types/transactions.dart';

class TransactionResult {
  final int index;

  TransactionResult(this.index);

  Map<String, dynamic> get result => { "\$kind": 'Result', "Result": index };
  final Map<String, dynamic> _nestedResult = <String, dynamic>{};

  Map<String, dynamic> nestedResult(subIndex) {
    final result = { "\$kind": 'NestedResult', "NestedResult": [index, subIndex] };
    _nestedResult.addAll(result);
    return result;
  }

  operator [](indexKey) {
    if (result.containsKey(indexKey)) {
      return result[indexKey];
    }

    final subIndex = int.tryParse(indexKey.toString());
    if (subIndex == null || subIndex < 0) {
      throw ArgumentError("Invalid index key $indexKey");
    }
    return nestedResult(subIndex);
  }

  bool containsKey(String key) {
    return result.containsKey(key);
  }

  Map<String, dynamic> toJson() {
    return _nestedResult.isNotEmpty ? _nestedResult : result;
  }

}

const DefaultOfflineLimits = {
	"maxPureArgumentSize": 16 * 1024,
	"maxTxGas": 50000000000,
	"maxGasObjects": 256,
	"maxTxSizeBytes": 128 * 1024,
};

bool isReceivingType(SuiMoveNormalizedType normalizedType) {
	final tag = extractStructTag(normalizedType);
	if (tag != null && tag["Struct"] != null) {
		return (
			tag["Struct"]["address"] == '0x2' &&
			tag["Struct"]["module"] == 'transfer' &&
			tag["Struct"]["name"] == 'Receiving'
		);
	}
	return false;
}

SuiClient expectClient(BuildOptions options) {
	if (options.client == null) {
		throw ArgumentError(
			"No provider passed to Transaction#build, but transaction data was not sufficient to build offline.",
		);
	}

	return options.client!;
}

const LIMITS = {
	// The maximum gas that is allowed.
	"maxTxGas": 'max_tx_gas',
	// The maximum number of gas objects that can be selected for one transaction.
	"maxGasObjects": 'max_gas_payment_objects',
	// The maximum size (in bytes) that the transaction can be:
	"maxTxSizeBytes": 'max_tx_size_bytes',
	// The maximum size (in bytes) that pure arguments can be:
	"maxPureArgumentSize": 'max_pure_argument_size',
};

// type Limits = Partial<Record<keyof typeof LIMITS, number>>;
typedef Limits = dynamic;

// An amount of gas (in gas units) that is added to transactions as an overhead to ensure transactions do not fail.
final GAS_SAFE_OVERHEAD = BigInt.from(1000);

// The maximum objects that can be fetched at once using multiGetObjects.
const MAX_OBJECTS_PER_FETCH = 50;

List<List<T>> chunk<T>(List<T> arr, int size) {
  int length = (arr.length / size).ceil();

  return List<List<T>>.generate(length, (int i) {
    return arr.sublist(i * size, (i * size + size > arr.length) ? arr.length : i * size + size);
  });
}

class BuildOptions {
	SuiClient? client;
	bool onlyTransactionKind;
	/// Define a protocol config to build against, instead of having it fetched from the provider at build time.
	dynamic protocolConfig;
	/// Define limits that are used when building the transaction. In general, we recommend using the protocol configuration instead of defining limits.
	Limits? limits;

  BuildOptions({this.client, this.onlyTransactionKind = false, this.protocolConfig, this.limits});
}

class SerializeTransactionOptions extends BuildOptions {
	List<String>? supportedIntents;

  SerializeTransactionOptions(
    {
      this.supportedIntents,
      super.client, 
      super.onlyTransactionKind,
      super.protocolConfig, 
      super.limits 
    }
  );
}

class SignOptions extends BuildOptions {
	Keypair signer;

  SignOptions(
    {
      required this.signer,
      super.client, 
      super.onlyTransactionKind,
      super.protocolConfig, 
      super.limits 
    }
  );
}

class Transaction {

	/// Converts from a serialize transaction kind (built with `build({ onlyTransactionKind: true })`) to a `Transaction` class.
	/// Supports either a byte array, or base64-encoded bytes.
	static Transaction fromKind(dynamic serialized) {
		final tx = Transaction();

		tx._blockData = TransactionBlockDataBuilder.fromKindBytes(
			serialized is String ? fromB64(serialized) : serialized,
		);

		return tx;
	}

	/// Converts from a serialized transaction format to a `Transaction` class.
	/// There are two supported serialized formats:
	/// - A string returned from `Transaction_serialize`. The serialized format must be compatible, or it will throw an error.
	/// - A byte array (or base64-encoded bytes) containing BCS transaction data.
	static Transaction from(String serialized) {
		final tx = Transaction();
		tx._blockData = TransactionBlockDataBuilder.restore(jsonDecode(serialized));
		return tx;
	}

	static Transaction fromBytes(Uint8List bytes) {
		final tx = Transaction();
		tx._blockData = TransactionBlockDataBuilder.fromBytes(bytes);
		return tx;
	}

	void setSender(String sender) {
		_blockData.sender = sender;
	}

	/// Sets the sender only if it has not already been set.
	/// This is useful for sponsored transaction flows where the sender may not be the same as the signer address.
	void setSenderIfNotSet(String sender) {
		_blockData.sender ??= sender;
	}

	void setExpiration(int? epoch) {
		_blockData.expiration = TransactionExpiration(epoch: epoch);
	}

	void setGasPrice(BigInt price) {
		_blockData.gasData.price = price;
	}

	void setGasBudget(BigInt budget) {
		_blockData.gasData.budget = budget;
	}

	void setGasOwner(String owner) {
		_blockData.gasData.owner = owner;
	}

	void setGasPayment(List<SuiObjectRef> payments) {
		_blockData.gasData.payment = payments.map(
      (p) => SuiObjectRef(p.digest, p.objectId, p.version)
    ).toList();
	}

	late TransactionBlockDataBuilder _blockData;

  @Deprecated('Use getData() instead')
	TransactionDataV1 get blockData {
		return serializeV1TransactionData(_blockData.snapshot());
	}

	TransactionData getData() {
		return _blockData.snapshot();
	}

  Pure? _pure;

  Pure get pure {
    _pure ??= createPure((dynamic value) {
        if (value is SerializedBcs) {
          return _blockData.addInput('pure', {
            '\$kind': 'Pure',
            'Pure': {
              'bytes': value.toBase64(),
            },
          });
        }

        if (value is Map && (value['Object'] != null || value['Pure'] != null)) {
          return _blockData.addInput('pure', value['Object'] ?? value['Pure']);
        } else if (value is Uint8List) {
          return _blockData.addInput('pure', Inputs.pure(value));
        } else {
          return _blockData.addInput('pure', {
            '\$kind': 'UnresolvedPure',
            'UnresolvedPure': {'value': value},
          });
        }
      });
    return _pure!;
  }

	Transaction([Transaction? transaction]) {
		_blockData = TransactionBlockDataBuilder(
			transaction?.getData()
		);
	}

	/// Returns an argument for the gas coin, to be used in a transaction.
	Map<String, dynamic> get gas {
		return { "\$kind": 'GasCoin', "GasCoin": true };
	}

	/// Dynamically create a new input, which is separate from the `input`. This is important
	/// for generated clients to be able to define unique inputs that are non-overlapping with the
	/// defined inputs.
	///
	/// For `Uint8Array` type automatically convert the input into a `Pure` CallArg, since this
	/// is the format required for custom serialization.
	Map<String, dynamic> _input(String type, dynamic value) {
		final index = _blockData.inputs.length;
		final input =
			{
				"\$kind": 'Input',
				// bigints can't be serialized to JSON, so just string-convert them here:
				"value": value is BigInt ? value.toString() : value,
				"index": index,
				"type": type,
			};
		_blockData.inputs.add(input);
		return input;
	}

  Map<String, dynamic> object(dynamic value) {
    if (value is Function) {
      return object(value(this));
    }

    if (value is Map && value['\$kind'] != null) {
      final kind = value['\$kind'];
      if (kind == 'GasCoin'
          || kind == 'Input'
          || kind == 'Result'
          || kind == 'NestedResult') {
        return value as Map<String, dynamic>;
      }
    }

    final id = getIdFromCallArg(value);

    final inserted = _blockData.inputs.firstWhere(
      (i) => id == getIdFromCallArg(i),
      orElse: () => <String, dynamic>{}
    );

    // Upgrade shared object inputs to mutable if needed:
    if (inserted.isNotEmpty &&
        inserted['Object']?['SharedObject'] != null &&
        value is Map<String, dynamic> &&
        value['Object']?['SharedObject'] != null) {
      inserted['Object']['SharedObject']['mutable'] =
          inserted['Object']['SharedObject']['mutable'] ||
              value['Object']['SharedObject']['mutable'];
    }

    if (inserted.isNotEmpty) {
      return {
        '\$kind': 'Input',
        'Input': _blockData.inputs.indexOf(inserted),
        'type': 'object'
      };
    } else {
      return _blockData.addInput(
        'object',
        value is String
            ? {
                '\$kind': 'UnresolvedObject',
                'UnresolvedObject': {
                  'objectId': normalizeSuiAddress(value)
                },
              }
            : value,
      );
    }
  }

	Map<String, dynamic> objectId(String value) {
    return object(value);
	}

	/// Add a new object input to the transaction using the fully-resolved object reference.
	/// If you only have an object ID, use `builder.object(id)` instead.
	Map<String, dynamic> objectRef(SuiObjectRef args) {
		return object(Inputs.objectRef(args));
	}

	/// Add a new shared object input to the transaction using the fully-resolved shared object reference.
	/// If you only have an object ID, use `builder.object(id)` instead.
	Map<String, dynamic> sharedObjectRef(SuiObject args) {
		return object(Inputs.sharedObjectRef(args));
	}

  Map<String, dynamic> pureInt(int value, [String type = LegacyBCS.U64]) {
    return pure.u64(BigInt.from(value));
  }

  Map<String, dynamic> pureBool(bool value) {
    return pure.boolean(value);
  }

  Map<String, dynamic> pureAddress(String address) {
    return pure.address(address);
  }

  Map<String, dynamic> pureString(String str) {
    return pure.string(str);
  }

    Map<String, dynamic> pureVector(List<dynamic> value, [String type = LegacyBCS.U64]) {
    return pure.vector(type, value);
  }

	TransactionResult add(dynamic transaction) {
		_blockData.commands.add(transaction);
		return TransactionResult(_blockData.commands.length - 1);
	}

	// Method shorthands:

	TransactionResult splitCoins(Map<String, dynamic> coin, List<dynamic> amounts) {
		return add(Commands.splitCoins(coin, amounts));
	}

	TransactionResult mergeCoins(Map<String, dynamic> destination, List<Map<String, dynamic>> sources) {
		return add(Commands.mergeCoins(destination, sources));
	}

	TransactionResult publish(List<String> modules, List<String> dependencies) {
		return add(Commands.publish(modules: modules, dependencies: dependencies));
	}

	TransactionResult upgrade({
		required List<String> modules,
		required List<String> dependencies,
		required String packageId,
		required dynamic ticket,
	}) {
		return add(Commands.upgrade(
      modules: modules,
      dependencies: dependencies,
      package: packageId,
      ticket: ticket
    ));
	}

	TransactionResult moveCall(
    String target, {
    List? typeArguments,
    List? arguments
	}) {
		return add(Commands.moveCall({
      "target": target,
      "typeArguments": typeArguments,
      "arguments": arguments
    }));
	}

	TransactionResult transferObjects(List<dynamic> objects, dynamic address) {
		return add(Commands.transferObjects(objects, address));
	}

	TransactionResult makeMoveVec({
    required dynamic objects,
    String? type
  }) {
		return add(Commands.makeMoveVec(elements: objects, type: type));
	}

	/// Serialize the transaction to a string so that it can be sent to a separate context.
	/// This is different from `build` in that it does not serialize to BCS bytes, and instead
	/// uses a separate format that is unique to the transaction builder. This allows
	/// us to serialize partially-complete transactions, that can then be completed and
	/// built in a separate context.
	///
	/// For example, a dapp can construct a transaction, but not provide gas objects
	/// or a gas budget. The transaction then can be sent to the wallet, where this
	/// information is automatically filled in (e.g. by querying for coin objects
	/// and performing a dry run).
  @Deprecated('Use toJson() instead')
	String serialize() {
		return jsonEncode(serializeV1TransactionData(_blockData.snapshot()));
	}

	String toJson([SerializeTransactionOptions? options]) {
		// await prepareForSerialization(options);
    return _blockData.snapshot().toJson().toString();
	}

	String _getConfig(String key, BuildOptions options) {
		// Use the limits definition if that exists:
		if (options.limits != null && options.limits[key] is int) {
			return options.limits[key]!.toString();
		}

		if (options.protocolConfig == null) {
			return DefaultOfflineLimits[key].toString();
		}

		// Fallback to protocol config:
		final attribute = options.protocolConfig?["attributes"][LIMITS[key]];
		if (attribute == null) {
			throw ArgumentError('Missing expected protocol config: "${LIMITS[key]}"');
		}

		final value = attribute["u64"] ?? (attribute["u32"] ?? attribute["f64"]);
		if (value == null) {
			throw ArgumentError('Unexpected protocol config value found for: "${LIMITS[key]}"');
		}

		// NOTE: Technically this is not a safe conversion, but we know all of the values in protocol config are safe
		return value.toString();
	}

	/// Build the transaction to BCS bytes, and sign it with the provided keypair.
	Future<SignatureWithBytes> sign(SignOptions options) async {
		final bytes = await build(options);
		return options.signer.signTransactionBlock(bytes);
	}

	/// Build the transaction to BCS bytes.
	Future<Uint8List> build([BuildOptions? options]) async {
    options ??= BuildOptions();
		await _prepare(options);
		return _blockData.build(
			maxSizeBytes: int.parse(_getConfig('maxTxSizeBytes', options).toString()),
			onlyTransactionKind: options.onlyTransactionKind,
		);
	}

	/// Derive transaction digest
	Future<String> getDigest(
    BuildOptions options
	) async {
		await _prepare(options);
		return _blockData.getDigest();
	}

	void _validate(BuildOptions options) {
		final maxPureArgumentSize = int.parse(_getConfig('maxPureArgumentSize', options));
		// Validate all inputs are the correct size:
    for (var i = 0; i < _blockData.inputs.length; i++) {
      final input = _blockData.inputs[i];
			if (input["value"] is Map && input["value"].containsKey("Pure")) {
				if (input["value"]["Pure"].length > maxPureArgumentSize) {
					throw ArgumentError(
						"Input at index $i is too large, max pure input size is $maxPureArgumentSize bytes, got ${input["value"]["Pure"].length} bytes",
					);
				}
			}
    }
	}

  void normalizeRawArgument(
    dynamic arg,
    BcsType schema,
  ) {
    if (arg is! Map) {
      return;
    }
    if (arg["Input"] == null) {
      return;
    }
    final input = _blockData.inputs[arg["Input"]];

    if (input["UnresolvedPure"] == null) {
      return;
    }

    _blockData.inputs[arg["Input"]] = Inputs.pure(schema.serialize(input["UnresolvedPure"]["value"]));
  }

  Future<void> resolveObjectReferences(BuildOptions options) async {
    // Keep track of the object references that will need to be resolved at the end of the transaction.
    // We keep the input by-reference to avoid needing to re-resolve it:
    final objectsToResolve = _blockData.inputs.where((input) {
      return (
        input["UnresolvedObject"] != null &&
        (input["UnresolvedObject"]["version"] == null && input["UnresolvedObject"]["initialSharedVersion"] == null)
      );
    });

    final dedupedIds = Set.from(
        objectsToResolve.map((input) => normalizeSuiObjectId(input["UnresolvedObject"]["objectId"]))
      ).toList();

    final objectChunks = dedupedIds.isNotEmpty ? chunk(dedupedIds, MAX_OBJECTS_PER_FETCH) : [];

    final resolved = <SuiObjectResponse>[];
    final objectsResult = (
      await Future.wait(
        objectChunks.map((chunk) =>
          expectClient(options).multiGetObjects(
            chunk.cast<String>(),
            options: SuiObjectDataOptions(showOwner: true)
          ),
        ),
      )
    );
    for (var item in objectsResult) {
      resolved.addAll(item);
    }

    final responsesById = Map.fromIterables(
      dedupedIds,
      dedupedIds.asMap().map((index, id) => MapEntry(index, resolved[index])).values,
    );

    final invalidObjects = responsesById.entries
      .where((entry) => entry.value.error != null)
      .map((entry) => entry.value.error?.toJson())
      .toList();

    if (invalidObjects.isNotEmpty) {
      throw ArgumentError("The following input objects are invalid: ${invalidObjects.join(', ')}");
    }

    final objects = resolved.map((object) {
      if (object.error != null || object.data == null) {
        throw ArgumentError("Failed to fetch object: ${object.error}");
      }
      final owner = object.data?.owner;
      final initialSharedVersion = owner?.shared?.initialSharedVersion;

      return {
        "objectId": object.data?.objectId,
        "digest": object.data?.digest,
        "version": object.data?.version,
        "initialSharedVersion": initialSharedVersion
      };
    }).toList();

    final objectsById = Map.fromIterables(
      dedupedIds,
      dedupedIds.asMap().map((index, id) => MapEntry(index, objects[index])).values,
    );

    for (int index = 0; index < _blockData.inputs.length; index++) {
      final input = _blockData.inputs[index];
      if (input["UnresolvedObject"] == null) {
        continue;
      }

      CallArg updated;
      final id = normalizeSuiAddress(input["UnresolvedObject"]["objectId"]);
      final object = objectsById[id];

      if ((input["UnresolvedObject"]?["initialSharedVersion"] ?? object?["initialSharedVersion"]) != null) {
        updated = Inputs.sharedObjectRef({
          "objectId": id,
          "initialSharedVersion":
            input["UnresolvedObject"]["initialSharedVersion"] ?? object?["initialSharedVersion"],
          "mutable": isUsedAsMutable(_blockData, index),
        });
      } else if (isUsedAsReceiving(_blockData, index)) {
        updated = Inputs.receivingRef(
          SuiObjectRef(
            input["UnresolvedObject"]["digest"] ?? object?["digest"],
            id, 
            input["UnresolvedObject"]["version"] ?? object?["version"],
          )
        );
      }

      _blockData.inputs[_blockData.inputs.indexOf(input)] =
        updated ??
        Inputs.objectRef(
          SuiObjectRef(
            input["UnresolvedObject"]["digest"] ?? object?["digest"],
            id, 
            input["UnresolvedObject"]["version"] ?? object?["version"],
          )
        );
    }
  }

  Future<void> normalizeInputs(BuildOptions options) async {
    final inputs = _blockData.inputs;
    final commands = _blockData.commands;
    final moveCallsToResolve = [];
    final moveFunctionsToResolve = <String>{};

    for (var command in commands) {
      if (command["MoveCall"] != null) {
        // Determine if any of the arguments require encoding.
        // - If they don't, then this is good to go.
        // - If they do, then we need to fetch the normalized move module.

        // If we already know the argument types, we don't need to resolve them again
        if (command["MoveCall"]?["_argumentTypes"] != null) {
          continue;
        }

        final inputs = (command["MoveCall"]["arguments"] as Iterable).map((arg) {
          if (arg["Input"] != null) {
            return _blockData.inputs[arg["Input"]];
          }
          return null;
        }).toList();
        final needsResolution = inputs.firstWhere(
          (input) => input?["UnresolvedPure"] != null || input?["UnresolvedObject"] != null,
          orElse: () => null
        );

        if (needsResolution != null) {
          final functionName = "${command["MoveCall"]["package"]}::${command["MoveCall"]["module"]}::${command["MoveCall"]["function"]}";
          moveFunctionsToResolve.add(functionName);
          moveCallsToResolve.add(command["MoveCall"]);
        }
      }

      // Special handling for values that where previously encoded using the wellKnownEncoding pattern.
      // This should only happen when transaction data was hydrated from an old version of the SDK
      if (command["SplitCoins"] != null) {
        command["SplitCoins"]["amounts"].forEach((amount) {
          normalizeRawArgument(amount, SuiBcs.U64);
        });
      } else if (command["TransferObjects"] != null) {
        normalizeRawArgument(command["TransferObjects"]["address"], SuiBcs.Address);
      }
    }

    final moveFunctionParameters = <String, List<dynamic>>{};
    if (moveFunctionsToResolve.isNotEmpty) {
      final client = expectClient(options);
      await Future.wait(
        [...moveFunctionsToResolve].map((functionName) async {
          final [packageId, moduleId, functionId] = functionName.split('::');
          final def = await client.getNormalizedMoveFunction(
            packageId,
            moduleId,
            functionId,
          );

          moveFunctionParameters[functionName] = def.parameters.map((param) => normalizedTypeToMoveTypeSignature(param)).toList();
        }),
      );
    }

    if (moveCallsToResolve.isNotEmpty) {
      moveCallsToResolve.forEach((moveCall) {
        final parameters = moveFunctionParameters["${moveCall["package"]}::${moveCall["module"]}::${moveCall["function"]}"];
        if (parameters != null && parameters.isNotEmpty) {
          // Entry functions can have a mutable reference to an instance of the TxContext
          // struct defined in the TxContext module as the last parameter. The caller of
          // the function does not need to pass it in as an argument.
          final hasTxContext = isTxContext(parameters.last!);
          final params = hasTxContext ? parameters.sublist(0, parameters.length - 1) : parameters;

          moveCall["_argumentTypes"] = params;
        }
      });
    }

    for (var command in commands) {
      if (command["MoveCall"] == null) {
        continue;
      }

      final moveCall = command["MoveCall"];
      final fnName = "${moveCall["package"]}::${moveCall["module"]}::${moveCall["function"]}";
      final params = moveCall["_argumentTypes"];

      if (params == null) {
        continue;
      }

      if (params.length != command["MoveCall"]["arguments"].length) {
        throw ArgumentError("Incorrect number of arguments for $fnName");
      }

      final callArgs = moveCall["arguments"].toList();
      for (var i = 0; i < params.length; i++) {
        final param = params[i];
        final arg = callArgs[i];
        if (arg["Input"] == null) continue;
        final input = inputs[arg["Input"]];

        // Skip if the input is already resolved
        if (input["UnresolvedPure"] == null && input["UnresolvedObject"] == null) {
          continue;
        }

        final inputValue = input["UnresolvedPure"]?["value"] ?? input["UnresolvedObject"]?["objectId"];

        final schema = getPureBcsSchema(param["body"]);
        if (schema != null) {
          arg["type"] = 'pure';
          inputs[inputs.indexOf(input)] = Inputs.pure(schema.serialize(inputValue));
          // inputs[inputs.indexOf(input)] = Inputs.pure(inputValue, schema);
          continue;
        }

        if (inputValue is! String) {
          throw ArgumentError("Expect the argument to be an object id string, got $inputValue");
        }

        arg["type"] = 'object';
        final unresolvedObject = input["UnresolvedPure"] != null
          ? {
              "UnresolvedObject": {
                "objectId": inputValue,
              },
            }
          : input;

        inputs[arg["Input"]] = unresolvedObject;
      }
    }
  }

	// The current default is just picking _all_ coins we can which may not be ideal.
	Future<void> _prepareGasPayment(BuildOptions options) async {
		if (_blockData.gasData.payment != null) {
			final maxGasObjects = int.parse(_getConfig('maxGasObjects', options));
			if (_blockData.gasData.payment!.length > maxGasObjects) {
				throw ArgumentError("Payment objects exceed maximum amount: $maxGasObjects");
			}
		}

		// Early return if the payment is already set:
		if ((options.onlyTransactionKind) || _blockData.gasData.payment != null) {
			return;
		}

		final gasOwner = _blockData.gasData.owner ?? _blockData.sender;

		final coins = await expectClient(options).getCoins(gasOwner!, coinType: SUI_TYPE_ARG);

		final paymentCoins = coins.data
			// Filter out coins that are also used as input:
			.where((coin) {
				final matchingInput = _blockData.inputs.indexWhere((input) {
					if (input["Object"]?["ImmOrOwnedObject"] != null) {
						return coin.coinObjectId == input["Object"]["ImmOrOwnedObject"]["objectId"];
					}

					return false;
				});

				return matchingInput == -1;
			})
      .toList();

      int end = min(paymentCoins.length, int.parse(_getConfig('maxGasObjects', options)) - 1);

			final usePaymentCoins = paymentCoins
        .sublist(0, end)
			  .map((coin) => SuiObjectRef(coin.digest, coin.coinObjectId, coin.version))
        .toList();

		if (paymentCoins.isEmpty) {
			throw ArgumentError('No valid gas coins found for the transaction.');
		}

		setGasPayment(usePaymentCoins);
	}

	Future<void> _prepareGasPrice(BuildOptions options) async {
		if (options.onlyTransactionKind || _blockData.gasData.price != null) {
			return;
		}

    final gasPrice = await expectClient(options).getReferenceGasPrice();
		setGasPrice(gasPrice);
	}

  bool isBuilderCallArg(arg) {
    if (arg is! Map) return false;
    return arg.containsKey("Pure") || arg.containsKey("Object");
  }

  Future<void> _prepareTransactions(BuildOptions options) async {
    final inputs = _blockData.inputs;
    final transactions = _blockData.commands;

    final moveModulesToResolve = [];

		// Keep track of the object references that will need to be resolved at the end of the transaction.
		// We keep the input by-reference to avoid needing to re-resolve it:
		final objectsToResolve = [];

		for (var input in inputs) {
			if (input['type'] == 'object' && input['value'] is String) {
				// The input is a string that we need to resolve to an object reference:
				objectsToResolve.add(
						{"id": normalizeSuiAddress(input['value']), "input": input});
				continue;
			}
		}

    for (var transaction in transactions) {
      if (transaction["kind"] == "MoveCall") {
        bool needsResolution = (transaction["arguments"] as List).any(
                                (arg) => arg is Map &&
                                arg['kind'] == 'Input' && 
                                !(isBuilderCallArg(inputs[arg['index']]["value"])));
        if (needsResolution) {
          moveModulesToResolve.add(transaction);
        }
			}

			// Special handling for values that where previously encoded using the wellKnownEncoding pattern.
			// This should only happen when transaction block data was hydrated from an old version of the SDK
      if (transaction["kind"] == 'SplitCoins') {
        for (var amount in (transaction["amounts"] as List)) {
					if (amount["kind"] == 'Input') {
						final input = inputs[amount['index']];
						if (input["value"] is! Map) {
							input['value'] = Inputs.pure(input['value'], LegacyBCS.U64);
						}
					}
				}
      }

      if (transaction["kind"] == 'TransferObjects') {
        if (transaction['address']['kind'] == 'Input') {
          final input = inputs[transaction['address']['index']];
          if (input["value"] is! Map) {
            input['value'] = Inputs.pure(input['value'], LegacyBCS.ADDRESS);
          }
        }
      }
    }

    if (moveModulesToResolve.isNotEmpty) {
      for (var moveCall in moveModulesToResolve) {
        final target = moveCall["target"].split('::');
        final packageId = target[0];
        final moduleName = target[1];
        final functionName = target[2];

        final normalized = await expectClient(options).getNormalizedMoveFunction(
          normalizeSuiObjectId(packageId),
          moduleName,
          functionName,
        );

        // Entry functions can have a mutable reference to an instance of the TxContext
        // struct defined in the TxContext module as the last parameter. The caller of
        // the function does not need to pass it in as an argument.
        final hasTxContext =
          normalized.parameters.isNotEmpty && isTxContext(normalized.parameters.last);

        final params = hasTxContext
          ? normalized.parameters.sublist(0, normalized.parameters.length - 1)
          : normalized.parameters;

        final callArgs = moveCall["arguments"].toList();
        if (params.length != callArgs.length) {
          throw ArgumentError('Incorrect number of arguments.');
        }

        for (int i = 0; i < params.length; i++) {
          final param = params[i];
          final arg = callArgs[i];
          if (arg["kind"] != 'Input') continue;
          final input = inputs[arg["index"]];
          // Skip if the input is already resolved
          if (isBuilderCallArg(input["value"])) continue;

          final inputValue = input["value"];

          final serType = getPureSerializationType(param, inputValue);

          if (serType != null) {
            input["value"] = Inputs.pure(inputValue, serType);
            continue;
          }

          final structVal = extractStructTag(param);
          if (structVal != null || (param is Map && param["TypeParameter"] != null)) {
            if (inputValue is! String) {
              throw ArgumentError(
                "Expect the argument to be an object id string, got ${jsonEncode(inputValue)}",
              );
            }
            objectsToResolve.add({
              "id": inputValue,
              "input": input,
              "normalizedType": param,
            });
          } else {
            throw ArgumentError(
              "Unknown call arg type ${jsonEncode(param)} for value ${jsonEncode(inputValue)}",
            );
          }
        }

      }
    }


    if (objectsToResolve.isNotEmpty) {
      final dedupedIds = Set<String>.from(objectsToResolve.map((o) => o["id"])).toList();
      final objectChunks = chunk(dedupedIds, MAX_OBJECTS_PER_FETCH);
      final objects = (
        await Future.wait(
          objectChunks.map((chunk) =>
            expectClient(options).multiGetObjects(
              chunk,
              options: SuiObjectDataOptions(showOwner: true),
            ),
          ),
        )
      ).expand((element) => element).toList();

      final objectsById = <String, SuiObjectResponse>{};
      for (int index = 0; index < dedupedIds.length; index++) {
        objectsById[dedupedIds[index]] = objects[index];
      }

      final invalidObjects = objectsById.entries
          .where((entry) => entry.value.error != null)
          .map((entry) => entry.key)
          .toList();
      if (invalidObjects.isNotEmpty) {
        throw ArgumentError("The following input objects are invalid: ${invalidObjects.join(', ')}");
      }

      for (var item in objectsToResolve) {
        final id = item["id"];
        final input = item["input"];
        final normalizedType = item["normalizedType"];

        final object = objectsById[id];
        final owner = object?.data?.owner;
        final initialSharedVersion = owner?.shared?.initialSharedVersion;

        if (initialSharedVersion != null) {
          // There could be multiple transactions that reference the same shared object.
          // If one of them is a mutable reference, then we should mark the input
          // as mutable.
					final isByValue =
						normalizedType != null &&
						extractMutableReference(normalizedType) == null &&
						extractReference(normalizedType) == null;
          final mutable =
            isMutableSharedObjectInput(input["value"]) ||
            isByValue ||
            (normalizedType != null && extractMutableReference(normalizedType) != null);

          input["value"] = Inputs.sharedObjectRef({
            "objectId": id,
            "initialSharedVersion": initialSharedVersion,
            "mutable": mutable,
          });
        } else if (normalizedType != null && isReceivingType(normalizedType)) {
					input["value"] = Inputs.receivingRef(getObjectReference(object!)!);
				} else {
          input["value"] = Inputs.objectRef(getObjectReference(object!)!);
        }

      }
    }

  }

	/// Prepare the transaction by valdiating the transaction data and resolving all inputs
	/// so that it can be built into bytes.
	Future<void> _prepare(BuildOptions options) async {
		if (!options.onlyTransactionKind && _blockData.sender == null) {
			throw ArgumentError('Missing transaction sender');
		}

		final client = options.client;

		if (options.protocolConfig == null && options.limits == null && client != null) {
			options.protocolConfig = await client.getProtocolConfig();
		}

    await normalizeInputs(options);
    await resolveObjectReferences(options);

    await Future.wait([_prepareGasPrice(options), _prepareTransactions(options)]);

		if (options.onlyTransactionKind != true) {
			await _prepareGasPayment(options);

			if (_blockData.gasData.budget == null) {
        final dryRunResult = await expectClient(options).dryRunTransaction(
          _blockData.build(
              maxSizeBytes: int.parse(_getConfig('maxTxSizeBytes', options)),
              gasConfig: GasConfig(
                  budget: BigInt.tryParse(_getConfig('maxTxGas', options)),
                  payment: [])),
          signerAddress: _blockData.sender,
        );

        if (dryRunResult.effects.status.status != ExecutionStatusType.success) {
					throw ArgumentError(
						"Dry run failed, could not automatically determine a budget: ${dryRunResult.effects.status.error}"
					);
				}

				final safeOverhead = GAS_SAFE_OVERHEAD * (_blockData.gasData.price ?? BigInt.one);

				final baseComputationCostWithOverhead =
					BigInt.from(dryRunResult.effects.gasUsed.computationCost) + safeOverhead;

				final gasBudget =
					baseComputationCostWithOverhead +
					BigInt.from(dryRunResult.effects.gasUsed.storageCost) -
					BigInt.from(dryRunResult.effects.gasUsed.storageRebate);

				// Set the budget to max(computation, computation + storage - rebate)
				setGasBudget(
					gasBudget > baseComputationCostWithOverhead ? gasBudget : baseComputationCostWithOverhead,
				);
			}
		}

		// Perform final validation on the transaction:
		_validate(options);
	}

  bool isUsedAsMutable(TransactionBlockDataBuilder transactionData, int index) {
    var usedAsMutable = false;

    transactionData.getInputUses(index, (arg, tx) {
      if (tx["MoveCall"]?["_argumentTypes"] != null) {
        final argIndex = tx["MoveCall"]["arguments"].indexOf(arg);
        usedAsMutable = tx["MoveCall"]["_argumentTypes"][argIndex]["ref"] != '&' || usedAsMutable;
      }

      if (tx["MakeMoveVec"] != null || tx["MergeCoins"] == null || tx["SplitCoins"] == null) {
        usedAsMutable = true;
      }
    });

    return usedAsMutable;
  }


  bool isUsedAsReceiving(TransactionBlockDataBuilder transactionData, int index) {
    var usedAsReceiving = false;

    transactionData.getInputUses(index, (arg, tx) {
      if (tx["MoveCall"]?["_argumentTypes"] != null) {
        final argIndex = tx["MoveCall"]["arguments"].indexOf(arg);
        usedAsReceiving = isReceivingType(tx["MoveCall"]["_argumentTypes"][argIndex]) || usedAsReceiving;
      }
    });

    return usedAsReceiving;
  }

  bool isReceivingType(dynamic type) {
    if (type?["body"]?["datatype"] == null) {
      return false;
    }

    return (
      type["body"]["datatype"]["package"] == '0x2' &&
      type["body"]["datatype"]["module"] == 'transfer' &&
      type["body"]["datatype"]["type"] == 'Receiving'
    );
  }
}
