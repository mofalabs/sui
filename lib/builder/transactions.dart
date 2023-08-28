
import 'package:bcs/bcs.dart';
import 'package:sui/builder/type_tag_serializer.dart';
import 'package:sui/types/common.dart';

/// Simple helpers used to construct transactions:
class Transactions {

	static Map<String, dynamic> moveCall({
    required String target,
    List? typeArguments,
    List? arguments
	}) {
		return 
			{
				"kind": 'MoveCall',
				"target": target,
				"arguments": arguments ?? [],
				"typeArguments": typeArguments ?? [],
			};
	}

	static Map<String, dynamic> transferObjects(
		List objects,
		dynamic address
	) {
		return { "kind": 'TransferObjects', "objects": objects, "address": address };
	}

	static Map<String, dynamic> splitCoins(dynamic coin, dynamic amounts) {
		return { "kind": 'SplitCoins', "coin": coin, "amounts": amounts };
	}

	static Map<String, dynamic> mergeCoins(
		dynamic destination,
		List sources,
	) {
		return { "kind": 'MergeCoins', "destination": destination, "sources": sources };
	}

	static Map<String, dynamic> publish(
		List<String> modules,
		List<String> dependencies
	) {
		return
			{
				"kind": 'Publish',
				"modules": modules.map((m) => fromB64(m)).toList(),
				"dependencies": dependencies.map((dep) => normalizeSuiObjectId(dep)).toList(),
			};
	}

	static Map<String, dynamic> upgrade({
		required List<String> modules,
		required List<String> dependencies,
		required String packageId,
		required dynamic ticket,
	}) {
		return
			{
				"kind": 'Upgrade',
				"modules": modules.map((m) => fromB64(m)).toList(),
				"dependencies": dependencies.map((dep) => normalizeSuiObjectId(dep)),
				"packageId": packageId,
				"ticket": ticket,
			};
	}

	static Map<String, dynamic> makeMoveVec({
		required dynamic objects,
		String? type,
	}) {
		return
			{
				"kind": 'MakeMoveVec',
				"type": type != null ? { "Some": TypeTagSerializer.parseFromStr(type) } : { "None": null },
				"objects": objects,
			};
	}
}
