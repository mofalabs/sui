
import 'package:bcs/bcs.dart';
import 'package:sui/bcs/type_tag_serializer.dart';
import 'package:sui/builder/transaction_block_data.dart';

class TransactionDataV1 {
	GasConfig gasConfig;
	int version;
	String? sender;
	TransactionExpiration? expiration;
	List<Map<String, dynamic>>? inputs;
	List<Map<dynamic, dynamic>>? transactions;

  TransactionDataV1({
    required this.gasConfig, 
    required this.inputs,
    required this.transactions,
    this.version = 1, 
    this.sender, 
    this.expiration
  });

  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "sender": sender,
      "expiration": expiration?.toJson(),
      "gasConfig": gasConfig.toJson(),
      "inputs": inputs,
      "transactions": transactions
    };
  }

  factory TransactionDataV1.fromJson(Map<String, dynamic> data) {
    return TransactionDataV1(
      version: data["version"] ?? 1,
      gasConfig: GasConfig.fromJson(data["gasData"]),
      inputs: List<Map<String, dynamic>>.from(data["inputs"]),
      transactions: (data["transactions"] as List).cast<Map<dynamic, dynamic>>(),
      sender: data["sender"],
      expiration: TransactionExpiration.fromJson(data["expiration"])
    );
  }
}

TransactionDataV1 serializeV1TransactionData(TransactionData transactionData) {
  final inputs = <Map<String, dynamic>>[];
  final len = transactionData.inputs?.length ?? 0;
  for (var index = 0; index < len; index++) {
    final input = transactionData.inputs![index];
    if (input["Object"] != null) {
      inputs.add({
        "kind": 'Input',
        "index": index,
        "value": {
          'Object': input["Object"]["ImmOrOwnedObject"] != null
                    ? {"ImmOrOwned": input["Object"]["ImmOrOwnedObject"]}
                    : input["Object"]["Receiving"] != null
                      ?
                        {
                          "Receiving": {
                            "digest": input["Object"]["Receiving"]["digest"],
                            "version": input["Object"]["Receiving"]["version"],
                            "objectId": input["Object"]["Receiving"]["objectId"]
                          }
                        }
                      : {
                          "Shared": {
                            "mutable": input["Object"]["SharedObject"]["mutable"],
                            "initialSharedVersion": input["Object"]["SharedObject"]["initialSharedVersion"],
                            "objectId": input["Object"]["SharedObject"]["objectId"]
                          }
                        }
        },
        "type": 'object'
      });
    } else if (input["Pure"] != null) {
      inputs.add({
        "kind": 'Input',
        "index": index,
        "value": {
          "Pure": fromB64(input["Pure"]["bytes"]),
        },
        "type": 'pure',
      });
    } else if (input["UnresolvedPure"] != null) {
      inputs.add({
        "kind": 'Input',
        "type": 'pure',
        "index": index,
        "value": input["UnresolvedPure"]["value"],
      });
    } else if (input["UnresolvedObject"] != null) {
      inputs.add({
        "kind": 'Input',
        "type": 'object',
        "index": index,
        "value": input["UnresolvedObject"]["objectId"],
      });
    } else {
      throw ArgumentError('Invalid input');
    }
  }

  return TransactionDataV1(
    version: 1,
    sender: transactionData.sender,
    expiration: transactionData.expiration,
    gasConfig: GasConfig(
      owner: transactionData.gasData.owner,
      budget: transactionData.gasData.budget,
      price: transactionData.gasData.price,
      payment: transactionData.gasData.payment,
    ),
    inputs: inputs,
    transactions: transactionData.commands?.map<Map<String, dynamic>>((command) {
      if (command["MakeMoveVec"] != null) {
				return {
					"kind": 'MakeMoveVec',
					"type":
						command["MakeMoveVec"]["type"] == null
							? { "None": true }
							: { "Some": TypeTagSerializer.parseFromStr(command["MakeMoveVec"]["type"]) },
					"objects": command["MakeMoveVec"]["elements"].map((arg) =>
						convertTransactionArgument(arg, inputs)
					),
				};
			} else if (command["MergeCoins"] != null) {
				return {
					"kind": 'MergeCoins',
					"destination": convertTransactionArgument(command["MergeCoins"]["destination"], inputs),
					"sources": command["MergeCoins"]["sources"].map((arg) => convertTransactionArgument(arg, inputs)),
				};
			} else if (command["MoveCall"] != null) {
				return {
					"kind": 'MoveCall',
					"target": "${command["MoveCall"]["package"]}::${command["MoveCall"]["module"]}::${command["MoveCall"]["function"]}",
					"typeArguments": command["MoveCall"]["typeArguments"],
					"arguments": command["MoveCall"]["arguments"].map((arg) =>
						convertTransactionArgument(arg, inputs),
					),
				};
			} else if (command["Publish"] != null) {
				return {
					"kind": 'Publish',
					"modules": command["Publish"]["modules"].map((mod) => fromB64(mod)),
					"dependencies": command["Publish"]["dependencies"],
				};
			} else if (command["SplitCoins"] != null) {
				return {
					"kind": 'SplitCoins',
					"coin": convertTransactionArgument(command["SplitCoins"]["coin"], inputs),
					"amounts": command["SplitCoins"]["amounts"].map((arg) => convertTransactionArgument(arg, inputs)),
				};
			} else if (command["TransferObjects"]) {
				return {
					"kind": 'TransferObjects',
					"objects": command["TransferObjects"]["objects"].map((arg) =>
						convertTransactionArgument(arg, inputs),
					),
					"address": convertTransactionArgument(command["TransferObjects"]["address"], inputs),
				};
			} else if (command["Upgrade"] != null) {
				return {
					"kind": 'Upgrade',
					"modules": command["Upgrade"]["modules"].map((mod) => fromB64(mod)),
					"dependencies": command["Upgrade"]["dependencies"],
					"packageId": command["Upgrade"]["package"],
					"ticket": convertTransactionArgument(command["Upgrade"]["ticket"], inputs),
				};
			} else {
        throw ArgumentError("Unknown transaction $command");
      }
    }).toList(),
  );
}

dynamic convertTransactionArgument(dynamic arg, dynamic inputs) {
	if (arg["\$kind"] == 'GasCoin' || arg["GasCoin"] != null) {
		return { "kind": 'GasCoin' };
	}
	if (arg["\$kind"] == 'Result' || arg["Result"] != null) {
		return { "kind": 'Result', "index": arg["Result"] };
	}
	if (arg["\$kind"] == 'NestedResult' || arg["NestedResult"] != null) {
		return { "kind": 'NestedResult', "index": arg["NestedResult"][0], "resultIndex": arg["NestedResult"][1] };
	}
	if (arg["\$kind"] == 'Input' || arg["Input"] != null) {
		return inputs[arg["Input"]];
	}

	throw ArgumentError("Invalid argument $arg");
}

dynamic transactionDataFromV1(dynamic data) {

  dynamic expiration;
  if (data["expiration"] != null) {
    if (data["expiration"]["Epoch"] != null) {
      expiration = { "Epoch": data["expiration"]["Epoch"] };
    } else {
      expiration = { "None": true };
    }
  }

	return {
		"version": 2,
		"sender": data["sender"],
		"expiration": expiration,
		"gasData": {
			"owner": data["gasConfig"]?["owner"],
			"budget": data["gasConfig"]?["budget"]?.toString(),
			"price": data["gasConfig"]?["price"]?.toString(),
			"payment":
				data["gasConfig"]?["payment"]?.map((ref) => ({
					"digest": ref["digest"],
					"objectId": ref["objectId"],
					"version": ref["version"]?.toString(),
				})),
		},
		"inputs": data["inputs"]?.map((input) {
			if (input["kind"] == 'Input') {
				if (input["value"] == "Object" || input["value"] == "Pure") {
          final value = input["value"];

					if (value["Object"] != null) {
						if (value["Object"]["ImmOrOwned"] != null) {
							return {
								"Object": {
									"ImmOrOwnedObject": {
										"objectId": value["Object"]["ImmOrOwned"]["objectId"],
										"version": value["Object"]["ImmOrOwned"]["version"]?.toString(),
										"digest": value["Object"]["ImmOrOwned"]["digest"],
									},
								},
							};
						}
						if (value["Object"]["Shared"] != null) {
							return {
								"Object": {
									"SharedObject": {
										"mutable": value["Object"]["Shared"]["mutable"],
										"initialSharedVersion": value["Object"]["Shared"]["initialSharedVersion"],
										"objectId": value["Object"]["Shared"]["objectId"],
									},
								},
							};
						}
						if (value["Object"]["Receiving"] != null) {
							return {
								"Object": {
									"Receiving": {
										"digest": value["Object"]["Receiving"]["digest"],
										"version": value["Object"]["Receiving"]["version"]?.toString(),
										"objectId": value["Object"]["Receiving"]["objectId"],
									},
								},
							};
						}

						throw ArgumentError('Invalid object input');
					}

					return {
						"Pure": {
              "bytes": toB64(value["Pure"]),
							// "bytes": toB64(new Uint8Array(value.Pure)),
						},
					};
				}

				if (input["type"] == 'object') {
					return {
						"UnresolvedObject": {
							"objectId": input["value"]?.toString(),
						},
					};
				}

				return {
					"UnresolvedPure": {
						"value": input["value"],
					},
				};
			}

			throw ArgumentError('Invalid input');
		}),
		"commands": data["transactions"]?.map((transaction) {
			switch (transaction["kind"]) {
				case 'MakeMoveVec':
					return {
						"MakeMoveVec": {
							"type":
								transaction["type"]?["Some"] != null
									? TypeTagSerializer.tagToString(transaction["type"]["Some"])
									: null,
							"elements": transaction["objects"]?.map((arg) => parseV1TransactionArgument(arg)),
						},
					};
				case 'MergeCoins': {
					return {
						"MergeCoins": {
							"destination": parseV1TransactionArgument(transaction["destination"]),
							"sources": transaction["sources"]?.map((arg) => parseV1TransactionArgument(arg)),
						},
					};
				}
				case 'MoveCall': {
					final [pkg, mod, fn] = transaction["target"].split('::');
					return {
						"MoveCall": {
							"package": pkg,
							"module": mod,
							"function": fn,
							"typeArguments": transaction["typeArguments"],
							"arguments": transaction["arguments"]?.map((arg) => parseV1TransactionArgument(arg)),
						},
					};
				}
				case 'Publish': {
					return {
						"Publish": {
							"modules": transaction["modules"]?.map((mod) => toB64(mod)),
							"dependencies": transaction["dependencies"],
						},
					};
				}
				case 'SplitCoins': {
					return {
						"SplitCoins": {
							"coin": parseV1TransactionArgument(transaction["coin"]),
							"amounts": transaction["amounts"]?.map((arg) => parseV1TransactionArgument(arg)),
						},
					};
				}
				case 'TransferObjects': {
					return {
						"TransferObjects": {
							"objects": transaction["objects"]?.map((arg) => parseV1TransactionArgument(arg)),
							"address": parseV1TransactionArgument(transaction["address"]),
						},
					};
				}
				case 'Upgrade': {
					return {
						"Upgrade": {
							"modules": transaction["modules"]?.map((mod) => toB64(mod)),
							"dependencies": transaction["dependencies"],
							"package": transaction["packageId"],
							"ticket": parseV1TransactionArgument(transaction["ticket"]),
						},
					};
				}
			}

			throw Exception("Unknown transaction $transaction");
		}).toList(),
	};
}

dynamic parseV1TransactionArgument(dynamic arg) {
	switch (arg["kind"]) {
		case 'GasCoin': {
			return { ...arg, "GasCoin": true };
		}
		case 'Result':
			return { ...arg, "Result": arg["index"] };
		case 'NestedResult': {
			return { ...arg, "NestedResult": [arg["index"], arg["resultIndex"]] };
		}
		case 'Input': {
			return { ...arg, "Input": arg["index"] };
		}
	}
}
