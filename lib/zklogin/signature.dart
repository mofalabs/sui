import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/index.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/zklogin/types.dart';

import 'bcs.dart';

Uint8List getZkLoginSignatureBytes(ZkLoginSignature signature) {
  return zkLoginSignature.serialize(
          {
            "inputs": signature.inputs.toJson(),
            "maxEpoch": signature.maxEpoch,
            "userSignature": signature.userSignature,
          },
          options: BcsWriterOptions(maxSize: 2048))
      .toBytes();
}

String getZkLoginSignature(ZkLoginSignature signature) {
  final bytes = getZkLoginSignatureBytes(signature);
  final signatureBytes = Uint8List(bytes.length + 1);
  signatureBytes.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.ZkLogin]);
  signatureBytes.setAll(1, bytes);
  return base64Encode(signatureBytes);
}

ZkLoginDeserializedSignature parseZkLoginSignature(Uint8List signature) {
  final sig = zkLoginSignature.parse(signature);
  return ZkLoginDeserializedSignature.fromJson(sig);
}
