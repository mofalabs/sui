import 'dart:convert';

import 'exception.dart';

const Bech32Codec bech32 = Bech32Codec();

class Bech32Codec extends Codec<Bech32, String> {
  const Bech32Codec();

  @override
  Bech32Decoder get decoder => Bech32Decoder();
  @override
  Bech32Encoder get encoder => Bech32Encoder();

  @override
  String encode(Bech32 input, [maxLength = Bech32Validations.maxInputLength]) {
    return Bech32Encoder().convert(input, maxLength);
  }

  @override
  Bech32 decode(String encoded, [maxLength = Bech32Validations.maxInputLength]) {
    return Bech32Decoder().convert(encoded, maxLength);
  }

  List<int> convert(List<int> data, int from, int to, bool pad) {
    var acc = 0;
    var bits = 0;
    var result = <int>[];
    var maxv = (1 << to) - 1;

    for (var v in data) {
      if (v < 0 || (v >> from) != 0) {
        throw Exception();
      }
      acc = (acc << from) | v;
      bits += from;
      while (bits >= to) {
        bits -= to;
        result.add((acc >> bits) & maxv);
      }
    }

    if (pad) {
      if (bits > 0) {
        result.add((acc << (to - bits)) & maxv);
      }
    } else if (bits >= from) {
      throw InvalidPadding('Excess padding');
    } else if (((acc << (to - bits)) & maxv) != 0) {
      throw InvalidPadding('Non-zero padding');
    }

    return result;
  }

  List<int> toWords(List<int> bytes) {
    return convert(bytes, 8, 5, true);
  }

  List<int> fromWords(List<int> words) {
    return convert(words, 5, 8, false);
  }
}

// This class converts a Bech32 class instance to a String.
class Bech32Encoder extends Converter<Bech32, String> with Bech32Validations {
  @override
  String convert(Bech32 input,
      [int maxLength = Bech32Validations.maxInputLength]) {
    var hrp = input.hrp;
    var data = input.data;

    if (hrp.length +
            data.length +
            separator.length +
            Bech32Validations.checksumLength >
        maxLength) {
      throw TooLong(
          hrp.length + data.length + 1 + Bech32Validations.checksumLength);
    }

    if (hrp.isEmpty) {
      throw TooShortHrp();
    }

    if (hasOutOfRangeHrpCharacters(hrp)) {
      throw OutOfRangeHrpCharacters(hrp);
    }

    if (isMixedCase(hrp)) {
      throw MixedCase(hrp);
    }

    hrp = hrp.toLowerCase();

    var checksummed = data + _createChecksum(hrp, data);

    if (hasOutOfBoundsChars(checksummed)) {
      throw OutOfBoundChars('at position ${checksummed.indexOf(-1)}');
    }

    return hrp + separator + checksummed.map((i) => charset[i]).join();
  }
}

// This class converts a String to a Bech32 class instance.
class Bech32Decoder extends Converter<String, Bech32> with Bech32Validations {
  @override
  Bech32 convert(String input,
      [int maxLength = Bech32Validations.maxInputLength]) {
    if (input.length > maxLength) {
      throw TooLong(input.length);
    }

    if (isMixedCase(input)) {
      throw MixedCase(input);
    }

    if (hasInvalidSeparator(input)) {
      throw InvalidSeparator(input.lastIndexOf(separator));
    }

    var separatorPosition = input.lastIndexOf(separator);

    if (isChecksumTooShort(separatorPosition, input)) {
      throw TooShortChecksum();
    }

    if (isHrpTooShort(separatorPosition)) {
      throw TooShortHrp();
    }

    input = input.toLowerCase();

    var hrp = input.substring(0, separatorPosition);
    var data = input.substring(
        separatorPosition + 1, input.length - Bech32Validations.checksumLength);
    var checksum =
        input.substring(input.length - Bech32Validations.checksumLength);

    if (hasOutOfRangeHrpCharacters(hrp)) {
      throw OutOfRangeHrpCharacters(hrp);
    }

    var dataBytes = data.split('').map((c) {
      return charset.indexOf(c);
    }).toList();

    if (hasOutOfBoundsChars(dataBytes)) {
      throw OutOfBoundChars(data[dataBytes.indexOf(-1)]);
    }

    var checksumBytes = checksum.split('').map((c) {
      return charset.indexOf(c);
    }).toList();

    if (hasOutOfBoundsChars(checksumBytes)) {
      throw OutOfBoundChars(checksum[checksumBytes.indexOf(-1)]);
    }

    if (isInvalidChecksum(hrp, dataBytes, checksumBytes)) {
      throw InvalidChecksum();
    }

    return Bech32(hrp, dataBytes);
  }
}

/// Generic validations for Bech32 standard.
mixin Bech32Validations {
  static const int maxInputLength = 90;
  static const checksumLength = 6;

  // From the entire input subtract the hrp length, the separator and the required checksum length
  bool isChecksumTooShort(int separatorPosition, String input) {
    return (input.length - separatorPosition - 1 - checksumLength) < 0;
  }

  bool hasOutOfBoundsChars(List<int> data) {
    return data.any((c) => c == -1);
  }

  bool isHrpTooShort(int separatorPosition) {
    return separatorPosition == 0;
  }

  bool isInvalidChecksum(String hrp, List<int> data, List<int> checksum) {
    return !_verifyChecksum(hrp, data + checksum);
  }

  bool isMixedCase(String input) {
    return input.toLowerCase() != input && input.toUpperCase() != input;
  }

  bool hasInvalidSeparator(String bech32) {
    return bech32.lastIndexOf(separator) == -1;
  }

  bool hasOutOfRangeHrpCharacters(String hrp) {
    return hrp.codeUnits.any((c) => c < 33 || c > 126);
  }
}

/// Bech32 is a dead simple wrapper around a Human Readable Part (HRP) and a
/// bunch of bytes.
class Bech32 {
  Bech32(this.hrp, this.data);

  final String hrp;
  final List<int> data;
}

const String separator = '1';

const List<String> charset = [
  'q',
  'p',
  'z',
  'r',
  'y',
  '9',
  'x',
  '8',
  'g',
  'f',
  '2',
  't',
  'v',
  'd',
  'w',
  '0',
  's',
  '3',
  'j',
  'n',
  '5',
  '4',
  'k',
  'h',
  'c',
  'e',
  '6',
  'm',
  'u',
  'a',
  '7',
  'l',
];

const List<int> generator = [
  0x3b6a57b2,
  0x26508e6d,
  0x1ea119fa,
  0x3d4233dd,
  0x2a1462b3,
];

int _polymod(List<int> values) {
  var chk = 1;
  for (var v in values) {
    var top = chk >> 25;
    chk = (chk & 0x1ffffff) << 5 ^ v;
    for (var i = 0; i < generator.length; i++) {
      if ((top >> i) & 1 == 1) {
        chk ^= generator[i];
      }
    }
  }

  return chk;
}

List<int> _hrpExpand(String hrp) {
  var result = hrp.codeUnits.map((c) => c >> 5).toList();
  result = result + [0];

  result = result + hrp.codeUnits.map((c) => c & 31).toList();

  return result;
}

bool _verifyChecksum(String hrp, List<int> dataIncludingChecksum) {
  return _polymod(_hrpExpand(hrp) + dataIncludingChecksum) == 1;
}

List<int> _createChecksum(String hrp, List<int> data) {
  var values = _hrpExpand(hrp) + data + [0, 0, 0, 0, 0, 0];
  var polymod = _polymod(values) ^ 1;

  var result = <int>[0, 0, 0, 0, 0, 0];

  for (var i = 0; i < result.length; i++) {
    result[i] = (polymod >> (5 * (5 - i))) & 31;
  }
  return result;
}




