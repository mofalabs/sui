import 'package:bcs/index.dart';
import 'package:sui/types/sui_bcs.dart';

final zkLoginSignature = bcs.registerStructType('ZkLoginSignature', {
    "inputs": {
      "proofPoints": {
        "a": [BCS.VECTOR, BCS.STRING],
        "b": [BCS.VECTOR, [BCS.VECTOR, BCS.STRING]],
        "c": [BCS.VECTOR, BCS.STRING],
      },
      "issBase64Details": {
        "value": BCS.STRING,
        "indexMod4": BCS.U8,
      },
      "headerBase64": BCS.STRING,
      "addressSeed": BCS.STRING,
    },
    "maxEpoch": BCS.U64,
    "userSignature": [BCS.VECTOR, BCS.U8],
});
