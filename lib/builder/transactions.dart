
import 'package:bcs/bcs.dart';
import 'package:sui/builder/type_tag_serializer.dart';
import 'package:sui/types/common.dart';

// const option = <T extends Struct<any, any>>(some: T) =>
// 	union([object({ None: union([literal(true), literal(null)]) }), object({ Some: some })]);

// export const TransactionBlockInput = object({
// 	kind: literal('Input'),
// 	index: integer(),
// 	value: optional(any()),
// 	type: optional(union([literal('pure'), literal('object')])),
// });
// export type TransactionBlockInput = Infer<typeof TransactionBlockInput>;

// const TransactionArgumentTypes = [
// 	TransactionBlockInput,
// 	object({ kind: literal('GasCoin') }),
// 	object({ kind: literal('Result'), index: integer() }),
// 	object({
// 		kind: literal('NestedResult'),
// 		index: integer(),
// 		resultIndex: integer(),
// 	}),
// ] as const;

// // Generic transaction argument
// export const TransactionArgument = union([...TransactionArgumentTypes]);
// export type TransactionArgument = Infer<typeof TransactionArgument>;

// // Transaction argument referring to an object:
// export const ObjectTransactionArgument = union([...TransactionArgumentTypes]);
// (ObjectTransactionArgument as any)[TRANSACTION_TYPE] = {
// 	kind: 'object',
// } as WellKnownEncoding;

// export const PureTransactionArgument = (type: string) => {
// 	const struct = union([...TransactionArgumentTypes]);
// 	(struct as any)[TRANSACTION_TYPE] = {
// 		kind: 'pure',
// 		type,
// 	} as WellKnownEncoding;
// 	return struct;
// };

// export const MoveCallTransaction = object({
// 	kind: literal('MoveCall'),
// 	target: define<`${string}::${string}::${string}`>('target', string().validator),
// 	typeArguments: array(string()),
// 	arguments: array(TransactionArgument),
// });
// export type MoveCallTransaction = Infer<typeof MoveCallTransaction>;

// export const TransferObjectsTransaction = object({
// 	kind: literal('TransferObjects'),
// 	objects: array(ObjectTransactionArgument),
// 	address: PureTransactionArgument(BCS.ADDRESS),
// });
// export type TransferObjectsTransaction = Infer<typeof TransferObjectsTransaction>;

// export const SplitCoinsTransaction = object({
// 	kind: literal('SplitCoins'),
// 	coin: ObjectTransactionArgument,
// 	amounts: array(PureTransactionArgument('u64')),
// });
// export type SplitCoinsTransaction = Infer<typeof SplitCoinsTransaction>;

// export const MergeCoinsTransaction = object({
// 	kind: literal('MergeCoins'),
// 	destination: ObjectTransactionArgument,
// 	sources: array(ObjectTransactionArgument),
// });
// export type MergeCoinsTransaction = Infer<typeof MergeCoinsTransaction>;

// export const MakeMoveVecTransaction = object({
// 	kind: literal('MakeMoveVec'),
// 	// TODO: ideally we should use `TypeTag` instead of `record()` here,
// 	// but TypeTag is recursively defined and it's tricky to define a
// 	// recursive struct in superstruct
// 	type: optional(option(record(string(), unknown()))),
// 	objects: array(ObjectTransactionArgument),
// });
// export type MakeMoveVecTransaction = Infer<typeof MakeMoveVecTransaction>;

// export const PublishTransaction = object({
// 	kind: literal('Publish'),
// 	modules: array(array(integer())),
// 	dependencies: array(string()),
// });
// export type PublishTransaction = Infer<typeof PublishTransaction>;

// // Keep in sync with constants in
// // crates/sui-framework/packages/sui-framework/sources/package.move
// export enum UpgradePolicy {
// 	COMPATIBLE = 0,
// 	ADDITIVE = 128,
// 	DEP_ONLY = 192,
// }

// export const UpgradeTransaction = object({
// 	kind: literal('Upgrade'),
// 	modules: array(array(integer())),
// 	dependencies: array(string()),
// 	packageId: string(),
// 	ticket: ObjectTransactionArgument,
// });
// export type UpgradeTransaction = Infer<typeof UpgradeTransaction>;

// const TransactionTypes = [
// 	MoveCallTransaction,
// 	TransferObjectsTransaction,
// 	SplitCoinsTransaction,
// 	MergeCoinsTransaction,
// 	PublishTransaction,
// 	UpgradeTransaction,
// 	MakeMoveVecTransaction,
// ] as const;

// export const TransactionType = union([...TransactionTypes]);
// export type TransactionType = Infer<typeof TransactionType>;

// dynamic getTransactionType(dynamic data) {
// 	// return TransactionTypes.find((schema) => is(data, schema as Struct))!;
//   return TransactionTypes.firstWhere((schema) => is(data, schema as Struct));

// }

/**
 * Simple helpers used to construct transactions:
 */
class Transactions {
	static dynamic MoveCall(
		dynamic input
	) {
		return 
			{
				"kind": 'MoveCall',
				"target": input["target"],
				"arguments": input["arguments"] ?? [],
				"typeArguments": input["typeArguments"] ?? [],
			};
	}

	static dynamic TransferObjects(
		dynamic objects,
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

	static dynamic Publish({
		dynamic modules,
		dynamic dependencies
	}) {
		return
			{
				"kind": 'Publish',
				"modules": modules.map((module) =>
					module is String ? fromB64(module) : module,
				),
				dependencies: dependencies.map((dep) => normalizeSuiObjectId(dep)),
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
		dynamic type,
		dynamic objects,
	}) {
		return
			{
				"kind": 'MakeMoveVec',
				"type": type ? { "Some": TypeTagSerializer.parseFromStr(type) } : { "None": null },
				"objects": objects,
			};
	}
}
