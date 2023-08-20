
import 'package:sui/types/common.dart';
import 'package:sui/types/sui_bcs.dart';

final VECTOR_REGEX = RegExp(r"^vector<(.+)>$");
final STRUCT_REGEX = RegExp(r"^([^:]+)::([^:]+)::([^<]+)(<(.+)>)?");

class TypeTagSerializer {
  static TypeTag parseFromStr(String str, [bool normalizeAddress = false]) {
    if (str == 'address') {
      return { "address": null };
    } else if (str == 'bool') {
      return { "bool": null };
    } else if (str == 'u8') {
      return { "u8": null };
    } else if (str == 'u16') {
      return { "u16": null };
    } else if (str == 'u32') {
      return { "u32": null };
    } else if (str == 'u64') {
      return { "u64": null };
    } else if (str == 'u128') {
      return { "u128": null };
    } else if (str == 'u256') {
      return { "u256": null };
    } else if (str == 'signer') {
      return { "signer": null };
    }
    
    final vectorMatch = VECTOR_REGEX.allMatches(str).toList();
    if (vectorMatch.isNotEmpty) {
      return {
        "vector": TypeTagSerializer.parseFromStr(
          vectorMatch[1][0]!,
          normalizeAddress,
        ),
      };
    }

    final structMatch = STRUCT_REGEX.firstMatch(str);
    if (structMatch != null) {
      final address = normalizeAddress
        ? normalizeSuiAddress(structMatch.group(1)!)
        : structMatch.group(1);
      return {
        "struct": {
          "address": address,
          "module": structMatch.group(2),
          "name": structMatch.group(3),
          "typeParams":
            structMatch.group(5) == null
              ? []
              : TypeTagSerializer.parseStructTypeArgs(
                  structMatch.group(5)!,
                  normalizeAddress,
                ),
        },
      };
    }

    throw ArgumentError(
      "Encountered unexpected token when parsing type args for $str",
    );
  }

  static List<TypeTag> parseStructTypeArgs(String str, [bool normalizeAddress = false]) {
    // split `str` by all `,` outside angle brackets
    List<String> tok = [];
    var word = '';
    var nestedAngleBrackets = 0;
    for (var i = 0; i < str.length; i++) {
      final char = str[i];
      if (char == '<') {
        nestedAngleBrackets++;
      }
      if (char == '>') {
        nestedAngleBrackets--;
      }
      if (nestedAngleBrackets == 0 && char == ',') {
        tok.add(word.trim());
        word = '';
        continue;
      }
      word += char;
    }

    tok.add(word.trim());

    return tok.map((tok) =>
      TypeTagSerializer.parseFromStr(tok, normalizeAddress),
    ).toList();
  }

  static String tagToString(TypeTag tag) {
    final data = tag as Map;
    if (data.containsKey('bool')) {
      return 'bool';
    }
    if (data.containsKey('u8')) {
      return 'u8';
    }
    if (data.containsKey('u16')) {
      return 'u16';
    }
    if (data.containsKey('u32')) {
      return 'u32';
    }
    if (data.containsKey('u64')) {
      return 'u64';
    }
    if (data.containsKey('u128')) {
      return 'u128';
    }
    if (data.containsKey('u256')) {
      return 'u256';
    }
    if (data.containsKey('address')) {
      return 'address';
    }
    if (data.containsKey('signer')) {
      return 'signer';
    }
    if (data.containsKey('vector')) {
      return "vector<${TypeTagSerializer.tagToString(data["vector"])}>";
    }
    if (data.containsKey('struct')) {
      final struct = tag["struct"];
      final typeParams = struct["typeParams"]
        .map(TypeTagSerializer.tagToString)
        .join(', ');
      return "${struct["address"]}::${struct["module"]}::${struct["name"]}${
        typeParams != null && typeParams.toString().isNotEmpty ? "<$typeParams>" : ''
      }";
    }
    throw ArgumentError('Invalid TypeTag');
  }
}
