
import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/builder/bcs.dart';
import 'package:sui/builder/hash.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';
// export const TransactionExpiration = optional(
// 	nullable(
// 		union([object({ Epoch: integer() }), object({ None: union([literal(true), literal(null)]) })]),
// 	),
// );

// export type TransactionExpiration = Infer<typeof TransactionExpiration>;
typedef TransactionExpiration = dynamic;

// const StringEncodedBigint = define<string>('StringEncodedBigint', (val) => {
// 	if (!['string', 'number', 'bigint'].includes(typeof val)) return false;

// 	try {
// 		BigInt(val as string);
// 		return true;
// 	} catch {
// 		return false;
// 	}
// });

// const GasConfig = object({
// 	budget: optional(StringEncodedBigint),
// 	price: optional(StringEncodedBigint),
// 	payment: optional(array(SuiObjectRef)),
// 	owner: optional(string()),
// });
// type GasConfig = Infer<typeof GasConfig>;
class GasConfig {
  BigInt? budget;
  BigInt? price;
  List<SuiObjectRef>? payment;
  String? owner;

  GasConfig({this.budget, this.price, this.payment, this.owner});

   Map<String, dynamic> toJson() {
    return {
      "budget": budget,
      "price": price,
      "payment": payment?.map((e) => e.toJson()).toList(),
      "owner": owner
    };
  }

  factory GasConfig.fromJson(Map<String, dynamic> json) {
    return GasConfig(
      budget: BigInt.tryParse(json["budget"]?.toString() ?? ""),
      price: BigInt.tryParse(json["price"]?.toString() ?? ""),
      payment: json["payment"]?.map<SuiObjectRef>((e) => SuiObjectRef.fromJson(e)).toList(),
      owner: json["owner"]
    );
  }
}

class SerializedTransactionDataBuilder {
	GasConfig gasConfig;
	int version;
	String? sender;
	TransactionExpiration expiration;
	List<dynamic>? inputs;
	List<dynamic>? transactions;

  SerializedTransactionDataBuilder({
    required this.gasConfig, 
    required this.inputs,
    required this.transactions,
    this.version = 1, 
    this.sender, 
    this.expiration
  });

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "expiration": expiration,
      "gasConfig": gasConfig.toJson(),
      "inputs": inputs,
      "transactions": transactions
    };
  }

  factory SerializedTransactionDataBuilder.fromJson(Map<String, dynamic> data) {
    return SerializedTransactionDataBuilder(
      gasConfig: GasConfig.fromJson(data["gasConfig"]),
      inputs: data["inputs"], 
      transactions: data["transactions"],
      sender: data["sender"],
      expiration: data["expiration"]
    );
  }
}

prepareSuiAddress(String address) {
	return normalizeSuiAddress(address).replaceAll('0x', '');
}

class TransactionBlockDataBuilder {
	static fromKindBytes(Uint8List bytes) {
		final kind = builder.de('TransactionKind', bytes);
		final programmableTx = kind?.ProgrammableTransaction;
		if (!programmableTx) {
			throw ArgumentError('Unable to deserialize from bytes.');
		}

		final serialized = {
				"version": 1,
				"gasConfig": GasConfig().toJson(),
				"inputs": programmableTx.inputs.map((dynamic value, int index) =>
						{
							"kind": 'Input',
							"value": value,
							"index": index,
							"type": value["Pure"] != null ? 'pure' : 'object',
						},
				),
				"transactions": programmableTx.transactions,
    };

		return TransactionBlockDataBuilder.restore(serialized);
	}

	static TransactionBlockDataBuilder fromBytes(Uint8List bytes) {
		final rawData = builder.de('TransactionData', bytes);
		final data = rawData?["V1"];
		final programmableTx = data?["kind"]?["ProgrammableTransaction"];
		if (data == null || programmableTx == null) {
			throw ArgumentError('Unable to deserialize from bytes.');
		}

    final inputsList = <dynamic>[];
    List.from(programmableTx["inputs"]).asMap().forEach((index, value) { 
      inputsList.add({
        "kind": 'Input',
        "value": value,
        "index": index,
        "type": value["Pure"] != null ? 'pure' : 'object',
      });
    });

		final serialized = {
				"version": 1,
				"sender": data["sender"],
				"expiration": data["expiration"],
				"gasConfig": data["gasData"],
				"inputs": inputsList,
				"transactions": programmableTx["transactions"],
    };

		return TransactionBlockDataBuilder.restore(serialized);
	}

	static TransactionBlockDataBuilder restore(Map<String, dynamic> data) {
		// assert(data, SerializedTransactionDataBuilder);
		final transactionData = TransactionBlockDataBuilder(
      SerializedTransactionDataBuilder.fromJson(data)
    );
    
		return transactionData;
	}

	/// Generate transaction digest.
	static String getDigestFromBytes(Uint8List bytes) {
		final hash = hashTypedData('TransactionData', bytes);
		return toB58(hash);
	}

	int version = 1;
	String? sender;
	TransactionExpiration? expiration;
	late GasConfig gasConfig;
	late List<dynamic> inputs;
	late List<dynamic> transactions;

	TransactionBlockDataBuilder([SerializedTransactionDataBuilder? clone]) {
		sender = clone?.sender;
		expiration = clone?.expiration;
		gasConfig = clone?.gasConfig ?? GasConfig();
		inputs = clone?.inputs ?? [];
		transactions = clone?.transactions ?? [];
	}

	Uint8List build({
		int? maxSizeBytes,
		String? sender,
    GasConfig? gasConfig,
    TransactionExpiration? expiration,
		bool? onlyTransactionKind,
	}) {
		// Resolve inputs down to values:
		final inputs = this.inputs.map((input) {
			// assert(input["value"], BuilderCallArg);
			return input["value"];
		});

		final kind = {
			"ProgrammableTransaction": {
				"inputs": inputs,
				"transactions": transactions,
			},
		};

		if (onlyTransactionKind != null && onlyTransactionKind) {
      final options = BcsWriterOptions(maxSize: maxSizeBytes);
			return builder.ser('TransactionKind', kind, options).toBytes();
		}

		final expirationValue = expiration ?? this.expiration;
		final senderValue = sender ?? this.sender;
    
    final gasConfigValue = this.gasConfig.toJson();
    if (gasConfig != null) {
      gasConfig.toJson().forEach((key, value) {
        if ((value is Iterable && value.isNotEmpty)) {
            gasConfigValue[key] = value;
        }
        if (value != null && value is! Iterable) {
          gasConfigValue[key] = value;
        }
      });
    }

		if (senderValue == null) {
			throw ArgumentError('Missing transaction sender');
		}

		if (gasConfigValue["budget"] == null) {
			throw ArgumentError('Missing gas budget');
		}

    if (gasConfigValue["payment"] == null) {
			throw ArgumentError('Missing gas payment');
		}

    if (gasConfigValue["price"] == null) {
			throw ArgumentError('Missing gas price');
		}

		final transactionData = {
			"sender": prepareSuiAddress(senderValue),
			"expiration": expirationValue ?? { "None": true },
			"gasData": {
				"payment": gasConfigValue["payment"],
				"owner": prepareSuiAddress(this.gasConfig.owner ?? senderValue),
				"price": BigInt.parse(gasConfigValue["price"].toString()),
				"budget": BigInt.parse(gasConfigValue["budget"].toString()),
			},
			"kind": {
				"ProgrammableTransaction": {
					"inputs": inputs,
					"transactions": transactions,
				},
			},
		};

		return builder
			.ser('TransactionData', { "V1": transactionData }, BcsWriterOptions(maxSize: maxSizeBytes))
			.toBytes();
	}

	String getDigest() {
		final bytes = build(onlyTransactionKind: false);
		return TransactionBlockDataBuilder.getDigestFromBytes(bytes);
	}

	SerializedTransactionDataBuilder snapshot() {
    return SerializedTransactionDataBuilder.fromJson({
      "gasConfig": gasConfig.toJson(), 
      "inputs": inputs, 
      "transactions": transactions,
      "sender": sender,
      "version": version,
      "expiration": expiration
    });
  //  return SerializedTransactionDataBuilder(
  //     gasConfig: gasConfig, 
  //     inputs: inputs, 
  //     transactions: transactions,
  //     sender: sender,
  //     version: version,
  //     expiration: expiration
  //   ); 
  }

}
