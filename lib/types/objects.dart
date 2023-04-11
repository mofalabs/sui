import 'package:sui/types/common.dart';

class SuiObjectRef {
  /// Base64 string representing the object digest
  TransactionDigest digest;
  /// Hex code as string representing the object id
  String objectId;
  /// Object version
  int version;

  SuiObjectRef(this.digest, this.objectId, this.version);

  factory SuiObjectRef.fromJson(dynamic data) {
    return SuiObjectRef(
      data['digest'],
      data['objectId'],
      data['version']
    );
  }
}

class SuiObjectError {
  /// Base64 string representing the object digest
  TransactionDigest? digest;

  /// Hex code as string representing the object id
  String? objectId;

  /// Object version
  int? version;

  String? error;
  String code;

  SuiObjectError(this.code, this.digest, this.objectId, this.version, this.error);

  factory SuiObjectError.fromJson(dynamic data) {
    return SuiObjectError(
      data['code'],
      data['digest'],
      data['object_id'],
      data['version'],
      data['error'],
    );
  }
}

class SuiObjectInfo extends SuiObjectRef {
  String type;
  String owner;
  TransactionDigest previousTransaction;

  SuiObjectInfo(this.type,
      this.owner,
      this.previousTransaction,
      TransactionDigest digest,
      String objectId,
      int version) : super(digest, objectId, version);

  factory SuiObjectInfo.fromJson(dynamic data) {
    return SuiObjectInfo(
      data['type'] ?? "",
      data['owner']['AddressOwner'] ?? "",
      data['previousTransaction'] ?? "",
      data['digest'] ?? "",
      data['objectId'] ?? "",
      int.parse(data['version'] ?? '0'),
    );
  }
}

// typedef ObjectContentFields = Record<String, dynamic>;
// typedef MovePackageContent = Record<String, String>;
typedef ObjectContentFields = dynamic;
typedef MovePackageContent = dynamic;

class SuiData {
  ObjectType dataType;
  SuiMoveObject moveObject;
  SuiMovePackage movePackage;

  SuiData(this.dataType,
      this.moveObject,
      this.movePackage);
}

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

  CoinDenominationInfoResponse(this.coinType, this.basicUnit,
      this.decimalNumber);
}

class SuiMovePackage {
  /// A mapping from module name to disassembled Move bytecode
  MovePackageContent disassembled;

  SuiMovePackage(this.disassembled);

  factory SuiMovePackage.fromJson(dynamic data) {
    return SuiMovePackage(
        data['disassembled']
    );
  }
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

  SuiMoveNormalizedModule(this.file_format_version, this.address, this.name,
      this.friends, this.structs, this.exposed_functions);
}

class SuiMoveModuleId {
  String address;
  String name;

  SuiMoveModuleId(this.address, this.name);
}

class SuiMoveNormalizedStruct {
  SuiMoveAbilitySet abilities;
  List<SuiMoveStructTypeParameter> typeParameters;
  List<SuiMoveNormalizedField> fields;

  SuiMoveNormalizedStruct(this.abilities, this.typeParameters, this.fields);

  factory SuiMoveNormalizedStruct.fromJson(dynamic data) {
    final paramsList = (data['type_parameters'] as List).map((x) =>
        SuiMoveStructTypeParameter.fromJson(x)).toList();
    final fieldsList = (data['fields'] as List).map((x) =>
        SuiMoveNormalizedField.fromJson(x)).toList();
    return SuiMoveNormalizedStruct(
        SuiMoveAbilitySet.fromJson(data['abilities']),
        paramsList,
        fieldsList
    );
  }
}

class SuiMoveStructTypeParameter {
  SuiMoveAbilitySet constraints;
  bool isPhantom;

  SuiMoveStructTypeParameter(this.constraints, this.isPhantom);

  factory SuiMoveStructTypeParameter.fromJson(dynamic data) {
    return SuiMoveStructTypeParameter(data['constraints'], data['is_phantom']);
  }
}

class SuiMoveNormalizedField {
  String name;
  SuiMoveNormalizedType type;

  SuiMoveNormalizedField(this.name, this.type);

  factory SuiMoveNormalizedField.fromJson(dynamic data) {
    return SuiMoveNormalizedField(data['name'], data['type_']);
  }
}

class SuiMoveNormalizedFunction {
  SuiMoveVisibility visibility;
  bool isEntry;
  List<SuiMoveAbilitySet> typeParameters;
  List<SuiMoveNormalizedType> parameters;
  List<SuiMoveNormalizedType> returns;

  SuiMoveNormalizedFunction(this.visibility,
      this.isEntry,
      this.typeParameters,
      this.parameters,
      this.returns);

  factory SuiMoveNormalizedFunction.fromJson(dynamic data) {
    return SuiMoveNormalizedFunction(
        data['visibility'],
        data['is_entry'],
        data['type_parameters'],
        data['parameters'],
        data['return_']
    );
  }
}

enum SuiMoveVisibility {
  Private,
  Public,
  Friend
}

typedef SuiMoveTypeParameterIndex = int;

class SuiMoveAbilitySet {
  List<String> abilities;

  SuiMoveAbilitySet(this.abilities);

  factory SuiMoveAbilitySet.fromJson(dynamic data) {
    return SuiMoveAbilitySet((data['abilities'] as List).cast<String>());
  }
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

enum ObjectStatus {
  Exists,
  NotExists,
  Deleted
}

enum ObjectType {
  moveObject,
  package
}

typedef GetOwnedObjectsResponse = List<SuiObjectInfo>;

class Id {
  String id;

  Id(this.id);

  factory Id.fromJson(dynamic data) {
    return Id(data['id']);
  }
}

class SuiObjectDataFields {
  int balance;
  Id id;

  SuiObjectDataFields(this.balance, this.id);

  factory SuiObjectDataFields.fromJson(dynamic data) {
    return SuiObjectDataFields(
      int.parse(data['balance'].toString()),
      Id.fromJson(data['id']),
    );
  }
}

class SuiObjectData {
  String dataType;
  String type;
  bool hasPublicTransfer;
  SuiObjectDataFields? fields;

  // raw object
  int? version;
  String? bcsBytes;

  SuiObjectData(this.dataType,
      this.type,
      this.hasPublicTransfer,
      this.fields,
      this.version,
      this.bcsBytes);

  factory SuiObjectData.fromJson(dynamic data) {
    return SuiObjectData(
        data['dataType'],
        data['type'],
        data['hasPublicTransfer'],
        data['fields'] != null
            ? SuiObjectDataFields.fromJson(data['fields'])
            : null,
        data['version'],
        data['bcs_bytes']
    );
  }
}

class AddressOwner {
  String addressOwner;

  AddressOwner(this.addressOwner);

  factory AddressOwner.fromJson(dynamic data) {
    return AddressOwner(data['AddressOwner']);
  }
}

class SuiObject {
  SuiObjectData data;
  ObjectOwner owner;
  TransactionDigest previousTransaction;

  /// The amount of SUI we would rebate if this object gets deleted.
  /// This number is re-calculated each time the object is mutated based on
  /// the present storage gas price.
  int storageRebate;
  SuiObjectRef? reference;

  SuiObject(this.data,
      this.owner,
      this.previousTransaction,
      this.storageRebate,
      this.reference);

  factory SuiObject.fromJson(dynamic data) {
    return SuiObject(
        SuiObjectData.fromJson(data['content']),
        ObjectOwner.fromJson(data['owner']),
        data['previousTransaction'],
        int.parse(data['storageRebate'].toString()),
        data['reference'] == null
            ? null
            : SuiObjectRef.fromJson(data['reference']),
    );
  }
}

class GetObjectDataResponse {
  SuiObject? data;
  SuiObjectError? error;

  GetObjectDataResponse(this.data,this.error);

  factory GetObjectDataResponse.fromJson(dynamic data) {
    SuiObject? object;
    SuiObjectError? error;
    if (data['data'] != null) {
      object = SuiObject.fromJson(data['data']);
    }
    if (data['error'] != null) {
      error = SuiObjectError.fromJson(data['error']);
    }
    return GetObjectDataResponse(object, error);
  }
}

typedef ObjectDigest = String;
typedef ObjectId = String;
typedef SequenceNumber = int;

/* -------------------------------------------------------------------------- */
/*                              Helper functions                              */
/* -------------------------------------------------------------------------- */

/* -------------------------- GetObjectDataResponse ------------------------- */

SuiObject? getSuiObjectData(GetObjectDataResponse resp) {
  return resp.data;
}

bool isSuiObjectResponse(GetObjectDataResponse resp) {
  return resp.data != null;
}

SuiObjectRef? getObjectDeletedResponse(GetObjectDataResponse resp) {
  if (resp.error != null &&
      resp.error!.objectId != null &&
      resp.error!.version != null &&
      resp.error!.digest != null) {
    return SuiObjectRef(
      resp.error!.digest!,
      resp.error!.objectId!,
      resp.error!.version!,
    );
  }
  return null;
}

SuiObjectRef? getObjectReference(GetObjectDataResponse resp) {
  final objectExistsResponse = getSuiObjectData(resp);
  if (objectExistsResponse != null) {
    return objectExistsResponse.reference;
  } else {
    return getObjectDeletedResponse(resp);
  }
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

String? getObjectType(GetObjectDataResponse resp) {
  return getSuiObjectData(resp)?.data.dataType;
}

TransactionDigest? getObjectPreviousTransactionDigest(
    GetObjectDataResponse resp) {
  return getSuiObjectData(resp)?.previousTransaction;
}

ObjectOwner? getObjectOwner(GetObjectDataResponse resp) {
  return getSuiObjectData(resp)?.owner;
}

int? getSharedObjectInitialVersion(GetObjectDataResponse resp) {
  final owner = getObjectOwner(resp);
  return owner?.shared?.initialSharedVersion;
}

bool isSharedObject(GetObjectDataResponse resp) {
  final owner = getObjectOwner(resp);
  return owner?.shared != null;
}

bool isImmutableObject(GetObjectDataResponse resp) {
  final owner = getObjectOwner(resp);
  return owner == 'Immutable';
}

String? getMoveObjectType(GetObjectDataResponse resp) {
  return getMoveObject(resp)?.type;
}

ObjectContentFields? getObjectFields(dynamic resp
    // GetObjectDataResponse | SuiMoveObject
    ) {
  if (resp is SuiMoveObject) {
    return resp.fields;
  }

  return getMoveObject(resp)?.fields;
}

SuiMoveObject? getMoveObject(dynamic data // GetObjectDataResponse | SuiObject
    ) {
  var suiObject = data is SuiObject ? data : getSuiObjectData(data);
  if (suiObject?.data.dataType != 'moveObject') {
    return null;
  }
  return suiObject?.data as SuiMoveObject;
}

bool hasPublicTransfer(dynamic data // GetObjectDataResponse | SuiObject
    ) {
  return getMoveObject(data)?.has_public_transfer ?? false;
}

MovePackageContent? getMovePackageContent(dynamic data
    // GetObjectDataResponse | SuiMovePackage
    ) {
  if (data is SuiMovePackage) {
    return data.disassembled;
  }

  final suiObject = getSuiObjectData(data);
  if (suiObject == null || suiObject.data.dataType != 'package') {
    return null;
  }
  return (suiObject.data as SuiMovePackage).disassembled;
}

SuiMoveNormalizedType? extractMutableReference(
    SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('MutableReference')) {
    return normalizedType['MutableReference'];
  }
  return null;
}

SuiMoveNormalizedType? extractReference(SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('Reference')) {
    return normalizedType['Reference'];
  }
  return null;
}

SuiMoveNormalizedStructType? extractStructTag(
    SuiMoveNormalizedType normalizedType) {
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
