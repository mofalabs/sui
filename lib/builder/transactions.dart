import 'package:sui/builder/commands.dart';

/// Legacy helpers used to construct transactions.
///
/// Kept for backwards compatibility; they now delegate to [Commands] and
/// produce the same `$kind`-style command maps used by the serialization
/// pipeline.
@Deprecated('Use Commands instead')
class Transactions {
  static Map<String, dynamic> moveCall(
      {required String target, List? typeArguments, List? arguments}) {
    return Commands.moveCall({
      'target': target,
      'typeArguments': typeArguments ?? [],
      'arguments': arguments ?? [],
    });
  }

  static Map<String, dynamic> transferObjects(List objects, dynamic address) {
    return Commands.transferObjects(List<dynamic>.from(objects), address);
  }

  static Map<String, dynamic> splitCoins(dynamic coin, dynamic amounts) {
    return Commands.splitCoins(
        coin, List<dynamic>.from(amounts as Iterable<dynamic>));
  }

  static Map<String, dynamic> mergeCoins(
    dynamic destination,
    List sources,
  ) {
    return Commands.mergeCoins(destination, List<dynamic>.from(sources));
  }

  static Map<String, dynamic> publish(
      List<String> modules, List<String> dependencies) {
    return Commands.publish(modules: modules, dependencies: dependencies);
  }

  static Map<String, dynamic> upgrade({
    required List<String> modules,
    required List<String> dependencies,
    required String packageId,
    required dynamic ticket,
  }) {
    return Commands.upgrade(
      modules: modules,
      dependencies: dependencies,
      package: packageId,
      ticket: ticket,
    );
  }

  static Map<String, dynamic> makeMoveVec({
    required dynamic objects,
    String? type,
  }) {
    return Commands.makeMoveVec(
      type: type,
      elements: List<dynamic>.from(objects as Iterable<dynamic>),
    );
  }
}
