
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/builder/hash.dart';
import 'package:sui/builder/v1.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/sui_bcs.dart';

class TransactionExpiration {
  final int? epoch;
  TransactionExpiration({this.epoch});

  Map<String, dynamic> toJson() {
    if (epoch == null) return { "None": true };
    return { "Epoch": epoch };
  }

  factory TransactionExpiration.fromJson(Map<String, dynamic>? json) {
    dynamic epoch = json?["Epoch"];
    if (epoch != null) {
      return TransactionExpiration(epoch: int.parse(epoch.toString()));
    } else {
      return TransactionExpiration(epoch: null);
    }
  }

}

class GasConfig {
  BigInt? budget;
  BigInt? price;
  List<SuiObjectRef>? payment;
  String? owner;

  GasConfig({this.budget, this.price, this.payment, this.owner});

   Map<String, dynamic> toJson() {
    return {
      "budget": budget?.toString(),
      "price": price?.toString(),
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

class TransactionData {
	GasConfig gasData;
	int version;
	String? sender;
	TransactionExpiration? expiration;
	List<Map<String, dynamic>>? inputs;
	List<Map<dynamic, dynamic>>? commands;

  TransactionData({
    required this.gasData, 
    required this.inputs,
    required this.commands,
    this.version = 2, 
    this.sender, 
    this.expiration
  });

  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "sender": sender,
      "expiration": expiration,
      "gasData": gasData,
      "inputs": inputs,
      "commands": commands
    };
  }

  factory TransactionData.fromJson(Map<String, dynamic> data) {
    return TransactionData(
      version: data["version"],
      gasData: GasConfig.fromJson(data["gasData"]),
      inputs: List<Map<String, dynamic>>.from(data["inputs"]),
      commands: (data["commands"] as List).cast<Map<dynamic, dynamic>>(),
      sender: data["sender"],
      expiration: TransactionExpiration.fromJson(data["expiration"])
    );
  }
}

String prepareSuiAddress(String address) {
	return normalizeSuiAddress(address).replaceAll('0x', '');
}

class TransactionBlockDataBuilder {
	static fromKindBytes(Uint8List bytes) {
    final kind = SuiBcs.TransactionKind.parse(bytes);
		final programmableTx = kind["ProgrammableTransaction"];
		if (programmableTx == null) {
			throw ArgumentError('Unable to deserialize from bytes.');
		}
    
		final serialized = {
				"version": 2,
				"gasData": GasConfig().toJson(),
				"inputs": programmableTx["inputs"],
				"commands": programmableTx["commands"],
    };

		return TransactionBlockDataBuilder.restore(serialized);
	}

	static TransactionBlockDataBuilder fromBytes(Uint8List bytes) {
    final rawData = SuiBcs.TransactionData.parse(bytes);
		final data = rawData["V1"];
		final programmableTx = data?["kind"]?["ProgrammableTransaction"];
		if (data == null || programmableTx == null) {
			throw ArgumentError('Unable to deserialize from bytes.');
		}

		final serialized = {
				"version": 2,
				"sender": data["sender"],
				"expiration": data["expiration"],
				"gasData": data["gasData"],
				"inputs": programmableTx["inputs"],
				"commands": programmableTx["commands"],
    };

		return TransactionBlockDataBuilder.restore(serialized);
	}

	static TransactionBlockDataBuilder restore(Map<String, dynamic> data) {
		final transactionData = TransactionBlockDataBuilder(
      TransactionData.fromJson(data["version"] == 2 ? data : transactionDataFromV1(data))
    );
    
		return transactionData;
	}

	/// Generate transaction digest.
	static String getDigestFromBytes(Uint8List bytes) {
		final hash = hashTypedData('TransactionData', bytes);
		return toB58(hash);
	}

	int version = 2;
	String? sender;
	TransactionExpiration? expiration;
	late GasConfig gasData;
	late List<Map<String, dynamic>> inputs;
	late List<Map<dynamic, dynamic>> commands;

	TransactionBlockDataBuilder([TransactionData? clone]) {
		sender = clone?.sender;
		expiration = clone?.expiration;
		gasData = clone?.gasData ?? GasConfig();
		inputs = clone?.inputs ?? [];
		commands = clone?.commands ?? [];
	}

	Uint8List build({
		int? maxSizeBytes,
		String? sender,
    GasConfig? gasConfig,
    TransactionExpiration? expiration,
		bool onlyTransactionKind = false,
	}) {
		final kind = {
			"ProgrammableTransaction": {
				"inputs": inputs,
				"commands": commands,
			},
		};

		if (onlyTransactionKind) {
      final options = BcsWriterOptions(maxSize: maxSizeBytes);
      return SuiBcs.TransactionKind.serialize(kind, options: options).toBytes();
		}

		final expirationValue = expiration ?? this.expiration;
		final senderValue = sender ?? this.sender;
    
    final gasConfigValue = this.gasData.toJson();
    if (gasConfig != null) {
      gasConfig.toJson().forEach((key, value) {
        if (value != null) {
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
			"expiration": expirationValue?.toJson() ?? { "None": true },
			"gasData": {
				"payment": gasConfigValue["payment"],
				"owner": prepareSuiAddress(this.gasData.owner ?? senderValue),
				"price": BigInt.parse(gasConfigValue["price"].toString()),
				"budget": BigInt.parse(gasConfigValue["budget"].toString()),
			},
			"kind": {
				"ProgrammableTransaction": {
					"inputs": inputs,
					"commands": commands,
				},
			},
		};

		return SuiBcs.TransactionData.serialize(
			{ "V1": transactionData },
			options: BcsWriterOptions(maxSize: maxSizeBytes),
		).toBytes();
	}

  dynamic addInput<T>(T type, CallArg arg) {
		final index = inputs.length;
		inputs.add(arg);
    return { "Input": index, "type": type, "\$kind": 'Input'};
	}

	dynamic getInputUses(int index, Function(dynamic arg, dynamic command) fn) {
		mapArguments((arg, command) {
			if (arg["Input"] != null && arg["Input"] == index) {
				fn(arg, command);
			}

			return arg;
		});
	}

mapArguments(dynamic Function(dynamic arg, dynamic command) fn) {
		for (final command in commands) {
      if (command["MoveCall"] != null) {
        command["MoveCall"]["arguments"] = command["MoveCall"]["arguments"].map((arg) => fn(arg, command));
      } else if (command["TransferObjects"] != null) {
					command["TransferObjects"]["objects"] = command["TransferObjects"]["objects"].map((arg) =>
						fn(arg, command),
					);
					command["TransferObjects"]["address"] = fn(command["TransferObjects"]["address"], command);
      } else if (command["SplitCoins"] != null) {
					command["SplitCoins"]["coin"] = fn(command["SplitCoins"]["coin"], command);
					command["SplitCoins"]["amounts"] = command["SplitCoins"]["amounts"].map((arg) => fn(arg, command));
					break;
      } else if (command["MergeCoins"] != null) {
					command["MergeCoins"]["destination"] = fn(command["MergeCoins"]["destination"], command);
					command["MergeCoins"]["sources"] = command["MergeCoins"]["sources"].map((arg) => fn(arg, command));
					break;
      } else if (command["MakeMoveVec"] != null) {
					command["MakeMoveVec"]["elements"] = command["MakeMoveVec"]["elements"].map((arg) =>
						fn(arg, command),
					);
      } else if (command["Upgrade"] != null) {
        command["Upgrade"]["ticket"] = fn(command["Upgrade"]["ticket"], command);
      } else if (command["Intent"] != null) {
					final inputs = command["Intent"]["inputs"];
					command["Intent"]["inputs"] = {};

					for (final [key, value] in inputs) {
						command["Intent"]["inputs"][key] = value is Iterable
							? value.map((arg) => fn(arg, command))
							: fn(value, command);
					}
      } else if (command["Publish"] != null) {

      } else {
        throw ArgumentError("Unexpected transaction kind: $command");
      }
    }
	}

	String getDigest() {
		final bytes = build(onlyTransactionKind: false);
		return TransactionBlockDataBuilder.getDigestFromBytes(bytes);
	}

	TransactionData snapshot() {
    return TransactionData.fromJson({
      "gasData": gasData.toJson(),
      "inputs": inputs, 
      "commands": commands,
      "sender": sender,
      "version": version,
      "expiration": expiration?.toJson()
    });
  }

}
