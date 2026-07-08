// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/name_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/timestamp.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class LookupNameRequest extends $pb.GeneratedMessage {
  factory LookupNameRequest({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  LookupNameRequest._();

  factory LookupNameRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LookupNameRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupNameRequest clone() => LookupNameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupNameRequest copyWith(void Function(LookupNameRequest) updates) => super.copyWith((message) => updates(message as LookupNameRequest)) as LookupNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupNameRequest create() => LookupNameRequest._();
  @$core.override
  LookupNameRequest createEmptyInstance() => create();
  static $pb.PbList<LookupNameRequest> createRepeated() => $pb.PbList<LookupNameRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupNameRequest>(create);
  static LookupNameRequest? _defaultInstance;

  /// Required. The SuiNS name to lookup.
  ///
  /// Supports both `@name` as well as `name.sui` formats.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class LookupNameResponse extends $pb.GeneratedMessage {
  factory LookupNameResponse({
    NameRecord? record,
  }) {
    final result = create();
    if (record != null) result.record = record;
    return result;
  }

  LookupNameResponse._();

  factory LookupNameResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LookupNameResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupNameResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<NameRecord>(1, _omitFieldNames ? '' : 'record', subBuilder: NameRecord.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupNameResponse clone() => LookupNameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupNameResponse copyWith(void Function(LookupNameResponse) updates) => super.copyWith((message) => updates(message as LookupNameResponse)) as LookupNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupNameResponse create() => LookupNameResponse._();
  @$core.override
  LookupNameResponse createEmptyInstance() => create();
  static $pb.PbList<LookupNameResponse> createRepeated() => $pb.PbList<LookupNameResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupNameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupNameResponse>(create);
  static LookupNameResponse? _defaultInstance;

  /// The record for the requested name
  @$pb.TagNumber(1)
  NameRecord get record => $_getN(0);
  @$pb.TagNumber(1)
  set record(NameRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecord() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecord() => $_clearField(1);
  @$pb.TagNumber(1)
  NameRecord ensureRecord() => $_ensure(0);
}

class ReverseLookupNameRequest extends $pb.GeneratedMessage {
  factory ReverseLookupNameRequest({
    $core.String? address,
  }) {
    final result = create();
    if (address != null) result.address = address;
    return result;
  }

  ReverseLookupNameRequest._();

  factory ReverseLookupNameRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ReverseLookupNameRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReverseLookupNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReverseLookupNameRequest clone() => ReverseLookupNameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReverseLookupNameRequest copyWith(void Function(ReverseLookupNameRequest) updates) => super.copyWith((message) => updates(message as ReverseLookupNameRequest)) as ReverseLookupNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReverseLookupNameRequest create() => ReverseLookupNameRequest._();
  @$core.override
  ReverseLookupNameRequest createEmptyInstance() => create();
  static $pb.PbList<ReverseLookupNameRequest> createRepeated() => $pb.PbList<ReverseLookupNameRequest>();
  @$core.pragma('dart2js:noInline')
  static ReverseLookupNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReverseLookupNameRequest>(create);
  static ReverseLookupNameRequest? _defaultInstance;

  /// Required. The address to perform a reverse lookup for.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

class ReverseLookupNameResponse extends $pb.GeneratedMessage {
  factory ReverseLookupNameResponse({
    NameRecord? record,
  }) {
    final result = create();
    if (record != null) result.record = record;
    return result;
  }

  ReverseLookupNameResponse._();

  factory ReverseLookupNameResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ReverseLookupNameResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReverseLookupNameResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<NameRecord>(1, _omitFieldNames ? '' : 'record', subBuilder: NameRecord.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReverseLookupNameResponse clone() => ReverseLookupNameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReverseLookupNameResponse copyWith(void Function(ReverseLookupNameResponse) updates) => super.copyWith((message) => updates(message as ReverseLookupNameResponse)) as ReverseLookupNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReverseLookupNameResponse create() => ReverseLookupNameResponse._();
  @$core.override
  ReverseLookupNameResponse createEmptyInstance() => create();
  static $pb.PbList<ReverseLookupNameResponse> createRepeated() => $pb.PbList<ReverseLookupNameResponse>();
  @$core.pragma('dart2js:noInline')
  static ReverseLookupNameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReverseLookupNameResponse>(create);
  static ReverseLookupNameResponse? _defaultInstance;

  /// The record for the SuiNS name linked to the requested address
  @$pb.TagNumber(1)
  NameRecord get record => $_getN(0);
  @$pb.TagNumber(1)
  set record(NameRecord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecord() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecord() => $_clearField(1);
  @$pb.TagNumber(1)
  NameRecord ensureRecord() => $_ensure(0);
}

class NameRecord extends $pb.GeneratedMessage {
  factory NameRecord({
    $core.String? id,
    $core.String? name,
    $core.String? registrationNftId,
    $0.Timestamp? expirationTimestamp,
    $core.String? targetAddress,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? data,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (registrationNftId != null) result.registrationNftId = registrationNftId;
    if (expirationTimestamp != null) result.expirationTimestamp = expirationTimestamp;
    if (targetAddress != null) result.targetAddress = targetAddress;
    if (data != null) result.data.addEntries(data);
    return result;
  }

  NameRecord._();

  factory NameRecord.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory NameRecord.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NameRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'registrationNftId')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'expirationTimestamp', subBuilder: $0.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'targetAddress')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'data', entryClassName: 'NameRecord.DataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('sui.rpc.v2'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRecord clone() => NameRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRecord copyWith(void Function(NameRecord) updates) => super.copyWith((message) => updates(message as NameRecord)) as NameRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRecord create() => NameRecord._();
  @$core.override
  NameRecord createEmptyInstance() => create();
  static $pb.PbList<NameRecord> createRepeated() => $pb.PbList<NameRecord>();
  @$core.pragma('dart2js:noInline')
  static NameRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NameRecord>(create);
  static NameRecord? _defaultInstance;

  /// Id of this record.
  ///
  /// Note that records are stored on chain as dynamic fields of the type
  /// `Field<Domain,NameRecord>`.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// The SuiNS name of this record
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// The ID of the `RegistrationNFT` assigned to this record.
  ///
  /// The owner of the corresponding `RegistrationNFT` has the rights to
  /// be able to change and adjust the `target_address` of this domain.
  ///
  /// It is possible that the ID changes if the record expires and is
  /// purchased by someone else.
  @$pb.TagNumber(3)
  $core.String get registrationNftId => $_getSZ(2);
  @$pb.TagNumber(3)
  set registrationNftId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRegistrationNftId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegistrationNftId() => $_clearField(3);

  /// Timestamp when the record expires.
  ///
  /// This is either the expiration of the record itself or the expiration of
  /// this record's parent if this is a leaf record.
  @$pb.TagNumber(4)
  $0.Timestamp get expirationTimestamp => $_getN(3);
  @$pb.TagNumber(4)
  set expirationTimestamp($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasExpirationTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpirationTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureExpirationTimestamp() => $_ensure(3);

  /// The target address that this name points to
  @$pb.TagNumber(5)
  $core.String get targetAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetAddress($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAddress() => $_clearField(5);

  /// Additional data which may be stored in a record
  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get data => $_getMap(5);
}

class NameServiceApi {
  final $pb.RpcClient _client;

  NameServiceApi(this._client);

  $async.Future<LookupNameResponse> lookupName($pb.ClientContext? ctx, LookupNameRequest request) =>
    _client.invoke<LookupNameResponse>(ctx, 'NameService', 'LookupName', request, LookupNameResponse())
  ;
  $async.Future<ReverseLookupNameResponse> reverseLookupName($pb.ClientContext? ctx, ReverseLookupNameRequest request) =>
    _client.invoke<ReverseLookupNameResponse>(ctx, 'NameService', 'ReverseLookupName', request, ReverseLookupNameResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
