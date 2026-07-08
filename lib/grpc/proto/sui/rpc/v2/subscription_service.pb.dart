// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/subscription_service.proto.

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

import '../../../google/protobuf/field_mask.pb.dart' as $0;
import 'checkpoint.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for SubscriptionService.SubscribeCheckpoints
class SubscribeCheckpointsRequest extends $pb.GeneratedMessage {
  factory SubscribeCheckpointsRequest({
    $0.FieldMask? readMask,
  }) {
    final result = create();
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  SubscribeCheckpointsRequest._();

  factory SubscribeCheckpointsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SubscribeCheckpointsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeCheckpointsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.FieldMask>(1, _omitFieldNames ? '' : 'readMask', subBuilder: $0.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsRequest clone() => SubscribeCheckpointsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsRequest copyWith(void Function(SubscribeCheckpointsRequest) updates) => super.copyWith((message) => updates(message as SubscribeCheckpointsRequest)) as SubscribeCheckpointsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsRequest create() => SubscribeCheckpointsRequest._();
  @$core.override
  SubscribeCheckpointsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeCheckpointsRequest> createRepeated() => $pb.PbList<SubscribeCheckpointsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeCheckpointsRequest>(create);
  static SubscribeCheckpointsRequest? _defaultInstance;

  /// Optional. Mask for specifying which parts of the
  /// SubscribeCheckpointsResponse should be returned.
  @$pb.TagNumber(1)
  $0.FieldMask get readMask => $_getN(0);
  @$pb.TagNumber(1)
  set readMask($0.FieldMask value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReadMask() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadMask() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.FieldMask ensureReadMask() => $_ensure(0);
}

/// Response message for SubscriptionService.SubscribeCheckpoints
class SubscribeCheckpointsResponse extends $pb.GeneratedMessage {
  factory SubscribeCheckpointsResponse({
    $fixnum.Int64? cursor,
    $1.Checkpoint? checkpoint,
  }) {
    final result = create();
    if (cursor != null) result.cursor = cursor;
    if (checkpoint != null) result.checkpoint = checkpoint;
    return result;
  }

  SubscribeCheckpointsResponse._();

  factory SubscribeCheckpointsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SubscribeCheckpointsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeCheckpointsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cursor', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$1.Checkpoint>(2, _omitFieldNames ? '' : 'checkpoint', subBuilder: $1.Checkpoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsResponse clone() => SubscribeCheckpointsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsResponse copyWith(void Function(SubscribeCheckpointsResponse) updates) => super.copyWith((message) => updates(message as SubscribeCheckpointsResponse)) as SubscribeCheckpointsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsResponse create() => SubscribeCheckpointsResponse._();
  @$core.override
  SubscribeCheckpointsResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeCheckpointsResponse> createRepeated() => $pb.PbList<SubscribeCheckpointsResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeCheckpointsResponse>(create);
  static SubscribeCheckpointsResponse? _defaultInstance;

  /// Required. The checkpoint sequence number and value of the current cursor
  /// into the checkpoint stream
  @$pb.TagNumber(1)
  $fixnum.Int64 get cursor => $_getI64(0);
  @$pb.TagNumber(1)
  set cursor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCursor() => $_has(0);
  @$pb.TagNumber(1)
  void clearCursor() => $_clearField(1);

  /// The requested data for this checkpoint
  @$pb.TagNumber(2)
  $1.Checkpoint get checkpoint => $_getN(1);
  @$pb.TagNumber(2)
  set checkpoint($1.Checkpoint value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCheckpoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearCheckpoint() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Checkpoint ensureCheckpoint() => $_ensure(1);
}

class SubscriptionServiceApi {
  final $pb.RpcClient _client;

  SubscriptionServiceApi(this._client);

  /// Subscribe to the stream of checkpoints.
  ///
  /// This API provides a subscription to the checkpoint stream for the Sui
  /// blockchain. When a subscription is initialized the stream will begin with
  /// the latest executed checkpoint as seen by the server. Responses are
  /// guaranteed to return checkpoints in-order and without gaps. This enables
  /// clients to know exactly the last checkpoint they have processed and in the
  /// event the subscription terminates (either by the client/server or by the
  /// connection breaking), clients will be able to reinitialize a subscription
  /// and then leverage other APIs in order to request data for the checkpoints
  /// they missed.
  $async.Future<SubscribeCheckpointsResponse> subscribeCheckpoints($pb.ClientContext? ctx, SubscribeCheckpointsRequest request) =>
    _client.invoke<SubscribeCheckpointsResponse>(ctx, 'SubscriptionService', 'SubscribeCheckpoints', request, SubscribeCheckpointsResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
