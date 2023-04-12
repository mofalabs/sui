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

  SuiObjectError(this.code, this.digest, this.objectId, this.version,
      this.error);

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
  String dataType;

  /// Fields and values stored inside the Move object
  ObjectContentFields fields;
  bool? hasPublicTransfer;

  SuiMoveObject(this.dataType, this.type, this.fields, this.hasPublicTransfer);

  factory SuiMoveObject.fromJson(dynamic data) {
    return SuiMoveObject(
      data['dataType'] ?? "",
      data['type'] ?? "",
      data['fields'],
      data['hasPublicTransfer'],
    );
  }
}

class SuiRawMoveObject {
  String type;
  String dataType;
  String hasPublicTransfer;

  /// Fields and values stored inside the Move object
  int version;
  dynamic bcsBytes;

  SuiRawMoveObject(
    this.dataType,
    this.type,
    this.hasPublicTransfer,
    this.version,
    this.bcsBytes,
  );

  factory SuiRawMoveObject.fromJson(dynamic data) {
    return SuiRawMoveObject(
      data['dataType'] ?? "",
      data['type'] ?? "",
      data['hasPublicTransfer'],
      data['version'],
      data['bcsBytes'],
    );
  }
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
  ObjectId id;
  ObjectDigest digest;
  String version;

  /// Type of the object, default to be undefined unless SuiObjectDataOptions.showType is set to true
  String? type;
  /// Move object content or package content, default to be undefined unless SuiObjectDataOptions.showContent is set to true
  SuiMoveObject? content;
  /// Move object content or package content in BCS bytes, default to be undefined unless SuiObjectDataOptions.showBcs is set to true
  SuiRawMoveObject? bcs;
  /// The owner of this object. Default to be undefined unless SuiObjectDataOptions.showOwner is set to true
  ObjectOwner? owner;
  /// The digest of the transaction that created or last mutated this object.
  /// Default to be undefined unless SuiObjectDataOptions.showPreviousTransaction is set to true
  TransactionDigest? previousTransaction;
  /*
   * The amount of SUI we would rebate if this object gets deleted.
   * This number is re-calculated each time the object is mutated based on
   * the present storage gas price.
   * Default to be undefined unless SuiObjectDataOptions.showStorageRebate is set to true
   */
  String? storageRebate;

  /*
   * Display metadata for this object, default to be undefined unless SuiObjectDataOptions.showDisplay is set to true
   * This can also be None if the struct type does not have Display defined
   * See more details in https://forums.sui.io/t/nft-object-display-proposal/4872
   */
  dynamic display;

  SuiObject(
    this.id,
    this.digest,
    this.version,
    this.type,
    this.content,
    this.bcs,
    this.owner,
    this.previousTransaction,
    this.storageRebate,
    this.display,
  );

  factory SuiObject.fromJson(dynamic data) {
    SuiMoveObject? content;
    if(data['content']!=null){
      content = SuiMoveObject.fromJson(data['content']);
    }

    SuiRawMoveObject? bcs;
    if(data['bcs']!=null){
      bcs = SuiRawMoveObject.fromJson(data['bcs']);
    }

    ObjectOwner? owner;
    if(data['owner']!=null){
      owner = ObjectOwner.fromJson(data['owner']);
    }
    return SuiObject(
      data['id'],
      data['digest'],
      data['version'],
      data['type'],
      content,
      bcs,
      owner,
      data['previousTransaction'],
      data['storageRebate'],
      data['display'],
    );
  }
}

class SuiObjectResponse {
  SuiObject? data;
  SuiObjectError? error;

  SuiObjectResponse(this.data, this.error);

  factory SuiObjectResponse.fromJson(dynamic data) {
    SuiObject? object;
    SuiObjectError? error;
    if (data['data'] != null) {
      object = SuiObject.fromJson(data['data']);
    }
    if (data['error'] != null) {
      error = SuiObjectError.fromJson(data['error']);
    }
    return SuiObjectResponse(object, error);
  }
}

typedef ObjectDigest = String;
typedef ObjectId = String;
typedef SequenceNumber = int;

/* -------------------------------------------------------------------------- */
/*                              Helper functions                              */
/* -------------------------------------------------------------------------- */

/* -------------------------- SuiObjectResponse ------------------------- */

SuiObject? getSuiObjectData(SuiObjectResponse resp) {
  return resp.data;
}

bool isSuiObjectResponse(SuiObjectResponse resp) {
  return resp.data != null;
}

SuiObjectRef? getObjectDeletedResponse(SuiObjectResponse resp) {
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

SuiObjectRef? getObjectReference(SuiObjectResponse resp) {
  final objectExistsResponse = getSuiObjectData(resp);
  if (objectExistsResponse != null) {
    return SuiObjectRef(
      objectExistsResponse.digest,
      objectExistsResponse.id,
      int.parse(objectExistsResponse.version),
    );
  } else {
    return getObjectDeletedResponse(resp);
  }
}

int? getObjectVersion(dynamic data // SuiObjectResponse | SuiObjectRef
    ) {
  if (data is SuiObjectRef) {
    return data.version;
  }
  return getObjectReference(data)?.version;
}

/* -------------------------------- SuiObject ------------------------------- */

String? getObjectType(SuiObjectResponse resp) {
  return getSuiObjectData(resp)?.content?.dataType;
}

TransactionDigest? getObjectPreviousTransactionDigest(
    SuiObjectResponse resp) {
  return getSuiObjectData(resp)?.previousTransaction;
}

ObjectOwner? getObjectOwner(SuiObjectResponse resp) {
  return getSuiObjectData(resp)?.owner;
}

int? getSharedObjectInitialVersion(SuiObjectResponse resp) {
  final owner = getObjectOwner(resp);
  return owner?.shared?.initialSharedVersion;
}

bool isSharedObject(SuiObjectResponse resp) {
  final owner = getObjectOwner(resp);
  return owner?.shared != null;
}

bool isImmutableObject(SuiObjectResponse resp) {
  final owner = getObjectOwner(resp);
  return owner == 'Immutable';
}

String? getMoveObjectType(SuiObjectResponse resp) {
  return getMoveObject(resp)?.type;
}

ObjectContentFields? getObjectFields(dynamic resp
    // SuiObjectResponse | SuiMoveObject
    ) {
  if (resp is SuiMoveObject) {
    return resp.fields;
  }

  return getMoveObject(resp)?.fields;
}

SuiMoveObject? getMoveObject(dynamic data // SuiObjectResponse | SuiObject
    ) {
  var suiObject = data is SuiObject ? data : getSuiObjectData(data);
  if (suiObject?.content?.dataType != 'moveObject') {
    return null;
  }
  return suiObject?.content as SuiMoveObject;
}

bool hasPublicTransfer(dynamic data // SuiObjectResponse | SuiObject
    ) {
  return getMoveObject(data)?.hasPublicTransfer ?? false;
}

MovePackageContent? getMovePackageContent(dynamic data
    // SuiObjectResponse | SuiMovePackage
    ) {
  if (data is SuiMovePackage) {
    return data.disassembled;
  }

  final suiObject = getSuiObjectData(data);
  if (suiObject == null || suiObject.content?.dataType != 'package') {
    return null;
  }
  return (suiObject.content as SuiMovePackage).disassembled;
}


class SuiObjectDataOptions {
  /* Whether to fetch the object type, default to be true */
  bool showType;

  /* Whether to fetch the object content, default to be false */
  bool showContent;

  /* Whether to fetch the object content in BCS bytes, default to be false */
  bool showBcs;

  /* Whether to fetch the object owner, default to be false */
  bool showOwner;

  /* Whether to fetch the previous transaction digest, default to be false */
  bool showPreviousTransaction;

  /* Whether to fetch the storage rebate, default to be false */
  bool showStorageRebate;

  /* Whether to fetch the display metadata, default to be false */
  bool showDisplay;

  SuiObjectDataOptions({
    this.showType = false,
    this.showContent = false,
    this.showBcs = false,
    this.showOwner = false,
    this.showPreviousTransaction = false,
    this.showStorageRebate = false,
    this.showDisplay = false,
  });
}