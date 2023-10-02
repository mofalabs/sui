import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/hex.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/sha.dart';
import 'package:sui/zklogin/utils.dart';

String computeZkLoginAddressFromSeed(BigInt addressSeed, String iss) {
	final addressSeedBytesBigEndian = toBufferBE(addressSeed, 32);
	final addressParamBytes = utf8.encode(iss);
	final tmp = Uint8List(2 + addressSeedBytesBigEndian.length + addressParamBytes.length);

	tmp.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.ZkLogin]);
	tmp.setAll(1, [addressParamBytes.length]);
	tmp.setAll(2, addressParamBytes);
	tmp.setAll(2 + addressParamBytes.length, addressSeedBytesBigEndian);

	return normalizeSuiAddress(
		Hex.encode(blake2b(tmp)).substring(0, SUI_ADDRESS_LENGTH * 2),
	);
}
