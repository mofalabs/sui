
import 'package:bcs/index.dart';

class WellKnownEncoding {
  static Map<String, dynamic> object = { "kind" : "object" };
  static Map<String, dynamic> string = { "kind" : "pure", "type": BCS.STRING };
  static Map<String, dynamic> u64 = { "kind" : "pure", "type": BCS.U64 };
  static Map<String, dynamic> address = { "kind" : "pure", "type": BCS.ADDRESS };

  static Map<String, dynamic>? getWellKnownEncoding(String transactionType, String key) {
    switch (transactionType) {
      case "TransferObjects":
        if (key == "objects") {
          return WellKnownEncoding.object;
        } else if (key == "address"){
          return WellKnownEncoding.address;
        }
        break;
      case "SplitCoins":
        if (key == "coin") {
          return WellKnownEncoding.object;
        } else if (key == "amounts") {
          return WellKnownEncoding.u64;
        }
        break;
      case "MergeCoins":
        if (key == "destination" || key == "sources") {
          return WellKnownEncoding.object;
        }
        break;
      case "MakeMoveVec":
        if (key == "objects") {
          return WellKnownEncoding.object;
        }
        break;
      case "Upgrade":
        if (key == "ticket") {
          return WellKnownEncoding.object;
        }
      default:
        return null;
    }
    return null;
  }
}