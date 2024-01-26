import 'dart:typed_data';

class ProofPoints {
  List<String> a;
  List<List<String>> b;
  List<String> c;

  ProofPoints({required this.a, required this.b, required this.c});

  factory ProofPoints.fromJson(Map<String, dynamic> data) {
    return ProofPoints(
      a: List<String>.from(data["a"]), 
      b: ((data["b"]) as List).map((e) => List<String>.from(e)).toList(), 
      c: List<String>.from(data["c"])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "a": a,
      "b": b,
      "c": c
    };
  }
}

class Claim {
  String value;
  int indexMod4;

  Claim({
    required this.value,
    required this.indexMod4,
  });

  factory Claim.fromJson(Map<String, dynamic> data) {
    return Claim(value: data["value"], indexMod4: data["indexMod4"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "indexMod4": indexMod4
    };
  }
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

  factory ZkLoginSignatureInputs.fromJson(Map<String, dynamic> data) {
    return ZkLoginSignatureInputs(
      proofPoints: ProofPoints.fromJson(data["proofPoints"]),
      issBase64Details: Claim.fromJson(data["issBase64Details"]),
      headerBase64: data["headerBase64"],
      addressSeed: data["addressSeed"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "proofPoints": proofPoints.toJson(),
      "issBase64Details": issBase64Details.toJson(),
      "headerBase64": headerBase64,
      "addressSeed": addressSeed
    };
  }
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

  factory ZkLoginDeserializedSignature.fromJson(Map<String, dynamic> data) {
    return ZkLoginDeserializedSignature(
      Uint8List.fromList(List<int>.from(data["userSignature"])),
      ZkLoginSignatureInputs.fromJson(data["inputs"]),
      int.parse(data["maxEpoch"])
    );
  }
}
