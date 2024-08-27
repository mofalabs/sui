
import 'package:sui/types/objects.dart';

/// A reference to a shared object.
class SharedObjectRef {
  /// Hex code as string representing the object id
  String objectId;

  /// The version the object was shared at
  dynamic initialSharedVersion;

  /// Whether reference is mutable
  bool mutable;

  SharedObjectRef(this.objectId, this.initialSharedVersion, this.mutable);
}

typedef ObjectArg = dynamic;

typedef PureArg = dynamic;

bool isPureArg(PureArg arg) {
  return (arg as PureArg)["Pure"] != null;
}

typedef CallArg = dynamic;

/// Kind of a TypeTag which is represented by a Move type identifier.
class StructTag {
  String address;
  String module;
  String name;
  List<TypeTag> typeParams;

  StructTag(this.address, this.module, this.name, this.typeParams);

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "module": module,
      "name": name,
      "typeParams": typeParams
    };
  }
}

/// Sui TypeTag object. A decoupled `0x...::module::Type<???>` parameter.
typedef TypeTag = dynamic;

/// The GasData to be used in the transaction.
class GasData {
  List<SuiObjectRef> payment;
  String owner;
  int price;
  int budget;

  GasData(this.payment, this.owner, this.price, this.budget);
}
