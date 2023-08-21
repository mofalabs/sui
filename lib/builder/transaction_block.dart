
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/builder/transactions.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

typedef TransactionResult = dynamic;

const DefaultOfflineLimits = {
	"maxPureArgumentSize": 16 * 1024,
	"maxTxGas": 50000000000,
	"maxGasObjects": 256,
	"maxTxSizeBytes": 128 * 1024,
};

TransactionResult createTransactionResult(int index) {
	final baseResult = { "kind": 'Result', "index": index };

	// final nestedResults = [];
	// final nestedResultFor = (int resultIndex) =>
	// 	(nestedResults[resultIndex] ??= {
	// 		"kind": 'NestedResult',
	// 		"index": index,
	// 		"resultIndex": resultIndex,
	// 	});

	return baseResult;
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

// const chunk = <T>(arr: T[], size: number): T[][] =>
// 	Array.from({ length: Math.ceil(arr.length / size) }, (_, i) =>
// 		arr.slice(i * size, i * size + size),
// 	);

class BuildOptions {
	SuiClient? client;
	bool? onlyTransactionKind;
	/// Define a protocol config to build against, instead of having it fetched from the provider at build time.
	dynamic protocolConfig;
	/// Define limits that are used when building the transaction. In general, we recommend using the protocol configuration instead of defining limits.
	Limits? limits;

  BuildOptions({this.client, this.onlyTransactionKind, this.protocolConfig, this.limits});
}

class SignOptions extends BuildOptions {
	Keypair signer;

  SignOptions(this.signer);
}

class TransactionBlock {

	/// Converts from a serialize transaction kind (built with `build({ onlyTransactionKind: true })`) to a `Transaction` class.
	/// Supports either a byte array, or base64-encoded bytes.
	static fromKind(dynamic serialized) {
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

	setSender(String sender) {
		_blockData.sender = sender;
	}

	/// Sets the sender only if it has not already been set.
	/// This is useful for sponsored transaction flows where the sender may not be the same as the signer address.
	setSenderIfNotSet(String sender) {
		_blockData.sender ??= sender;
	}
	setExpiration(TransactionExpiration? expiration) {
		_blockData.expiration = expiration;
	}
	setGasPrice(BigInt price) {
		_blockData.gasConfig.price = price;
	}
	setGasBudget(BigInt budget) {
		_blockData.gasConfig.budget = budget;
	}
	setGasOwner(String owner) {
		_blockData.gasConfig.owner = owner;
	}
	setGasPayment(List<SuiObjectRef> payments) {
		_blockData.gasConfig.payment = payments;
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
	get gas {
		return { "kind": 'GasCoin' };
	}

	/**
	 * Dynamically create a new input, which is separate from the `input`. This is important
	 * for generated clients to be able to define unique inputs that are non-overlapping with the
	 * defined inputs.
	 *
	 * For `Uint8Array` type automatically convert the input into a `Pure` CallArg, since this
	 * is the format required for custom serialization.
	 *
	 */
	_input(String type, dynamic value) {
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
	object(dynamic value) {
		final id = getIdFromCallArg(value);
		// deduplicate
		final inserted = _blockData.inputs.firstWhere(
			(i) => i["type"] == 'object' && id == getIdFromCallArg(i["value"]),
      orElse: () => null,
		);
		return inserted ?? _input('object', value);
	}

	/// Add a new object input to the transaction using the fully-resolved object reference.
	/// If you only have an object ID, use `builder.object(id)` instead.
	objectRef(SuiObjectRef args) {
		return object(Inputs.ObjectRef(args));
	}

	/// Add a new shared object input to the transaction using the fully-resolved shared object reference.
	/// If you only have an object ID, use `builder.object(id)` instead.
	sharedObjectRef(dynamic args) {
		return object(Inputs.SharedObjectRef(args));
	}

	/// Add a new non-object input to the transaction.
	Map<String, dynamic> pure(
		/// The pure value that will be used as the input value. If this is a Uint8Array, then the value
		/// is assumed to be raw bytes, and will be used directly.
		dynamic value,
		/// The BCS type to serialize the value into. If not provided, the type will automatically be determined
		/// based on how the input is used.
		[String? type]
	) {
		// TODO: we can also do some deduplication here
		return _input(
			'pure',
			value is Uint8List ? Inputs.Pure(value) : type != null ? Inputs.Pure(value, type) : value,
		);
	}

	/// Add a transaction to the transaction block.
	TransactionResult add(dynamic transaction) {
		_blockData.transactions.add(transaction);
		return createTransactionResult(_blockData.transactions.length - 1);
	}

	// Method shorthands:

	splitCoins(dynamic coin, List amounts) {
		return add(Transactions.SplitCoins(coin, amounts));
	}

	mergeCoins(dynamic destination, List sources) {
		return add(Transactions.MergeCoins(destination, sources));
	}

	publish(List<String> modules, List<String> dependencies) {
		return add(Transactions.Publish(modules, dependencies));
	}

	// upgrade(dynamic args) {
	// 	return add(Transactions.Upgrade(args));
	// }

	moveCall({
    required String target,
    List? typeArguments,
    List? arguments
	}) {
		return add(Transactions.MoveCall(
      target: target,
      typeArguments: typeArguments,
      arguments: arguments
    ));
	}

	transferObjects(List<dynamic> objects, dynamic address) {
		return add(Transactions.TransferObjects(objects, address));
	}

	makeMoveVec({
    required dynamic objects,
    dynamic type
  }) {
		return add(Transactions.MakeMoveVec(objects: objects, type: type));
	}

	/**
	 * Serialize the transaction to a string so that it can be sent to a separate context.
	 * This is different from `build` in that it does not serialize to BCS bytes, and instead
	 * uses a separate format that is unique to the transaction builder. This allows
	 * us to serialize partially-complete transactions, that can then be completed and
	 * built in a separate context.
	 *
	 * For example, a dapp can construct a transaction, but not provide gas objects
	 * or a gas budget. The transaction then can be sent to the wallet, where this
	 * information is automatically filled in (e.g. by querying for coin objects
	 * and performing a dry run).
	 */
	String serialize() {
		return jsonEncode(_blockData.snapshot());
	}

	_getConfig(dynamic key, BuildOptions options) {
		// Use the limits definition if that exists:
		if (options.limits != null && options.limits[key] is int) {
			return options.limits[key]!;
		}

		if (options.protocolConfig == null) {
			return DefaultOfflineLimits[key];
		}

		// Fallback to protocol config:
		final attribute = options.protocolConfig?["attributes"][LIMITS[key]];
		if (attribute == null) {
			throw ArgumentError('Missing expected protocol config: "${LIMITS[key]}"');
		}

		final value =
			attribute.containsKey("u64") ? attribute["u64"] : attribute.containsKey("u32") ? attribute["u32"] : attribute["f64"];

		if (value == null) {
			throw ArgumentError('Unexpected protocol config value found for: "${LIMITS[key]}"');
		}

		// NOTE: Technically this is not a safe conversion, but we know all of the values in protocol config are safe
		return value;
	}

	/// Build the transaction to BCS bytes, and sign it with the provided keypair.
	Future<dynamic> sign(SignOptions options) async {
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

	_validate(BuildOptions options) {
		final maxPureArgumentSize = int.parse(_getConfig('maxPureArgumentSize', options).toString());
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
	_prepareGasPayment(BuildOptions options) async {
		if (_blockData.gasConfig.payment != null) {
			final maxGasObjects = int.parse(_getConfig('maxGasObjects', options));
			if (_blockData.gasConfig.payment!.length > maxGasObjects) {
				throw ArgumentError("Payment objects exceed maximum amount: $maxGasObjects");
			}
		}

		// Early return if the payment is already set:
		if ((options.onlyTransactionKind ?? false) || _blockData.gasConfig.payment != null) {
			return;
		}

		final gasOwner = _blockData.gasConfig.owner ?? _blockData.sender;

		final coins = await expectClient(options).getCoins(gasOwner!, coinType: SUI_TYPE_ARG);

		final paymentCoins = coins.data
			// Filter out coins that are also used as input:
			.where((coin) {
				final matchingInput = _blockData.inputs.indexOf((input) {
          final iv = input["value"];
					if (iv.containsKey("Object") && iv["Object"].containsKey("ImmOrOwned")) {
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
			  .map((coin) => SuiObjectRef(coin.digest, coin.coinObjectId, int.parse(coin.version)))
        .toList();

		if (paymentCoins.isEmpty) {
			throw ArgumentError('No valid gas coins found for the transaction.');
		}

		setGasPayment(usePaymentCoins);
	}

	_prepareGasPrice(BuildOptions options) async {
		if (options.onlyTransactionKind != null || _blockData.gasConfig.price != null) {
			return;
		}

    final gasPrice = await expectClient(options).provider.getReferenceGasPrice();
		setGasPrice(gasPrice);
	}

	// _prepareTransactions(BuildOptions options) async {
  //   final inputs = _blockData.inputs;
  //   final transactions = _blockData.transactions;

	// 	List<MoveCallTransaction> moveModulesToResolve = [];

	// 	// Keep track of the object references that will need to be resolved at the end of the transaction.
	// 	// We keep the input by-reference to avoid needing to re-resolve it:
	// 	const objectsToResolve: {
	// 		id: string;
	// 		input: TransactionBlockInput;
	// 		normalizedType?: SuiMoveNormalizedType;
	// 	}[] = [];

	// 	transactions.forEach((transaction) {
	// 		// Special case move call:
	// 		if (transaction["kind"] == 'MoveCall') {
	// 			// Determine if any of the arguments require encoding.
	// 			// - If they don't, then this is good to go.
	// 			// - If they do, then we need to fetch the normalized move module.
  //       final needsResolution = transaction["arguments"].any(
  //         (arg) => arg['kind'] == 'Input' && inputs[arg['index']].value is! BuilderCallArg
  //       );

	// 			if (needsResolution) {
	// 				moveModulesToResolve.add(transaction);
	// 			}

	// 			return;
	// 		}

	// 		// Get the matching struct definition for the transaction, and use it to attempt to automatically
	// 		// encode the matching inputs.
	// 		final transactionType = getTransactionType(transaction);
	// 		if (!transactionType.schema) return;

	// 		Object.entries(transaction).forEach(([key, value]) => {
	// 			if (key == 'kind') return;
	// 			const keySchema = (transactionType.schema as any)[key];
	// 			const isArray = keySchema.type == 'array';
	// 			const wellKnownEncoding: WellKnownEncoding = isArray
	// 				? keySchema.schema[TRANSACTION_TYPE]
	// 				: keySchema[TRANSACTION_TYPE];

	// 			// This argument has unknown encoding, assume it must be fully-encoded:
	// 			if (!wellKnownEncoding) return;

	// 			const encodeInput = (index: number) => {
	// 				const input = inputs[index];
	// 				if (!input) {
	// 					throw new Error(`Missing input ${value.index}`);
	// 				}

	// 				// Input is fully resolved:
	// 				if (is(input.value, BuilderCallArg)) return;
	// 				if (wellKnownEncoding.kind == 'object' && typeof input.value == 'string') {
	// 					// The input is a string that we need to resolve to an object reference:
	// 					objectsToResolve.push({ id: input.value, input });
	// 				} else if (wellKnownEncoding.kind == 'pure') {
	// 					// Pure encoding, so construct BCS bytes:
	// 					input.value = Inputs.Pure(input.value, wellKnownEncoding.type);
	// 				} else {
	// 					throw new Error('Unexpected input format.');
	// 				}
	// 			};

	// 			if (isArray) {
	// 				value.forEach((arrayItem: TransactionArgument) => {
	// 					if (arrayItem.kind != 'Input') return;
	// 					encodeInput(arrayItem.index);
	// 				});
	// 			} else {
	// 				if (value.kind != 'Input') return;
	// 				encodeInput(value.index);
	// 			}
	// 		});
	// 	});

	// 	if (moveModulesToResolve.isNotEmpty) {
	// 		await Promise.all(
	// 			moveModulesToResolve.map(async (moveCall) => {
	// 				const [packageId, moduleName, functionName] = moveCall.target.split('::');

	// 				const normalized = await expectClient(options).getNormalizedMoveFunction({
	// 					package: normalizeSuiObjectId(packageId),
	// 					module: moduleName,
	// 					function: functionName,
	// 				});

	// 				// Entry functions can have a mutable reference to an instance of the TxContext
	// 				// struct defined in the TxContext module as the last parameter. The caller of
	// 				// the function does not need to pass it in as an argument.
	// 				const hasTxContext =
	// 					normalized.parameters.length > 0 && isTxContext(normalized.parameters.at(-1)!);

	// 				const params = hasTxContext
	// 					? normalized.parameters.slice(0, normalized.parameters.length - 1)
	// 					: normalized.parameters;

	// 				if (params.length != moveCall.arguments.length) {
	// 					throw new Error('Incorrect number of arguments.');
	// 				}

	// 				params.forEach((param, i) => {
	// 					const arg = moveCall.arguments[i];
	// 					if (arg.kind != 'Input') return;
	// 					const input = inputs[arg.index];
	// 					// Skip if the input is already resolved
	// 					if (is(input.value, BuilderCallArg)) return;

	// 					const inputValue = input.value;

	// 					const serType = getPureSerializationType(param, inputValue);

	// 					if (serType) {
	// 						input.value = Inputs.Pure(inputValue, serType);
	// 						return;
	// 					}

	// 					const structVal = extractStructTag(param);
	// 					if (structVal != null || (typeof param == 'object' && 'TypeParameter' in param)) {
	// 						if (typeof inputValue != 'string') {
	// 							throw new Error(
	// 								`Expect the argument to be an object id string, got ${JSON.stringify(
	// 									inputValue,
	// 									null,
	// 									2,
	// 								)}`,
	// 							);
	// 						}
	// 						objectsToResolve.push({
	// 							id: inputValue,
	// 							input,
	// 							normalizedType: param,
	// 						});
	// 						return;
	// 					}

	// 					throw new Error(
	// 						`Unknown call arg type ${JSON.stringify(param, null, 2)} for value ${JSON.stringify(
	// 							inputValue,
	// 							null,
	// 							2,
	// 						)}`,
	// 					);
	// 				});
	// 			}),
	// 		);
	// 	}

	// 	if (objectsToResolve.length) {
	// 		final dedupedIds = [...new Set(objectsToResolve.map(({ id }) => id))];
	// 		final objectChunks = chunk(dedupedIds, MAX_OBJECTS_PER_FETCH);
	// 		final objects = (
	// 			await Promise.all(
	// 				objectChunks.map((chunk) =>
	// 					expectClient(options).multiGetObjects({
	// 						ids: chunk,
	// 						options: { showOwner: true },
	// 					}),
	// 				),
	// 			)
	// 		).flat();

	// 		final objectsById = Map(
	// 			dedupedIds.map((id, index) => {
	// 				return [id, objects[index]];
	// 			}),
	// 		);

	// 		const invalidObjects = Array.from(objectsById)
	// 			.filter(([_, obj]) => obj.error)
	// 			.map(([id, _]) => id);
	// 		if (invalidObjects.length) {
	// 			throw ArgumentError("The following input objects are invalid: ${invalidObjects.join(', ')}");
	// 		}

	// 		objectsToResolve.forEach(({ id, input, normalizedType }) => {
	// 			final object = objectsById.get(id)!;
	// 			const owner = object.data?.owner;
	// 			const initialSharedVersion =
	// 				owner && typeof owner === 'object' && 'Shared' in owner
	// 					? owner.Shared.initial_shared_version
	// 					: undefined;

	// 			if (initialSharedVersion) {
	// 				// There could be multiple transactions that reference the same shared object.
	// 				// If one of them is a mutable reference, then we should mark the input
	// 				// as mutable.
	// 				const mutable =
	// 					isMutableSharedObjectInput(input.value) ||
	// 					(normalizedType != null && extractMutableReference(normalizedType) != null);

	// 				input.value = Inputs.SharedObjectRef({
	// 					objectId: id,
	// 					initialSharedVersion,
	// 					mutable,
	// 				});
	// 			} else {
	// 				input.value = Inputs.ObjectRef(getObjectReference(object as SuiObjectResponse)!);
	// 			}
	// 		});
	// 	}
	// }

	/// Prepare the transaction by valdiating the transaction data and resolving all inputs
	/// so that it can be built into bytes.
	_prepare(BuildOptions options) async {
		if (options.onlyTransactionKind == null && _blockData.sender == null) {
			throw ArgumentError('Missing transaction sender');
		}

		final client = options.client;

		if (options.protocolConfig == null && options.limits == null && client != null) {
			options.protocolConfig = await client.provider.getProtocolConfig();
		}

		// await Promise.all([_prepareGasPrice(options), _prepareTransactions(options)]);
    await _prepareGasPrice(options);

		if (options.onlyTransactionKind != true) {
			// await _prepareGasPayment(options);

			if (_blockData.gasConfig.budget == null) {
				final dryRunResult = await expectClient(options).dryRunTransaction(
					_blockData.build(
						maxSizeBytes: int.parse(_getConfig('maxTxSizeBytes', options).toString()),
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
