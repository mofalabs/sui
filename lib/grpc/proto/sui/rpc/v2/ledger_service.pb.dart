// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/ledger_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/field_mask.pb.dart' as $1;
import '../../../google/protobuf/timestamp.pb.dart' as $0;
import '../../../google/rpc/status.pb.dart' as $3;
import 'checkpoint.pb.dart' as $5;
import 'epoch.pb.dart' as $6;
import 'executed_transaction.pb.dart' as $4;
import 'object.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetServiceInfoRequest extends $pb.GeneratedMessage {
  factory GetServiceInfoRequest() => create();

  GetServiceInfoRequest._();

  factory GetServiceInfoRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetServiceInfoRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetServiceInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceInfoRequest clone() => GetServiceInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceInfoRequest copyWith(void Function(GetServiceInfoRequest) updates) => super.copyWith((message) => updates(message as GetServiceInfoRequest)) as GetServiceInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceInfoRequest create() => GetServiceInfoRequest._();
  @$core.override
  GetServiceInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceInfoRequest> createRepeated() => $pb.PbList<GetServiceInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetServiceInfoRequest>(create);
  static GetServiceInfoRequest? _defaultInstance;
}

class GetServiceInfoResponse extends $pb.GeneratedMessage {
  factory GetServiceInfoResponse({
    $core.String? chainId,
    $core.String? chain,
    $fixnum.Int64? epoch,
    $fixnum.Int64? checkpointHeight,
    $0.Timestamp? timestamp,
    $fixnum.Int64? lowestAvailableCheckpoint,
    $fixnum.Int64? lowestAvailableCheckpointObjects,
    $core.String? server,
  }) {
    final result = create();
    if (chainId != null) result.chainId = chainId;
    if (chain != null) result.chain = chain;
    if (epoch != null) result.epoch = epoch;
    if (checkpointHeight != null) result.checkpointHeight = checkpointHeight;
    if (timestamp != null) result.timestamp = timestamp;
    if (lowestAvailableCheckpoint != null) result.lowestAvailableCheckpoint = lowestAvailableCheckpoint;
    if (lowestAvailableCheckpointObjects != null) result.lowestAvailableCheckpointObjects = lowestAvailableCheckpointObjects;
    if (server != null) result.server = server;
    return result;
  }

  GetServiceInfoResponse._();

  factory GetServiceInfoResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetServiceInfoResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetServiceInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chainId')
    ..aOS(2, _omitFieldNames ? '' : 'chain')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'checkpointHeight', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'timestamp', subBuilder: $0.Timestamp.create)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'lowestAvailableCheckpoint', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'lowestAvailableCheckpointObjects', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'server')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceInfoResponse clone() => GetServiceInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetServiceInfoResponse copyWith(void Function(GetServiceInfoResponse) updates) => super.copyWith((message) => updates(message as GetServiceInfoResponse)) as GetServiceInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceInfoResponse create() => GetServiceInfoResponse._();
  @$core.override
  GetServiceInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetServiceInfoResponse> createRepeated() => $pb.PbList<GetServiceInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetServiceInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetServiceInfoResponse>(create);
  static GetServiceInfoResponse? _defaultInstance;

  /// The chain identifier of the chain that this node is on.
  ///
  /// The chain identifier is the digest of the genesis checkpoint, the
  /// checkpoint with sequence number 0.
  @$pb.TagNumber(1)
  $core.String get chainId => $_getSZ(0);
  @$pb.TagNumber(1)
  set chainId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChainId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChainId() => $_clearField(1);

  /// Human-readable name of the chain that this node is on.
  ///
  /// This is intended to be a human-readable name like `mainnet`, `testnet`, and so on.
  @$pb.TagNumber(2)
  $core.String get chain => $_getSZ(1);
  @$pb.TagNumber(2)
  set chain($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChain() => $_has(1);
  @$pb.TagNumber(2)
  void clearChain() => $_clearField(2);

  /// Current epoch of the node based on its highest executed checkpoint.
  @$pb.TagNumber(3)
  $fixnum.Int64 get epoch => $_getI64(2);
  @$pb.TagNumber(3)
  set epoch($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpoch() => $_clearField(3);

  /// Checkpoint height of the most recently executed checkpoint.
  @$pb.TagNumber(4)
  $fixnum.Int64 get checkpointHeight => $_getI64(3);
  @$pb.TagNumber(4)
  set checkpointHeight($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCheckpointHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearCheckpointHeight() => $_clearField(4);

  /// Unix timestamp of the most recently executed checkpoint.
  @$pb.TagNumber(5)
  $0.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureTimestamp() => $_ensure(4);

  /// The lowest checkpoint for which checkpoints and transaction data are available.
  @$pb.TagNumber(6)
  $fixnum.Int64 get lowestAvailableCheckpoint => $_getI64(5);
  @$pb.TagNumber(6)
  set lowestAvailableCheckpoint($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLowestAvailableCheckpoint() => $_has(5);
  @$pb.TagNumber(6)
  void clearLowestAvailableCheckpoint() => $_clearField(6);

  /// The lowest checkpoint for which object data is available.
  @$pb.TagNumber(7)
  $fixnum.Int64 get lowestAvailableCheckpointObjects => $_getI64(6);
  @$pb.TagNumber(7)
  set lowestAvailableCheckpointObjects($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLowestAvailableCheckpointObjects() => $_has(6);
  @$pb.TagNumber(7)
  void clearLowestAvailableCheckpointObjects() => $_clearField(7);

  /// Software version of the service. Similar to the `server` http header.
  @$pb.TagNumber(8)
  $core.String get server => $_getSZ(7);
  @$pb.TagNumber(8)
  set server($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasServer() => $_has(7);
  @$pb.TagNumber(8)
  void clearServer() => $_clearField(8);
}

class GetObjectRequest extends $pb.GeneratedMessage {
  factory GetObjectRequest({
    $core.String? objectId,
    $fixnum.Int64? version,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (objectId != null) result.objectId = objectId;
    if (version != null) result.version = version;
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  GetObjectRequest._();

  factory GetObjectRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetObjectRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetObjectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'objectId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.FieldMask>(3, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectRequest clone() => GetObjectRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectRequest copyWith(void Function(GetObjectRequest) updates) => super.copyWith((message) => updates(message as GetObjectRequest)) as GetObjectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetObjectRequest create() => GetObjectRequest._();
  @$core.override
  GetObjectRequest createEmptyInstance() => create();
  static $pb.PbList<GetObjectRequest> createRepeated() => $pb.PbList<GetObjectRequest>();
  @$core.pragma('dart2js:noInline')
  static GetObjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetObjectRequest>(create);
  static GetObjectRequest? _defaultInstance;

  /// Required. The `ObjectId` of the requested object.
  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => $_clearField(1);

  /// Request a specific version of the object.
  /// If no version is specified, and the object is live, then the latest
  /// version of the object is returned.
  @$pb.TagNumber(2)
  $fixnum.Int64 get version => $_getI64(1);
  @$pb.TagNumber(2)
  set version($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `object_id,version,digest`.
  @$pb.TagNumber(3)
  $1.FieldMask get readMask => $_getN(2);
  @$pb.TagNumber(3)
  set readMask($1.FieldMask value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReadMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearReadMask() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.FieldMask ensureReadMask() => $_ensure(2);
}

class GetObjectResponse extends $pb.GeneratedMessage {
  factory GetObjectResponse({
    $2.Object? object,
  }) {
    final result = create();
    if (object != null) result.object = object;
    return result;
  }

  GetObjectResponse._();

  factory GetObjectResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetObjectResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetObjectResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$2.Object>(1, _omitFieldNames ? '' : 'object', subBuilder: $2.Object.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectResponse clone() => GetObjectResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectResponse copyWith(void Function(GetObjectResponse) updates) => super.copyWith((message) => updates(message as GetObjectResponse)) as GetObjectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetObjectResponse create() => GetObjectResponse._();
  @$core.override
  GetObjectResponse createEmptyInstance() => create();
  static $pb.PbList<GetObjectResponse> createRepeated() => $pb.PbList<GetObjectResponse>();
  @$core.pragma('dart2js:noInline')
  static GetObjectResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetObjectResponse>(create);
  static GetObjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Object get object => $_getN(0);
  @$pb.TagNumber(1)
  set object($2.Object value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasObject() => $_has(0);
  @$pb.TagNumber(1)
  void clearObject() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Object ensureObject() => $_ensure(0);
}

class BatchGetObjectsRequest extends $pb.GeneratedMessage {
  factory BatchGetObjectsRequest({
    $core.Iterable<GetObjectRequest>? requests,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (requests != null) result.requests.addAll(requests);
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  BatchGetObjectsRequest._();

  factory BatchGetObjectsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BatchGetObjectsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchGetObjectsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<GetObjectRequest>(1, _omitFieldNames ? '' : 'requests', $pb.PbFieldType.PM, subBuilder: GetObjectRequest.create)
    ..aOM<$1.FieldMask>(2, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetObjectsRequest clone() => BatchGetObjectsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetObjectsRequest copyWith(void Function(BatchGetObjectsRequest) updates) => super.copyWith((message) => updates(message as BatchGetObjectsRequest)) as BatchGetObjectsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetObjectsRequest create() => BatchGetObjectsRequest._();
  @$core.override
  BatchGetObjectsRequest createEmptyInstance() => create();
  static $pb.PbList<BatchGetObjectsRequest> createRepeated() => $pb.PbList<BatchGetObjectsRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchGetObjectsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchGetObjectsRequest>(create);
  static BatchGetObjectsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GetObjectRequest> get requests => $_getList(0);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `object_id,version,digest`.
  @$pb.TagNumber(2)
  $1.FieldMask get readMask => $_getN(1);
  @$pb.TagNumber(2)
  set readMask($1.FieldMask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReadMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.FieldMask ensureReadMask() => $_ensure(1);
}

class BatchGetObjectsResponse extends $pb.GeneratedMessage {
  factory BatchGetObjectsResponse({
    $core.Iterable<GetObjectResult>? objects,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    return result;
  }

  BatchGetObjectsResponse._();

  factory BatchGetObjectsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BatchGetObjectsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchGetObjectsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<GetObjectResult>(1, _omitFieldNames ? '' : 'objects', $pb.PbFieldType.PM, subBuilder: GetObjectResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetObjectsResponse clone() => BatchGetObjectsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetObjectsResponse copyWith(void Function(BatchGetObjectsResponse) updates) => super.copyWith((message) => updates(message as BatchGetObjectsResponse)) as BatchGetObjectsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetObjectsResponse create() => BatchGetObjectsResponse._();
  @$core.override
  BatchGetObjectsResponse createEmptyInstance() => create();
  static $pb.PbList<BatchGetObjectsResponse> createRepeated() => $pb.PbList<BatchGetObjectsResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchGetObjectsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchGetObjectsResponse>(create);
  static BatchGetObjectsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GetObjectResult> get objects => $_getList(0);
}

enum GetObjectResult_Result {
  object, 
  error, 
  notSet
}

class GetObjectResult extends $pb.GeneratedMessage {
  factory GetObjectResult({
    $2.Object? object,
    $3.Status? error,
  }) {
    final result = create();
    if (object != null) result.object = object;
    if (error != null) result.error = error;
    return result;
  }

  GetObjectResult._();

  factory GetObjectResult.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetObjectResult.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, GetObjectResult_Result> _GetObjectResult_ResultByTag = {
    1 : GetObjectResult_Result.object,
    2 : GetObjectResult_Result.error,
    0 : GetObjectResult_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetObjectResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$2.Object>(1, _omitFieldNames ? '' : 'object', subBuilder: $2.Object.create)
    ..aOM<$3.Status>(2, _omitFieldNames ? '' : 'error', subBuilder: $3.Status.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectResult clone() => GetObjectResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetObjectResult copyWith(void Function(GetObjectResult) updates) => super.copyWith((message) => updates(message as GetObjectResult)) as GetObjectResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetObjectResult create() => GetObjectResult._();
  @$core.override
  GetObjectResult createEmptyInstance() => create();
  static $pb.PbList<GetObjectResult> createRepeated() => $pb.PbList<GetObjectResult>();
  @$core.pragma('dart2js:noInline')
  static GetObjectResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetObjectResult>(create);
  static GetObjectResult? _defaultInstance;

  GetObjectResult_Result whichResult() => _GetObjectResult_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $2.Object get object => $_getN(0);
  @$pb.TagNumber(1)
  set object($2.Object value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasObject() => $_has(0);
  @$pb.TagNumber(1)
  void clearObject() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Object ensureObject() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.Status get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($3.Status value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.Status ensureError() => $_ensure(1);
}

class GetTransactionRequest extends $pb.GeneratedMessage {
  factory GetTransactionRequest({
    $core.String? digest,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (digest != null) result.digest = digest;
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  GetTransactionRequest._();

  factory GetTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'digest')
    ..aOM<$1.FieldMask>(2, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionRequest clone() => GetTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionRequest copyWith(void Function(GetTransactionRequest) updates) => super.copyWith((message) => updates(message as GetTransactionRequest)) as GetTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest create() => GetTransactionRequest._();
  @$core.override
  GetTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionRequest> createRepeated() => $pb.PbList<GetTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionRequest>(create);
  static GetTransactionRequest? _defaultInstance;

  /// Required. The digest of the requested transaction.
  @$pb.TagNumber(1)
  $core.String get digest => $_getSZ(0);
  @$pb.TagNumber(1)
  set digest($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDigest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDigest() => $_clearField(1);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `digest`.
  @$pb.TagNumber(2)
  $1.FieldMask get readMask => $_getN(1);
  @$pb.TagNumber(2)
  set readMask($1.FieldMask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReadMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.FieldMask ensureReadMask() => $_ensure(1);
}

class GetTransactionResponse extends $pb.GeneratedMessage {
  factory GetTransactionResponse({
    $4.ExecutedTransaction? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  GetTransactionResponse._();

  factory GetTransactionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetTransactionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$4.ExecutedTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $4.ExecutedTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResponse clone() => GetTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResponse copyWith(void Function(GetTransactionResponse) updates) => super.copyWith((message) => updates(message as GetTransactionResponse)) as GetTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse create() => GetTransactionResponse._();
  @$core.override
  GetTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionResponse> createRepeated() => $pb.PbList<GetTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionResponse>(create);
  static GetTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $4.ExecutedTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($4.ExecutedTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.ExecutedTransaction ensureTransaction() => $_ensure(0);
}

class BatchGetTransactionsRequest extends $pb.GeneratedMessage {
  factory BatchGetTransactionsRequest({
    $core.Iterable<$core.String>? digests,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (digests != null) result.digests.addAll(digests);
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  BatchGetTransactionsRequest._();

  factory BatchGetTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BatchGetTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchGetTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'digests')
    ..aOM<$1.FieldMask>(2, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetTransactionsRequest clone() => BatchGetTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetTransactionsRequest copyWith(void Function(BatchGetTransactionsRequest) updates) => super.copyWith((message) => updates(message as BatchGetTransactionsRequest)) as BatchGetTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetTransactionsRequest create() => BatchGetTransactionsRequest._();
  @$core.override
  BatchGetTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<BatchGetTransactionsRequest> createRepeated() => $pb.PbList<BatchGetTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchGetTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchGetTransactionsRequest>(create);
  static BatchGetTransactionsRequest? _defaultInstance;

  /// Required. The digests of the requested transactions.
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get digests => $_getList(0);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `digest`.
  @$pb.TagNumber(2)
  $1.FieldMask get readMask => $_getN(1);
  @$pb.TagNumber(2)
  set readMask($1.FieldMask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReadMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.FieldMask ensureReadMask() => $_ensure(1);
}

class BatchGetTransactionsResponse extends $pb.GeneratedMessage {
  factory BatchGetTransactionsResponse({
    $core.Iterable<GetTransactionResult>? transactions,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  BatchGetTransactionsResponse._();

  factory BatchGetTransactionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BatchGetTransactionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchGetTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<GetTransactionResult>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: GetTransactionResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetTransactionsResponse clone() => BatchGetTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetTransactionsResponse copyWith(void Function(BatchGetTransactionsResponse) updates) => super.copyWith((message) => updates(message as BatchGetTransactionsResponse)) as BatchGetTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetTransactionsResponse create() => BatchGetTransactionsResponse._();
  @$core.override
  BatchGetTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<BatchGetTransactionsResponse> createRepeated() => $pb.PbList<BatchGetTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchGetTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchGetTransactionsResponse>(create);
  static BatchGetTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GetTransactionResult> get transactions => $_getList(0);
}

enum GetTransactionResult_Result {
  transaction, 
  error, 
  notSet
}

class GetTransactionResult extends $pb.GeneratedMessage {
  factory GetTransactionResult({
    $4.ExecutedTransaction? transaction,
    $3.Status? error,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (error != null) result.error = error;
    return result;
  }

  GetTransactionResult._();

  factory GetTransactionResult.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetTransactionResult.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, GetTransactionResult_Result> _GetTransactionResult_ResultByTag = {
    1 : GetTransactionResult_Result.transaction,
    2 : GetTransactionResult_Result.error,
    0 : GetTransactionResult_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$4.ExecutedTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $4.ExecutedTransaction.create)
    ..aOM<$3.Status>(2, _omitFieldNames ? '' : 'error', subBuilder: $3.Status.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResult clone() => GetTransactionResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResult copyWith(void Function(GetTransactionResult) updates) => super.copyWith((message) => updates(message as GetTransactionResult)) as GetTransactionResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionResult create() => GetTransactionResult._();
  @$core.override
  GetTransactionResult createEmptyInstance() => create();
  static $pb.PbList<GetTransactionResult> createRepeated() => $pb.PbList<GetTransactionResult>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionResult>(create);
  static GetTransactionResult? _defaultInstance;

  GetTransactionResult_Result whichResult() => _GetTransactionResult_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $4.ExecutedTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($4.ExecutedTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.ExecutedTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.Status get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($3.Status value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.Status ensureError() => $_ensure(1);
}

enum GetCheckpointRequest_CheckpointId {
  sequenceNumber, 
  digest, 
  notSet
}

class GetCheckpointRequest extends $pb.GeneratedMessage {
  factory GetCheckpointRequest({
    $fixnum.Int64? sequenceNumber,
    $core.String? digest,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (sequenceNumber != null) result.sequenceNumber = sequenceNumber;
    if (digest != null) result.digest = digest;
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  GetCheckpointRequest._();

  factory GetCheckpointRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetCheckpointRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, GetCheckpointRequest_CheckpointId> _GetCheckpointRequest_CheckpointIdByTag = {
    1 : GetCheckpointRequest_CheckpointId.sequenceNumber,
    2 : GetCheckpointRequest_CheckpointId.digest,
    0 : GetCheckpointRequest_CheckpointId.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCheckpointRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'sequenceNumber', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..aOM<$1.FieldMask>(3, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCheckpointRequest clone() => GetCheckpointRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCheckpointRequest copyWith(void Function(GetCheckpointRequest) updates) => super.copyWith((message) => updates(message as GetCheckpointRequest)) as GetCheckpointRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCheckpointRequest create() => GetCheckpointRequest._();
  @$core.override
  GetCheckpointRequest createEmptyInstance() => create();
  static $pb.PbList<GetCheckpointRequest> createRepeated() => $pb.PbList<GetCheckpointRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCheckpointRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCheckpointRequest>(create);
  static GetCheckpointRequest? _defaultInstance;

  GetCheckpointRequest_CheckpointId whichCheckpointId() => _GetCheckpointRequest_CheckpointIdByTag[$_whichOneof(0)]!;
  void clearCheckpointId() => $_clearField($_whichOneof(0));

  /// The sequence number of the requested checkpoint.
  @$pb.TagNumber(1)
  $fixnum.Int64 get sequenceNumber => $_getI64(0);
  @$pb.TagNumber(1)
  set sequenceNumber($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSequenceNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceNumber() => $_clearField(1);

  /// The digest of the requested checkpoint.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `sequence_number,digest`.
  @$pb.TagNumber(3)
  $1.FieldMask get readMask => $_getN(2);
  @$pb.TagNumber(3)
  set readMask($1.FieldMask value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReadMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearReadMask() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.FieldMask ensureReadMask() => $_ensure(2);
}

class GetCheckpointResponse extends $pb.GeneratedMessage {
  factory GetCheckpointResponse({
    $5.Checkpoint? checkpoint,
  }) {
    final result = create();
    if (checkpoint != null) result.checkpoint = checkpoint;
    return result;
  }

  GetCheckpointResponse._();

  factory GetCheckpointResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetCheckpointResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCheckpointResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$5.Checkpoint>(1, _omitFieldNames ? '' : 'checkpoint', subBuilder: $5.Checkpoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCheckpointResponse clone() => GetCheckpointResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCheckpointResponse copyWith(void Function(GetCheckpointResponse) updates) => super.copyWith((message) => updates(message as GetCheckpointResponse)) as GetCheckpointResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCheckpointResponse create() => GetCheckpointResponse._();
  @$core.override
  GetCheckpointResponse createEmptyInstance() => create();
  static $pb.PbList<GetCheckpointResponse> createRepeated() => $pb.PbList<GetCheckpointResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCheckpointResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCheckpointResponse>(create);
  static GetCheckpointResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $5.Checkpoint get checkpoint => $_getN(0);
  @$pb.TagNumber(1)
  set checkpoint($5.Checkpoint value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCheckpoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearCheckpoint() => $_clearField(1);
  @$pb.TagNumber(1)
  $5.Checkpoint ensureCheckpoint() => $_ensure(0);
}

class GetEpochRequest extends $pb.GeneratedMessage {
  factory GetEpochRequest({
    $fixnum.Int64? epoch,
    $1.FieldMask? readMask,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  GetEpochRequest._();

  factory GetEpochRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEpochRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEpochRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.FieldMask>(2, _omitFieldNames ? '' : 'readMask', subBuilder: $1.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpochRequest clone() => GetEpochRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpochRequest copyWith(void Function(GetEpochRequest) updates) => super.copyWith((message) => updates(message as GetEpochRequest)) as GetEpochRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpochRequest create() => GetEpochRequest._();
  @$core.override
  GetEpochRequest createEmptyInstance() => create();
  static $pb.PbList<GetEpochRequest> createRepeated() => $pb.PbList<GetEpochRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEpochRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEpochRequest>(create);
  static GetEpochRequest? _defaultInstance;

  /// The requested epoch.
  /// If no epoch is provided the current epoch will be returned.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `epoch`.
  @$pb.TagNumber(2)
  $1.FieldMask get readMask => $_getN(1);
  @$pb.TagNumber(2)
  set readMask($1.FieldMask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReadMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.FieldMask ensureReadMask() => $_ensure(1);
}

class GetEpochResponse extends $pb.GeneratedMessage {
  factory GetEpochResponse({
    $6.Epoch? epoch,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    return result;
  }

  GetEpochResponse._();

  factory GetEpochResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEpochResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEpochResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$6.Epoch>(1, _omitFieldNames ? '' : 'epoch', subBuilder: $6.Epoch.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpochResponse clone() => GetEpochResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpochResponse copyWith(void Function(GetEpochResponse) updates) => super.copyWith((message) => updates(message as GetEpochResponse)) as GetEpochResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpochResponse create() => GetEpochResponse._();
  @$core.override
  GetEpochResponse createEmptyInstance() => create();
  static $pb.PbList<GetEpochResponse> createRepeated() => $pb.PbList<GetEpochResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEpochResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEpochResponse>(create);
  static GetEpochResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $6.Epoch get epoch => $_getN(0);
  @$pb.TagNumber(1)
  set epoch($6.Epoch value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);
  @$pb.TagNumber(1)
  $6.Epoch ensureEpoch() => $_ensure(0);
}

class LedgerServiceApi {
  final $pb.RpcClient _client;

  LedgerServiceApi(this._client);

  /// Query the service for general information about its current state.
  $async.Future<GetServiceInfoResponse> getServiceInfo($pb.ClientContext? ctx, GetServiceInfoRequest request) =>
    _client.invoke<GetServiceInfoResponse>(ctx, 'LedgerService', 'GetServiceInfo', request, GetServiceInfoResponse())
  ;
  $async.Future<GetObjectResponse> getObject($pb.ClientContext? ctx, GetObjectRequest request) =>
    _client.invoke<GetObjectResponse>(ctx, 'LedgerService', 'GetObject', request, GetObjectResponse())
  ;
  $async.Future<BatchGetObjectsResponse> batchGetObjects($pb.ClientContext? ctx, BatchGetObjectsRequest request) =>
    _client.invoke<BatchGetObjectsResponse>(ctx, 'LedgerService', 'BatchGetObjects', request, BatchGetObjectsResponse())
  ;
  $async.Future<GetTransactionResponse> getTransaction($pb.ClientContext? ctx, GetTransactionRequest request) =>
    _client.invoke<GetTransactionResponse>(ctx, 'LedgerService', 'GetTransaction', request, GetTransactionResponse())
  ;
  $async.Future<BatchGetTransactionsResponse> batchGetTransactions($pb.ClientContext? ctx, BatchGetTransactionsRequest request) =>
    _client.invoke<BatchGetTransactionsResponse>(ctx, 'LedgerService', 'BatchGetTransactions', request, BatchGetTransactionsResponse())
  ;
  $async.Future<GetCheckpointResponse> getCheckpoint($pb.ClientContext? ctx, GetCheckpointRequest request) =>
    _client.invoke<GetCheckpointResponse>(ctx, 'LedgerService', 'GetCheckpoint', request, GetCheckpointResponse())
  ;
  $async.Future<GetEpochResponse> getEpoch($pb.ClientContext? ctx, GetEpochRequest request) =>
    _client.invoke<GetEpochResponse>(ctx, 'LedgerService', 'GetEpoch', request, GetEpochResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
