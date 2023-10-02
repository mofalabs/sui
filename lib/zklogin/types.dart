import 'dart:typed_data';

class ProofPoints {
	List<String> a;
	List<List<String>> b;
	List<String> c;

  ProofPoints(this.a, this.b, this.c);
}

class Claim {
	String value;
	int indexMod4;

  Claim(this.value, this.indexMod4);
}

class ZkLoginSignatureInputs {
	ProofPoints proofPoints;
	Claim issBase64Details;
	String headerBase64;
	String addressSeed;

  ZkLoginSignatureInputs(
    this.proofPoints, 
    this.issBase64Details, 
    this.headerBase64, 
    this.addressSeed
  );
}

class ZkLoginSignature {
	ZkLoginSignatureInputs inputs;
	int maxEpoch;
	Uint8List userSignature;

  ZkLoginSignature(this.inputs, this.maxEpoch, this.userSignature);
}

class ZkLoginDeserializedSignature extends ZkLoginSignature {

  ZkLoginDeserializedSignature(
    Uint8List userSignature,
    ZkLoginSignatureInputs inputs,
    int maxEpoch): super(inputs, maxEpoch, userSignature);
}
