
import 'package:sui/types/common.dart';

class SuiObjectRef {
  /// Base64 string representing the object digest
  TransactionDigest digest;
  /// Hex code as string representing the object id
  String objectId;
  /// Object version
  int version;

  SuiObjectRef(this.digest, this.objectId, this.version);
}

class SuiObjectInfo extends SuiObjectRef {
  String type;
  ObjectOwner owner;
  TransactionDigest previousTransaction;

  SuiObjectInfo(
    this.type, 
    this.owner, 
    this.previousTransaction,
    TransactionDigest digest,
    String objectId,
    int version
  ): super(digest, objectId, version);

  factory SuiObjectInfo.fromJson(dynamic data) {
    return SuiObjectInfo(
      data['type'], 
      data['owner'],
      data['previousTransaction'],
      data['digest'],
      data['objectId'],
      data['version']
    );
  }
}

// typedef ObjectContentFields = Record<String, dynamic>;
// typedef MovePackageContent = Record<String, String>;
typedef ObjectContentFields = dynamic;
typedef MovePackageContent = dynamic;

typedef SuiData = dynamic;
// typedef SuiData = { dataType: ObjectType } & (
//   | SuiMoveObject
//   | SuiMovePackage
// );

class SuiMoveObject {
  /// Move type (e.g., "0x2::coin::Coin<0x2::sui::SUI>")
  String type;
  /// Fields and values stored inside the Move object
  ObjectContentFields fields;
  bool? has_public_transfer;

  SuiMoveObject(this.type, this.fields, this.has_public_transfer);
}

final MIST_PER_SUI = BigInt.from(1000000000);

class CoinDenominationInfoResponse {
  /// Coin type like "0x2::sui::SUI"
  String coinType;
  /// min unit, like MIST
  String? basicUnit;
  /// number of zeros in the denomination, e.g., 9 here for SUI.
  int decimalNumber;

  CoinDenominationInfoResponse(this.coinType, this.basicUnit, this.decimalNumber);
}

class SuiMovePackage {
  /// A mapping from module name to disassembled Move bytecode
  MovePackageContent disassembled;
  SuiMovePackage(this.disassembled);
}

typedef SuiMoveFunctionArgTypesResponse = List<SuiMoveFunctionArgType>;

typedef SuiMoveFunctionArgType = String;

typedef SuiMoveFunctionArgTypes = List<SuiMoveFunctionArgType>;

// typedef SuiMoveNormalizedModules = Record<String, SuiMoveNormalizedModule>;
typedef SuiMoveNormalizedModules = dynamic;

class SuiMoveNormalizedModule {
  int file_format_version;
  String address;
  String name;
  List<SuiMoveModuleId> friends;
  Map<String, SuiMoveNormalizedStruct> structs;
  Map<String, SuiMoveNormalizedFunction> exposed_functions;

  SuiMoveNormalizedModule(this.file_format_version, this.address, this.name, this.friends, this.structs, this.exposed_functions);
}

class SuiMoveModuleId {
  String address;
  String name;
  SuiMoveModuleId(this.address, this.name);
}

class SuiMoveNormalizedStruct {
  SuiMoveAbilitySet abilities;
  List<SuiMoveStructTypeParameter> type_parameters;
  List<SuiMoveNormalizedField> fields;
  SuiMoveNormalizedStruct(this.abilities, this.type_parameters, this.fields);
}

class SuiMoveStructTypeParameter {
  SuiMoveAbilitySet constraints;
  bool is_phantom;
  SuiMoveStructTypeParameter(this.constraints, this.is_phantom);
}

class SuiMoveNormalizedField {
  String name;
  SuiMoveNormalizedType type_;
  SuiMoveNormalizedField(this.name, this.type_);
}

class SuiMoveNormalizedFunction {
  SuiMoveVisibility visibility;
  bool is_entry;
  List<SuiMoveAbilitySet> type_parameters;
  List<SuiMoveNormalizedType> parameters;
  List<SuiMoveNormalizedType> return_;
  SuiMoveNormalizedFunction(this.visibility, this.is_entry, this.type_parameters, this.parameters, this.return_);
}

enum SuiMoveVisibility {
  Private, Public, Friend
}

typedef SuiMoveTypeParameterIndex = int;

class SuiMoveAbilitySet {
  List<String> abilities;
  SuiMoveAbilitySet(this.abilities);
}

typedef SuiMoveNormalizedType = dynamic;

// export type SuiMoveNormalizedType =
//   | string
//   | SuiMoveNormalizedTypeParameterType
//   | { Reference: SuiMoveNormalizedType }
//   | { MutableReference: SuiMoveNormalizedType }
//   | { Vector: SuiMoveNormalizedType }
//   | SuiMoveNormalizedStructType;

class SuiMoveNormalizedTypeParameterType {
  SuiMoveTypeParameterIndex TypeParameter;
  SuiMoveNormalizedTypeParameterType(this.TypeParameter);
}

class SuiStruct {
    String address;
    String module;
    String name;
    List<SuiMoveNormalizedType> type_arguments;

    SuiStruct(this.address, this.module, this.name, this.type_arguments);
}

class SuiMoveNormalizedStructType {
  SuiStruct Struct;
  SuiMoveNormalizedStructType(this.Struct);
}

class SuiObject {
  /// The meat of the object
  SuiData data;
  /// The owner of the object
  ObjectOwner owner;
  /// The digest of the transaction that created or last mutated this object
  TransactionDigest previousTransaction;

  /// The amount of SUI we would rebate if this object gets deleted.
  /// This number is re-calculated each time the object is mutated based on
  /// the present storage gas price.
  int storageRebate;
  SuiObjectRef reference;

  SuiObject(this.data, this.owner, this.previousTransaction, this.storageRebate, this.reference);
}

enum ObjectStatus {
  Exists, NotExists, Deleted
}

enum ObjectType {
  moveObject, package
}

typedef GetOwnedObjectsResponse = List<SuiObjectInfo>;

class GetObjectDataResponse {
  String status;
  dynamic details; // SuiObject | ObjectId | SuiObjectRef

  GetObjectDataResponse(this.status, this.details);
}

typedef ObjectDigest = String;
typedef ObjectId = String;
typedef SequenceNumber = int;

/* -------------------------------------------------------------------------- */
/*                              Helper functions                              */
/* -------------------------------------------------------------------------- */

/* -------------------------- GetObjectDataResponse ------------------------- */

SuiObject? getObjectExistsResponse(GetObjectDataResponse resp) {
  return resp.status != ObjectStatus.Exists.name ? null : (resp.details as SuiObject);
}

SuiObjectRef? getObjectDeletedResponse(GetObjectDataResponse resp) {
  return resp.status != ObjectStatus.Deleted.name ? null : (resp.details as SuiObjectRef);
}

String getObjectNotExistsResponse(GetObjectDataResponse resp) {
  return resp.status != ObjectStatus.NotExists.name ? null : resp.details;
}

SuiObjectRef? getObjectReference(GetObjectDataResponse resp) {
  if (getObjectExistsResponse(resp) != null) {
    getObjectExistsResponse(resp)?.reference;
  } else {
    return getObjectDeletedResponse(resp);
  }
}

/* ------------------------------ SuiObjectRef ------------------------------ */

String getObjectId(
  dynamic data // GetObjectDataResponse | SuiObjectRef
) {
  if (data is SuiObjectRef) {
    return data.objectId;
  }
  return getObjectReference(data)?.objectId ?? getObjectNotExistsResponse(data);
}

int? getObjectVersion(
  dynamic data // GetObjectDataResponse | SuiObjectRef
) {
  if (data is SuiObjectRef) {
    return data.version;
  }
  return getObjectReference(data)?.version;
}

/* -------------------------------- SuiObject ------------------------------- */

ObjectType? getObjectType(
  GetObjectDataResponse resp
) {
  return getObjectExistsResponse(resp)?.data.dataType;
}

TransactionDigest? getObjectPreviousTransactionDigest(
  GetObjectDataResponse resp
) {
  return getObjectExistsResponse(resp)?.previousTransaction;
}

ObjectOwner? getObjectOwner(
  GetObjectDataResponse resp 
) {
  return getObjectExistsResponse(resp)?.owner;
}

int? getSharedObjectInitialVersion(
  GetObjectDataResponse resp
) {
  final owner = getObjectOwner(resp);
  if (owner is Map && owner['Shared'] != null) {
    return owner['Shared'].initial_shared_version;
  } else {
    return null;
  }
}

bool isSharedObject(GetObjectDataResponse resp) {
  final owner = getObjectOwner(resp);
  if (owner == 'Shared') {
    return true;
  } else if (owner is Map){
    return owner.containsKey('Shared');
  } else {
    throw ArgumentError('');
  }
}

bool isImmutableObject(GetObjectDataResponse resp) {
  final owner = getObjectOwner(resp);
  return owner == 'Immutable';
}

String? getMoveObjectType(
  GetObjectDataResponse resp
) {
  return getMoveObject(resp)?.type;
}

ObjectContentFields? getObjectFields(
  dynamic resp // GetObjectDataResponse | SuiMoveObject
) {
  if (resp is SuiMoveObject) {
    return resp.fields;
  }

  return getMoveObject(resp)?.fields;
}

SuiMoveObject? getMoveObject(
  dynamic data // GetObjectDataResponse | SuiObject
) {

  var suiObject = data is SuiObject ? data : getObjectExistsResponse(data);
  if (suiObject?.data['dataType'] != 'moveObject') {
    return null;
  }
  return suiObject?.data as SuiMoveObject;
}

bool hasPublicTransfer(
  dynamic data // GetObjectDataResponse | SuiObject
) {
  return getMoveObject(data)?.has_public_transfer ?? false;
}

MovePackageContent? getMovePackageContent(
  dynamic data // GetObjectDataResponse | SuiMovePackage
) {
  if (data is SuiMovePackage) {
    return data.disassembled;
  }

  final suiObject = getObjectExistsResponse(data);
  if (suiObject == null || suiObject.data['dataType'] != 'package') {
    return null;
  }
  return (suiObject.data as SuiMovePackage).disassembled;
}

SuiMoveNormalizedType? extractMutableReference(
  SuiMoveNormalizedType normalizedType
) {
  if (normalizedType is Map && normalizedType.containsKey('MutableReference')) {
    return normalizedType['MutableReference'];
  }
  return null;
}

SuiMoveNormalizedType? extractReference(
  SuiMoveNormalizedType normalizedType
) {
  if (normalizedType is Map && normalizedType.containsKey('Reference')) {
    return normalizedType['Reference'];
  }
  return null;
}

SuiMoveNormalizedStructType? extractStructTag(
  SuiMoveNormalizedType normalizedType
) {
  if (normalizedType is Map && normalizedType.containsKey('Struct')) {
    return normalizedType['Struct'];
  }

  final ref = extractReference(normalizedType);
  final mutRef = extractMutableReference(normalizedType);

  if (ref is SuiMoveNormalizedStructType) {
    return ref;
  }

  if (mutRef is SuiMoveNormalizedStructType) {
    return mutRef;
  }

  return null;
}
