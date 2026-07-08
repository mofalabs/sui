// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/object.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/struct.pb.dart' as $3;
import 'bcs.pb.dart' as $0;
import 'move_package.pb.dart' as $2;
import 'owner.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// An object on the Sui blockchain.
class Object extends $pb.GeneratedMessage {
  factory Object({
    $0.Bcs? bcs,
    $core.String? objectId,
    $fixnum.Int64? version,
    $core.String? digest,
    $1.Owner? owner,
    $core.String? objectType,
    $core.bool? hasPublicTransfer,
    $0.Bcs? contents,
    $2.Package? package,
    $core.String? previousTransaction,
    $fixnum.Int64? storageRebate,
    $3.Value? json,
    $fixnum.Int64? balance,
    Display? display,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (objectId != null) result.objectId = objectId;
    if (version != null) result.version = version;
    if (digest != null) result.digest = digest;
    if (owner != null) result.owner = owner;
    if (objectType != null) result.objectType = objectType;
    if (hasPublicTransfer != null) result.hasPublicTransfer = hasPublicTransfer;
    if (contents != null) result.contents = contents;
    if (package != null) result.package = package;
    if (previousTransaction != null) result.previousTransaction = previousTransaction;
    if (storageRebate != null) result.storageRebate = storageRebate;
    if (json != null) result.json = json;
    if (balance != null) result.balance = balance;
    if (display != null) result.display = display;
    return result;
  }

  Object._();

  factory Object.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Object.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Object', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'objectId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'digest')
    ..aOM<$1.Owner>(5, _omitFieldNames ? '' : 'owner', subBuilder: $1.Owner.create)
    ..aOS(6, _omitFieldNames ? '' : 'objectType')
    ..aOB(7, _omitFieldNames ? '' : 'hasPublicTransfer')
    ..aOM<$0.Bcs>(8, _omitFieldNames ? '' : 'contents', subBuilder: $0.Bcs.create)
    ..aOM<$2.Package>(9, _omitFieldNames ? '' : 'package', subBuilder: $2.Package.create)
    ..aOS(10, _omitFieldNames ? '' : 'previousTransaction')
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'storageRebate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$3.Value>(100, _omitFieldNames ? '' : 'json', subBuilder: $3.Value.create)
    ..a<$fixnum.Int64>(101, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Display>(102, _omitFieldNames ? '' : 'display', subBuilder: Display.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Object clone() => Object()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Object copyWith(void Function(Object) updates) => super.copyWith((message) => updates(message as Object)) as Object;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Object create() => Object._();
  @$core.override
  Object createEmptyInstance() => create();
  static $pb.PbList<Object> createRepeated() => $pb.PbList<Object>();
  @$core.pragma('dart2js:noInline')
  static Object getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Object>(create);
  static Object? _defaultInstance;

  /// This Object serialized as BCS.
  @$pb.TagNumber(1)
  $0.Bcs get bcs => $_getN(0);
  @$pb.TagNumber(1)
  set bcs($0.Bcs value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBcs() => $_has(0);
  @$pb.TagNumber(1)
  void clearBcs() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Bcs ensureBcs() => $_ensure(0);

  /// `ObjectId` for this object.
  @$pb.TagNumber(2)
  $core.String get objectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set objectId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasObjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearObjectId() => $_clearField(2);

  /// Version of the object.
  @$pb.TagNumber(3)
  $fixnum.Int64 get version => $_getI64(2);
  @$pb.TagNumber(3)
  set version($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// The digest of this Object.
  @$pb.TagNumber(4)
  $core.String get digest => $_getSZ(3);
  @$pb.TagNumber(4)
  set digest($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearDigest() => $_clearField(4);

  /// Owner of the object.
  @$pb.TagNumber(5)
  $1.Owner get owner => $_getN(4);
  @$pb.TagNumber(5)
  set owner($1.Owner value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOwner() => $_has(4);
  @$pb.TagNumber(5)
  void clearOwner() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Owner ensureOwner() => $_ensure(4);

  /// The type of this object.
  ///
  /// This will be 'package' for packages and a StructTag for move structs.
  @$pb.TagNumber(6)
  $core.String get objectType => $_getSZ(5);
  @$pb.TagNumber(6)
  set objectType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasObjectType() => $_has(5);
  @$pb.TagNumber(6)
  void clearObjectType() => $_clearField(6);

  /// DEPRECATED this field is no longer used to determine whether a tx can transfer this
  /// object. Instead, it is always calculated from the objects type when loaded in execution.
  ///
  /// Only set for Move structs
  @$pb.TagNumber(7)
  $core.bool get hasPublicTransfer => $_getBF(6);
  @$pb.TagNumber(7)
  set hasPublicTransfer($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHasPublicTransfer() => $_has(6);
  @$pb.TagNumber(7)
  void clearHasPublicTransfer() => $_clearField(7);

  /// BCS bytes of a Move struct value.
  ///
  /// Only set for Move structs
  @$pb.TagNumber(8)
  $0.Bcs get contents => $_getN(7);
  @$pb.TagNumber(8)
  set contents($0.Bcs value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasContents() => $_has(7);
  @$pb.TagNumber(8)
  void clearContents() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Bcs ensureContents() => $_ensure(7);

  /// Package information for Move Packages
  @$pb.TagNumber(9)
  $2.Package get package => $_getN(8);
  @$pb.TagNumber(9)
  set package($2.Package value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPackage() => $_has(8);
  @$pb.TagNumber(9)
  void clearPackage() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.Package ensurePackage() => $_ensure(8);

  /// The digest of the transaction that created or last mutated this object
  @$pb.TagNumber(10)
  $core.String get previousTransaction => $_getSZ(9);
  @$pb.TagNumber(10)
  set previousTransaction($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPreviousTransaction() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreviousTransaction() => $_clearField(10);

  /// The amount of SUI to rebate if this object gets deleted.
  /// This number is re-calculated each time the object is mutated based on
  /// the present storage gas price.
  @$pb.TagNumber(11)
  $fixnum.Int64 get storageRebate => $_getI64(10);
  @$pb.TagNumber(11)
  set storageRebate($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStorageRebate() => $_has(10);
  @$pb.TagNumber(11)
  void clearStorageRebate() => $_clearField(11);

  /// JSON rendering of the object.
  @$pb.TagNumber(100)
  $3.Value get json => $_getN(11);
  @$pb.TagNumber(100)
  set json($3.Value value) => $_setField(100, value);
  @$pb.TagNumber(100)
  $core.bool hasJson() => $_has(11);
  @$pb.TagNumber(100)
  void clearJson() => $_clearField(100);
  @$pb.TagNumber(100)
  $3.Value ensureJson() => $_ensure(11);

  /// Current balance if this object is a `0x2::coin::Coin<T>`
  @$pb.TagNumber(101)
  $fixnum.Int64 get balance => $_getI64(12);
  @$pb.TagNumber(101)
  set balance($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(101)
  $core.bool hasBalance() => $_has(12);
  @$pb.TagNumber(101)
  void clearBalance() => $_clearField(101);

  /// JSON rendering of the object based on an on-chain template.
  /// This will not be set if the value's type does not have an associated `Display` template.
  @$pb.TagNumber(102)
  Display get display => $_getN(13);
  @$pb.TagNumber(102)
  set display(Display value) => $_setField(102, value);
  @$pb.TagNumber(102)
  $core.bool hasDisplay() => $_has(13);
  @$pb.TagNumber(102)
  void clearDisplay() => $_clearField(102);
  @$pb.TagNumber(102)
  Display ensureDisplay() => $_ensure(13);
}

/// Set of Objects
class ObjectSet extends $pb.GeneratedMessage {
  factory ObjectSet({
    $core.Iterable<Object>? objects,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    return result;
  }

  ObjectSet._();

  factory ObjectSet.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ObjectSet.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ObjectSet', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<Object>(1, _omitFieldNames ? '' : 'objects', $pb.PbFieldType.PM, subBuilder: Object.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObjectSet clone() => ObjectSet()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObjectSet copyWith(void Function(ObjectSet) updates) => super.copyWith((message) => updates(message as ObjectSet)) as ObjectSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObjectSet create() => ObjectSet._();
  @$core.override
  ObjectSet createEmptyInstance() => create();
  static $pb.PbList<ObjectSet> createRepeated() => $pb.PbList<ObjectSet>();
  @$core.pragma('dart2js:noInline')
  static ObjectSet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ObjectSet>(create);
  static ObjectSet? _defaultInstance;

  /// Objects are sorted by the key `(object_id, version)`.
  @$pb.TagNumber(1)
  $pb.PbList<Object> get objects => $_getList(0);
}

/// A rendered JSON blob based on an on-chain template.
class Display extends $pb.GeneratedMessage {
  factory Display({
    $3.Value? output,
    $3.Value? errors,
  }) {
    final result = create();
    if (output != null) result.output = output;
    if (errors != null) result.errors = errors;
    return result;
  }

  Display._();

  factory Display.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Display.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Display', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$3.Value>(1, _omitFieldNames ? '' : 'output', subBuilder: $3.Value.create)
    ..aOM<$3.Value>(2, _omitFieldNames ? '' : 'errors', subBuilder: $3.Value.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Display clone() => Display()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Display copyWith(void Function(Display) updates) => super.copyWith((message) => updates(message as Display)) as Display;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Display create() => Display._();
  @$core.override
  Display createEmptyInstance() => create();
  static $pb.PbList<Display> createRepeated() => $pb.PbList<Display>();
  @$core.pragma('dart2js:noInline')
  static Display getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Display>(create);
  static Display? _defaultInstance;

  /// Output for all successfully substituted display fields. Unsuccessful
  /// fields will be `null`, and will be accompanied by a field in `errors`,
  /// explaining the error.
  @$pb.TagNumber(1)
  $3.Value get output => $_getN(0);
  @$pb.TagNumber(1)
  set output($3.Value value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Value ensureOutput() => $_ensure(0);

  /// If any fields failed to render, this will contain a mapping from failed
  /// field names to error messages. If all fields succeed, this will either be
  /// `null` or not set.
  @$pb.TagNumber(2)
  $3.Value get errors => $_getN(1);
  @$pb.TagNumber(2)
  set errors($3.Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasErrors() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrors() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.Value ensureErrors() => $_ensure(1);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
