import 'dart:convert';

import 'package:sui/zklogin/types.dart';

List<int> base64UrlCharTo6Bits(String base64UrlChar) {
	if (base64UrlChar.length != 1) {
		throw ArgumentError('Invalid base64Url character: ' + base64UrlChar);
	}

	// Define the base64URL character set
	const base64UrlCharacterSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';

	// Find the index of the input character in the base64URL character set
	final index = base64UrlCharacterSet.indexOf(base64UrlChar);

	if (index == -1) {
		throw ArgumentError('Invalid base64Url character: ' + base64UrlChar);
	}

	// Convert the index to a 6-bit binary string
	final binaryString = index.toRadixString(2).padLeft(6, '0');

	// Convert the binary string to an array of bits
  final bits = binaryString.split("").map((e) => int.parse(e)).toList();

	return bits;
}

List<int> base64UrlStringToBitVector(String base64UrlString) {
	final bitVector = <int>[];
	for (int i = 0; i < base64UrlString.length; i++) {
		final base64UrlChar = base64UrlString[i];
		final bits = base64UrlCharTo6Bits(base64UrlChar);
    bitVector.addAll(bits);
	}
	return bitVector;
}

String decodeBase64URL(String s, int i) {
	if (s.length < 2) {
		throw ArgumentError("Input (s = ${s}) is not tightly packed because s.length < 2");
	}
	List<int> bits = base64UrlStringToBitVector(s);

	final firstCharOffset = i % 4;
	if (firstCharOffset == 0) {
		// skip
	} else if (firstCharOffset == 1) {
		bits = bits.sublist(2);
	} else if (firstCharOffset == 2) {
		bits = bits.sublist(4);
	} else {
		// (offset == 3)
		throw ArgumentError("Input (s = ${s}) is not tightly packed because i%4 = 3 (i = ${i}))");
	}

	final lastCharOffset = (i + s.length - 1) % 4;
	if (lastCharOffset == 3) {
		// skip
	} else if (lastCharOffset == 2) {
		bits = bits.sublist(0, bits.length - 2);
	} else if (lastCharOffset == 1) {
		bits = bits.sublist(0, bits.length - 4);
	} else {
		// (offset == 0)
		throw ArgumentError(
			"Input (s = ${s}) is not tightly packed because (i + s.length - 1)%4 = 0 (i = ${i}))",
		);
	}

	if (bits.length % 8 != 0) {
		throw ArgumentError("We should never reach here...");
	}

	final bytes = <int>[];
	for (int i = 0; i < bits.length; i += 8) {
		final bitChunk = bits.sublist(i, i + 8);

		// Convert the 8-bit chunk to a byte and add it to the bytes array
		final byte = int.parse(bitChunk.join(''), radix: 2);
		bytes.add(byte);
	}
	return utf8.decode(bytes);
}

(dynamic, dynamic) verifyExtendedClaim(String claim) {
	// Last character of each extracted_claim must be '}' or ','
  final last = claim[claim.length - 1];
	if (!(last == '}' || last == ',')) {
		throw ArgumentError('Invalid claim');
	}

	Map json = jsonDecode('{' + claim.substring(0, claim.length - 1) + '}');
	if (json.length != 1) {
		throw ArgumentError('Invalid claim');
	}
  final key = json.keys.first;
	return (key, json[key]);
}

R extractClaimValue<R>(Claim claim, String claimName) {
	final extendedClaim = decodeBase64URL(claim.value, claim.indexMod4);
	final (name, value) = verifyExtendedClaim(extendedClaim);
	if (name != claimName) {
		throw ArgumentError("Invalid field name: found $name expected $claimName");
	}
	return value;
}
