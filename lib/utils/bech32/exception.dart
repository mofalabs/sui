class TooShortHrp implements Exception {
  @override
  String toString() => 'The human readable part should have non zero length.';
}

class TooLong implements Exception {
  TooLong(this.length);

  final int length;

  @override
  String toString() => 'The bech32 string is too long: $length (>90)';
}

class OutOfRangeHrpCharacters implements Exception {
  OutOfRangeHrpCharacters(this.hpr);

  final String hpr;

  @override
  String toString() =>
      'The human readable part contains invalid characters: $hpr';
}

class MixedCase implements Exception {
  MixedCase(this.hpr);

  final String hpr;

  @override
  String toString() =>
      'The human readable part is mixed case, should either be all lower or all upper case: $hpr';
}

class OutOfBoundChars implements Exception {
  OutOfBoundChars(this.char);

  final String char;

  @override
  String toString() => 'A character is undefined in bech32: $char';
}

class InvalidSeparator implements Exception {
  InvalidSeparator(this.pos);

  final int pos;

  @override
  String toString() => "separator '1' at invalid position: $pos";
}

class InvalidChecksum implements Exception {
  @override
  String toString() => 'Checksum verification failed';
}

class TooShortChecksum implements Exception {
  @override
  String toString() => 'Checksum is shorter than 6 characters';
}

class InvalidPadding implements Exception {
  InvalidPadding(this.reason);

  final String reason;

  @override
  String toString() => 'Invalid padding: $reason';
}