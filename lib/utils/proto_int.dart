import 'package:fixnum/fixnum.dart';

/// Protobuf stores uint64 in a signed Int64 container. Reading its decimal
/// string (or converting through a JS number) loses the unsigned interpretation.
BigInt uint64ToBigInt(Int64 value) => BigInt.parse(value.toStringUnsigned());

Int64 bigIntToUint64(BigInt value) {
  if (value.isNegative || value >= (BigInt.one << 64)) {
    throw ArgumentError.value(value, 'value', 'Expected u64');
  }
  return Int64.parseRadix(value.toRadixString(16), 16);
}
