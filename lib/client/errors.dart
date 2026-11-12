/// Transport-independent failure of an individual object lookup.
class SuiObjectException implements Exception {
  const SuiObjectException(
    this.message, {
    required this.objectId,
    required this.reason,
    this.code,
    this.cause,
  });

  final String message;
  final String objectId;
  final ObjectErrorReason reason;
  final int? code;
  final Object? cause;

  @override
  String toString() =>
      'SuiObjectException($objectId, ${reason.name}): $message';
}

enum ObjectErrorReason { notFound, deleted, unknown }

class SuiTransactionException implements Exception {
  const SuiTransactionException(this.digest, {this.cause});
  final String digest;
  final Object? cause;

  @override
  String toString() => 'Transaction $digest not found';
}

class SuiSimulationException implements Exception {
  const SuiSimulationException(this.message, {this.cause});
  final String message;
  final Object? cause;

  @override
  String toString() => 'SuiSimulationException: $message';
}
