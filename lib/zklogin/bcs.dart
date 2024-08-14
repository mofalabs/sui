import 'package:bcs/bcs.dart';

final zkLoginSignature = Bcs.struct('ZkLoginSignature', {
	"inputs": Bcs.struct('ZkLoginSignatureInputs', {
		"proofPoints": Bcs.struct('ZkLoginSignatureInputsProofPoints', {
			"a": Bcs.vector(Bcs.string()),
			"b": Bcs.vector(Bcs.vector(Bcs.string())),
			"c": Bcs.vector(Bcs.string()),
		}),
		"issBase64Details": Bcs.struct('ZkLoginSignatureInputsClaim', {
			"value": Bcs.string(),
			"indexMod4": Bcs.u8(),
		}),
		"headerBase64": Bcs.string(),
		"addressSeed": Bcs.string(),
	}),
	"maxEpoch": Bcs.u64(),
	"userSignature": Bcs.vector(Bcs.u8()),
});
