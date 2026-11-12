/// An allowance's object ID and optional metadata to avoid a lookup at build.
class AllowanceReference {
  const AllowanceReference({required this.objectId, this.funder, this.app});
  final String objectId;
  final String? funder;
  final AllowanceApp? app;
}

/// Authorization returned by an app's Move call as a `SpendPermit<A>`.
class AllowanceApp {
  const AllowanceApp({required this.type, required this.permit});
  final String type;
  final Object permit;
}

enum WithdrawalSource { sender, sponsor, allowance }

/// Converts an exact base-unit amount without passing through floating point.
BigInt parseBalanceAmount(Object value) {
  if (value is! BigInt && value is! int && value is! String) {
    throw ArgumentError.value(
      value,
      'amount',
      'Use BigInt, int or decimal digits',
    );
  }
  final text = value.toString();
  if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
    throw ArgumentError.value(value, 'amount', 'Expected decimal digits');
  }
  final amount = BigInt.parse(text);
  if (amount >= (BigInt.one << 64)) {
    throw ArgumentError.value(value, 'amount', 'Exceeds u64');
  }
  return amount;
}
