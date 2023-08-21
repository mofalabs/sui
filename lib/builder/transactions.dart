
import 'package:bcs/bcs.dart';
import 'package:sui/builder/type_tag_serializer.dart';
import 'package:sui/types/common.dart';

/// Simple helpers used to construct transactions:
class Transactions {

	static dynamic MoveCall({
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

	static dynamic TransferObjects(
		List objects,
		dynamic address
	) {
		return { "kind": 'TransferObjects', "objects": objects, "address": address };
	}

	static dynamic SplitCoins(dynamic coin, dynamic amounts) {
		return { "kind": 'SplitCoins', "coin": coin, "amounts": amounts };
	}

	static dynamic MergeCoins(
		dynamic destination,
		List sources,
	) {
		return { "kind": 'MergeCoins', "destination": destination, "sources": sources };
	}

	static dynamic Publish(
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

	static dynamic Upgrade({
		dynamic modules,
		dynamic dependencies,
		dynamic packageId,
		dynamic ticket,
	}) {
		return
			{
				"kind": 'Upgrade',
				"modules": modules.map((module) =>
					module is String ? fromB64(module) : module,
				),
				"dependencies": dependencies.map((dep) => normalizeSuiObjectId(dep)),
				"packageId": packageId,
				"ticket": ticket,
			};
	}

	static dynamic MakeMoveVec({
		required dynamic objects,
		dynamic type,
	}) {
		return
			{
				"kind": 'MakeMoveVec',
				"type": type != null ? { "Some": TypeTagSerializer.parseFromStr(type) } : { "None": null },
				"objects": objects,
			};
	}
}
