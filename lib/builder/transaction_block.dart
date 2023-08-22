
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/builder/transactions.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

class TransactionResult {
  final int index;

  TransactionResult(this.index);

  Map<String, dynamic> get result => { "kind": 'Result', "index": index };

  operator [](subIndex) {
    if (int.tryParse(subIndex.toString()) != null) {
      return { "kind": 'NestedResult', "index": index, "resultIndex": subIndex };
    } else {
      return result[subIndex];
    }
  }

  bool containsKey(String key) {
    return result.containsKey(key);
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

	/// Dynamically create a new input, which is separate from the `input`. This is important
	/// for generated clients to be able to define unique inputs that are non-overlapping with the
	/// defined inputs.
	///
	/// For `Uint8Array` type automatically convert the input into a `Pure` CallArg, since this
	/// is the format required for custom serialization.
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
		return _input(
			'pure',
			value is Uint8List ? Inputs.Pure(value) : type != null ? Inputs.Pure(value, type) : value,
		);
	}

  Map<String, dynamic> pureBytes(Uint8List value) {
		return _input('pure', Inputs.Pure(value));
  }

  Map<String, dynamic> pureInt(int value, [String type = BCS.U64]) {
		return _input('pure', Inputs.Pure(value, type));
  }

  Map<String, dynamic> pureBool(bool value) {
		return _input('pure', Inputs.Pure(value, BCS.BOOL));
  }

  Map<String, dynamic> pureAddress(String address) {
		return _input('pure', Inputs.Pure(address, BCS.ADDRESS));
  }

  Map<String, dynamic> pureString(String str) {
		return _input('pure', Inputs.Pure(str, BCS.STRING));
  }

  Map<String, dynamic> pureHex(String hex) {
		return _input('pure', Inputs.Pure(hex, BCS.HEX));
  }

  Map<String, dynamic> pureVector(dynamic vector) {
		return _input('pure', Inputs.Pure(vector, BCS.VECTOR));
  }

  Map<String, dynamic> pureBase64(String value) {
		return _input('pure', Inputs.Pure(value, BCS.BASE64));
  }

	/// Add a transaction to the transaction block.
	TransactionResult add(dynamic transaction) {
		_blockData.transactions.add(transaction);
		return TransactionResult(_blockData.transactions.length - 1);
	}

	// Method shorthands:

	TransactionResult splitCoins(dynamic coin, List amounts) {
		return add(Transactions.SplitCoins(coin, amounts));
	}

	TransactionResult mergeCoins(dynamic destination, List sources) {
		return add(Transactions.MergeCoins(destination, sources));
	}

	TransactionResult publish(List<String> modules, List<String> dependencies) {
		return add(Transactions.Publish(modules, dependencies));
	}

	TransactionResult upgrade({
		required dynamic modules,
		required List<String> dependencies,
		required String packageId,
		required dynamic ticket,
	}) {
		return add(Transactions.Upgrade(
      modules: modules,
      dependencies: dependencies,
      packageId: packageId,
      ticket: ticket
    ));
	}

	TransactionResult moveCall({
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

	TransactionResult transferObjects(List<dynamic> objects, dynamic address) {
		return add(Transactions.TransferObjects(objects, address));
	}

	TransactionResult makeMoveVec({
    required dynamic objects,
    dynamic type
  }) {
		return add(Transactions.MakeMoveVec(objects: objects, type: type));
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
			final maxGasObjects = int.parse(_getConfig('maxGasObjects', options).toString());
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

    await _prepareGasPrice(options);
    // await _prepareTransactions(options);

		if (options.onlyTransactionKind != true) {
			await _prepareGasPayment(options);

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
