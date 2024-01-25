import 'dart:typed_data';

class ProofPoints {
  List<String> a;
  List<List<String>> b;
  List<String> c;

  ProofPoints({required this.a, required this.b, required this.c});
}

class Claim {
  String value;
  int indexMod4;

  Claim({
    required this.value,
    required this.indexMod4,
  });
}

class ZkLoginSignatureInputs {
  ProofPoints proofPoints;
  Claim issBase64Details;
  String headerBase64;
  String addressSeed;

  ZkLoginSignatureInputs({
    required this.proofPoints,
    required this.issBase64Details,
    required this.headerBase64,
    required this.addressSeed,
  });
}

class ZkLoginSignature {
  ZkLoginSignatureInputs inputs;
  int maxEpoch;
  Uint8List userSignature;

  ZkLoginSignature({
    required this.inputs,
    required this.maxEpoch,
    required this.userSignature,
  });
}

class ZkLoginDeserializedSignature extends ZkLoginSignature {
  ZkLoginDeserializedSignature(
    Uint8List userSignature,
    ZkLoginSignatureInputs inputs,
    int maxEpoch,
  ) : super(inputs: inputs, maxEpoch: maxEpoch, userSignature: userSignature);
}
