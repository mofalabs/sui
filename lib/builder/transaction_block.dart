
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/serializer.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/builder/transactions.dart';
import 'package:sui/builder/utils.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

class TransactionResult {
  final int index;

  TransactionResult(this.index);

  Map<String, dynamic> get result => { "kind": 'Result', "index": index };
  final Map<String, dynamic> _nestedResult = <String, dynamic>{};

  Map<String, dynamic> nestedResult(subIndex) {
    final result = { "kind": 'NestedResult', "index": index, "resultIndex": subIndex };
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

class SignOptions extends BuildOptions {
	Keypair signer;

  SignOptions(this.signer);
}

class TransactionBlock {

	/// Converts from a serialize transaction kind (built with `build({ onlyTransactionKind: true })`) to a `Transaction` class.
	/// Supports either a byte array, or base64-encoded bytes.
	static TransactionBlock fromKind(dynamic serialized) {
		final tx = TransactionBlock();

		tx._blockData = TransactionBlockDataBuilder.fromKindBytes(
			serialized is String ? fromB64(serialized) : serialized,
		);

		return tx;
	}

	/// Converts from a serialized transaction format to a `Transaction` class.
	/// There are two supported serialized formats:
	/// - A string returned from `Transaction_serialize`. The serialized format must be compatible, or it will throw an error.
	/// - A byte array (or base64-encoded bytes) containing BCS transaction data.
	static TransactionBlock from(String serialized) {
		final tx = TransactionBlock();
		tx._blockData = TransactionBlockDataBuilder.restore(jsonDecode(serialized));
		return tx;
	}

	static TransactionBlock fromBytes(Uint8List bytes) {
		final tx = TransactionBlock();
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
		_blockData.gasConfig.price = price;
	}

	void setGasBudget(BigInt budget) {
		_blockData.gasConfig.budget = budget;
	}

	void setGasOwner(String owner) {
		_blockData.gasConfig.owner = owner;
	}

	void setGasPayment(List<SuiObjectRef> payments) {
		_blockData.gasConfig.payment = payments.map(
      (p) => SuiObjectRef(p.digest, p.objectId, p.version)
    ).toList();
	}

	late TransactionBlockDataBuilder _blockData;

	/// Get a snapshot of the transaction data, in JSON form:
	SerializedTransactionDataBuilder get blockData {
		return _blockData.snapshot();
	}

	TransactionBlock([TransactionBlock? transaction]) {
		_blockData = TransactionBlockDataBuilder(
			transaction?.blockData
		);
	}

	/// Returns an argument for the gas coin, to be used in a transaction.
	Map<String, String> get gas {
		return { "kind": 'GasCoin' };
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
				"kind": 'Input',
				// bigints can't be serialized to JSON, so just string-convert them here:
				"value": value is BigInt ? value.toString() : value,
				"index": index,
				"type": type,
			};
		_blockData.inputs.add(input);
		return input;
	}

	/// Add a new object input to the transaction.
	Map<String, dynamic> object(dynamic value) {
		final id = getIdFromCallArg(value);
		// deduplicate
		final inserted = _blockData.inputs.firstWhere(
			(i) => i["type"] == 'object' && id == getIdFromCallArg(i["value"]),
      orElse: () => <String, dynamic>{},
		);
		return inserted.isNotEmpty ? inserted : _input('object', value);
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

	/// Add a new non-object input to the transaction.
	Map<String, dynamic> pure(
		dynamic value,
		[String? type]
	) {
		return _input(
			'pure',
			type != null ? Inputs.pure(value, type) : value
		);
	}

  Map<String, dynamic> pureBytes(Uint8List value) {
		return _input('pure', Inputs.pure(value));
  }

  Map<String, dynamic> pureInt(int value, [String type = BCS.U64]) {
		return _input('pure', Inputs.pure(value, type));
  }

  Map<String, dynamic> pureBool(bool value) {
		return _input('pure', Inputs.pure(value, BCS.BOOL));
  }

  Map<String, dynamic> pureAddress(String address) {
		return _input('pure', Inputs.pure(address, BCS.ADDRESS));
  }

  Map<String, dynamic> pureString(String str) {
		return _input('pure', Inputs.pure(str, BCS.STRING));
  }

  Map<String, dynamic> pureHex(String hex) {
		return _input('pure', Inputs.pure(hex, BCS.HEX));
  }

  Map<String, dynamic> pureVector<T>(List<T> vector, String type) {
		return _input('pure', Inputs.pure(vector, "${BCS.VECTOR}<$type>"));
  }

  Map<String, dynamic> pureBase64(String value) {
		return _input('pure', Inputs.pure(value, BCS.BASE64));
  }

	/// Add a transaction to the transaction block.
	TransactionResult add(dynamic transaction) {
		_blockData.transactions.add(transaction);
		return TransactionResult(_blockData.transactions.length - 1);
	}

	// Method shorthands:

	TransactionResult splitCoins(Map<String, dynamic> coin, List<Map<String, dynamic>> amounts) {
		return add(Transactions.splitCoins(coin, amounts));
	}

	TransactionResult mergeCoins(Map<String, dynamic> destination, List<Map<String, dynamic>> sources) {
		return add(Transactions.mergeCoins(destination, sources));
	}

	TransactionResult publish(List<String> modules, List<String> dependencies) {
		return add(Transactions.publish(modules, dependencies));
	}

	TransactionResult upgrade({
		required List<String> modules,
		required List<String> dependencies,
		required String packageId,
		required dynamic ticket,
	}) {
		return add(Transactions.upgrade(
      modules: modules,
      dependencies: dependencies,
      packageId: packageId,
      ticket: ticket
    ));
	}

	TransactionResult moveCall(
    String target, {
    List? typeArguments,
    List? arguments
	}) {
		return add(Transactions.moveCall(
      target: target,
      typeArguments: typeArguments,
      arguments: arguments
    ));
	}

	TransactionResult transferObjects(List<dynamic> objects, dynamic address) {
		return add(Transactions.transferObjects(objects, address));
	}

	TransactionResult makeMoveVec({
    required dynamic objects,
    String? type
  }) {
		return add(Transactions.makeMoveVec(objects: objects, type: type));
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
	String serialize() {
		return jsonEncode(_blockData.snapshot());
	}

	String _getConfig(String key, BuildOptions options) {
		// Use the limits definition if that exists:
		if (options.limits != null && options.limits[key] is int) {
			return options.limits[key]!;
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

	// The current default is just picking _all_ coins we can which may not be ideal.
	Future<void> _prepareGasPayment(BuildOptions options) async {
		if (_blockData.gasConfig.payment != null) {
			final maxGasObjects = int.parse(_getConfig('maxGasObjects', options));
			if (_blockData.gasConfig.payment!.length > maxGasObjects) {
				throw ArgumentError("Payment objects exceed maximum amount: $maxGasObjects");
			}
		}

		// Early return if the payment is already set:
		if ((options.onlyTransactionKind) || _blockData.gasConfig.payment != null) {
			return;
		}

		final gasOwner = _blockData.gasConfig.owner ?? _blockData.sender;

		final coins = await expectClient(options).getCoins(gasOwner!, coinType: SUI_TYPE_ARG);

		final paymentCoins = coins.data
			// Filter out coins that are also used as input:
			.where((coin) {
				final matchingInput = _blockData.inputs.indexWhere((input) {
          final iv = input["value"];
					if (iv is Map && iv["Object"]?["ImmOrOwned"] != null) {
						return coin.coinObjectId == iv["Object"]["ImmOrOwned"]["objectId"];
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
		if (options.onlyTransactionKind || _blockData.gasConfig.price != null) {
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
    final transactions = _blockData.transactions;

    final moveModulesToResolve = [];

		// Keep track of the object references that will need to be resolved at the end of the transaction.
		// We keep the input by-reference to avoid needing to re-resolve it:
		final objectsToResolve = [];

    for (var transaction in transactions) {
      if (transaction["kind"] == "MoveCall") {
        bool needsResolution = (transaction["arguments"] as List).any(
                                (arg) => arg is Map &&
                                arg['kind'] == 'Input' && 
                                !(isBuilderCallArg(inputs[arg['index']]["value"])));
        if (needsResolution) {
          moveModulesToResolve.add(transaction);
        }

        continue;
      }

      final transactionType = transaction["kind"];

      (transaction as Map).forEach((key, value) {
				if (key == 'kind') return;

        var wellKnownEncoding = WellKnownEncoding.getWellKnownEncoding(transactionType, key);
        if (wellKnownEncoding == null) return;
        
				void encodeInput(int index) {
					if (inputs.length <= index) {
						throw ArgumentError("Missing input ${value["index"]}");
					}

					final input = inputs[index];
					// Input is fully resolved:
					if (isBuilderCallArg(input["value"])) return;
					if (wellKnownEncoding["kind"] == 'object' && input["value"] is String) {
						// The input is a string that we need to resolve to an object reference:
						objectsToResolve.add({ "id": input["value"], "input": input });
					} else if (wellKnownEncoding["kind"] == 'pure') {
						// Pure encoding, so construct BCS bytes:
						input["value"] = Inputs.pure(input["value"], wellKnownEncoding["type"]);
					} else {
						throw ArgumentError('Unexpected input format.');
					}
				}

				if (value is Iterable) {
					for (var item in value) {
						if (item["kind"] != 'Input') continue;
						encodeInput(item["index"]);
					}
				} else {
					if (value["kind"] != 'Input') return;
					encodeInput(value["index"]);
				}

      });
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

        if (params.length != moveCall["arguments"].length) {
          throw ArgumentError('Incorrect number of arguments.');
        }

        for (int i = 0; i < params.length; i++) {
          final param = params[i];
          final arg = moveCall["arguments"][i];
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
          if (structVal != null || (param["TypeParameter"] != null)) {
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
          final mutable =
            isMutableSharedObjectInput(input["value"]) ||
            (normalizedType != null && extractMutableReference(normalizedType) != null);

          input["value"] = Inputs.sharedObjectRef({
            "objectId": id,
            "initialSharedVersion": initialSharedVersion,
            "mutable": mutable,
          });
        } else {
          input["value"] = Inputs.objectRef(getObjectReference(object as SuiObjectResponse)!);
        }

      }
    }

  }

	/// Prepare the transaction by valdiating the transaction data and resolving all inputs
	/// so that it can be built into bytes.
	Future<void> _prepare(BuildOptions options) async {
		if (options.onlyTransactionKind && _blockData.sender == null) {
			throw ArgumentError('Missing transaction sender');
		}

		final client = options.client;

		if (options.protocolConfig == null && options.limits == null && client != null) {
			options.protocolConfig = await client.getProtocolConfig();
		}

    await Future.wait([_prepareGasPrice(options), _prepareTransactions(options)]);

		if (options.onlyTransactionKind != true) {
			await _prepareGasPayment(options);

			if (_blockData.gasConfig.budget == null) {
				final dryRunResult = await expectClient(options).dryRunTransaction(
					_blockData.build(
						maxSizeBytes: int.parse(_getConfig('maxTxSizeBytes', options)),
            gasConfig: GasConfig(
              budget: BigInt.tryParse(_getConfig('maxTxGas', options)),
              payment: []
            )
					),
          _blockData.sender
				);

				if (dryRunResult.effects.status.status != ExecutionStatusType.success) {
					throw ArgumentError(
						"Dry run failed, could not automatically determine a budget: ${dryRunResult.effects.status.error}"
					);
				}

				final safeOverhead = GAS_SAFE_OVERHEAD * (blockData.gasConfig.price ?? BigInt.one);

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
}
