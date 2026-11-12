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
import 'checkpoint.pb.dart' as $2;
import 'event.pb.dart' as $5;
import 'executed_transaction.pb.dart' as $3;
import 'filter.pb.dart' as $1;
import 'query_options.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for SubscriptionService.SubscribeCheckpoints.
class SubscribeCheckpointsRequest extends $pb.GeneratedMessage {
  factory SubscribeCheckpointsRequest({
    $0.FieldMask? readMask,
    $1.TransactionFilter? filter,
  }) {
    final result = create();
    if (readMask != null) result.readMask = readMask;
    if (filter != null) result.filter = filter;
    return result;
  }

  SubscribeCheckpointsRequest._();

  factory SubscribeCheckpointsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeCheckpointsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeCheckpointsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.FieldMask>(1, _omitFieldNames ? '' : 'readMask',
        subBuilder: $0.FieldMask.create)
    ..aOM<$1.TransactionFilter>(2, _omitFieldNames ? '' : 'filter',
        subBuilder: $1.TransactionFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsRequest clone() =>
      SubscribeCheckpointsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsRequest copyWith(
          void Function(SubscribeCheckpointsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SubscribeCheckpointsRequest))
          as SubscribeCheckpointsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsRequest create() =>
      SubscribeCheckpointsRequest._();
  @$core.override
  SubscribeCheckpointsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeCheckpointsRequest> createRepeated() =>
      $pb.PbList<SubscribeCheckpointsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeCheckpointsRequest>(create);
  static SubscribeCheckpointsRequest? _defaultInstance;

  /// Optional. Mask for specifying which parts of the Checkpoint should be
  /// returned (e.g. summary, contents, signatures). `cursor` is always
  /// populated and is not subject to the mask.
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

  /// Optional. DNF filter over indexed transaction dimensions. A checkpoint
  /// matches if any transaction it contains satisfies the filter. If absent,
  /// every checkpoint is streamed.
  @$pb.TagNumber(2)
  $1.TransactionFilter get filter => $_getN(1);
  @$pb.TagNumber(2)
  set filter($1.TransactionFilter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.TransactionFilter ensureFilter() => $_ensure(1);
}

/// Response message for SubscriptionService.SubscribeCheckpoints.
///
/// A checkpoint stream's position is checkpoint-granular, so the `cursor`
/// sequence number stands in for the `Watermark` message the other
/// subscription responses carry. Progress-only frames (with `checkpoint`
/// unset) occur only on filtered streams: on an unfiltered stream every frame
/// carries both fields, in order and without gaps.
class SubscribeCheckpointsResponse extends $pb.GeneratedMessage {
  factory SubscribeCheckpointsResponse({
    $fixnum.Int64? cursor,
    $2.Checkpoint? checkpoint,
  }) {
    final result = create();
    if (cursor != null) result.cursor = cursor;
    if (checkpoint != null) result.checkpoint = checkpoint;
    return result;
  }

  SubscribeCheckpointsResponse._();

  factory SubscribeCheckpointsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeCheckpointsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeCheckpointsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'cursor', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Checkpoint>(2, _omitFieldNames ? '' : 'checkpoint',
        subBuilder: $2.Checkpoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsResponse clone() =>
      SubscribeCheckpointsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeCheckpointsResponse copyWith(
          void Function(SubscribeCheckpointsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubscribeCheckpointsResponse))
          as SubscribeCheckpointsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsResponse create() =>
      SubscribeCheckpointsResponse._();
  @$core.override
  SubscribeCheckpointsResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeCheckpointsResponse> createRepeated() =>
      $pb.PbList<SubscribeCheckpointsResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeCheckpointsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeCheckpointsResponse>(create);
  static SubscribeCheckpointsResponse? _defaultInstance;

  /// Required. The checkpoint sequence number the stream has fully covered,
  /// inclusive: every matching checkpoint from the stream's start position
  /// through `cursor` has been delivered. Present on every frame and
  /// advances monotonically.
  @$pb.TagNumber(1)
  $fixnum.Int64 get cursor => $_getI64(0);
  @$pb.TagNumber(1)
  set cursor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCursor() => $_has(0);
  @$pb.TagNumber(1)
  void clearCursor() => $_clearField(1);

  /// The matching checkpoint. Unset when this frame only advances the
  /// cursor past non-matching checkpoints.
  @$pb.TagNumber(2)
  $2.Checkpoint get checkpoint => $_getN(1);
  @$pb.TagNumber(2)
  set checkpoint($2.Checkpoint value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCheckpoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearCheckpoint() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Checkpoint ensureCheckpoint() => $_ensure(1);
}

/// Request message for SubscriptionService.SubscribeTransactions.
class SubscribeTransactionsRequest extends $pb.GeneratedMessage {
  factory SubscribeTransactionsRequest({
    $0.FieldMask? readMask,
    $1.TransactionFilter? filter,
  }) {
    final result = create();
    if (readMask != null) result.readMask = readMask;
    if (filter != null) result.filter = filter;
    return result;
  }

  SubscribeTransactionsRequest._();

  factory SubscribeTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.FieldMask>(1, _omitFieldNames ? '' : 'readMask',
        subBuilder: $0.FieldMask.create)
    ..aOM<$1.TransactionFilter>(2, _omitFieldNames ? '' : 'filter',
        subBuilder: $1.TransactionFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeTransactionsRequest clone() =>
      SubscribeTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeTransactionsRequest copyWith(
          void Function(SubscribeTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SubscribeTransactionsRequest))
          as SubscribeTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeTransactionsRequest create() =>
      SubscribeTransactionsRequest._();
  @$core.override
  SubscribeTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeTransactionsRequest> createRepeated() =>
      $pb.PbList<SubscribeTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeTransactionsRequest>(create);
  static SubscribeTransactionsRequest? _defaultInstance;

  /// Optional. Mask for specifying which parts of the ExecutedTransaction
  /// should be returned.
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

  /// Optional. DNF filter over indexed dimensions. If absent, every
  /// transaction is streamed.
  @$pb.TagNumber(2)
  $1.TransactionFilter get filter => $_getN(1);
  @$pb.TagNumber(2)
  set filter($1.TransactionFilter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.TransactionFilter ensureFilter() => $_ensure(1);
}

/// Response message for SubscriptionService.SubscribeTransactions.
///
/// Mirrors ListTransactionsResponse, except there is no `end` field: a
/// subscription stream has no successful end.
class SubscribeTransactionsResponse extends $pb.GeneratedMessage {
  factory SubscribeTransactionsResponse({
    $3.ExecutedTransaction? transaction,
    $4.Watermark? watermark,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (watermark != null) result.watermark = watermark;
    return result;
  }

  SubscribeTransactionsResponse._();

  factory SubscribeTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$3.ExecutedTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: $3.ExecutedTransaction.create)
    ..aOM<$4.Watermark>(2, _omitFieldNames ? '' : 'watermark',
        subBuilder: $4.Watermark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeTransactionsResponse clone() =>
      SubscribeTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeTransactionsResponse copyWith(
          void Function(SubscribeTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubscribeTransactionsResponse))
          as SubscribeTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeTransactionsResponse create() =>
      SubscribeTransactionsResponse._();
  @$core.override
  SubscribeTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeTransactionsResponse> createRepeated() =>
      $pb.PbList<SubscribeTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeTransactionsResponse>(create);
  static SubscribeTransactionsResponse? _defaultInstance;

  /// One matching transaction. Its position within the containing checkpoint
  /// is reported by `ExecutedTransaction.transaction_index`.
  @$pb.TagNumber(1)
  $3.ExecutedTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($3.ExecutedTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.ExecutedTransaction ensureTransaction() => $_ensure(0);

  /// Progress watermark as of this frame. Present on every frame.
  @$pb.TagNumber(2)
  $4.Watermark get watermark => $_getN(1);
  @$pb.TagNumber(2)
  set watermark($4.Watermark value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasWatermark() => $_has(1);
  @$pb.TagNumber(2)
  void clearWatermark() => $_clearField(2);
  @$pb.TagNumber(2)
  $4.Watermark ensureWatermark() => $_ensure(1);
}

/// Request message for SubscriptionService.SubscribeEvents.
class SubscribeEventsRequest extends $pb.GeneratedMessage {
  factory SubscribeEventsRequest({
    $0.FieldMask? readMask,
    $1.EventFilter? filter,
  }) {
    final result = create();
    if (readMask != null) result.readMask = readMask;
    if (filter != null) result.filter = filter;
    return result;
  }

  SubscribeEventsRequest._();

  factory SubscribeEventsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeEventsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeEventsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.FieldMask>(1, _omitFieldNames ? '' : 'readMask',
        subBuilder: $0.FieldMask.create)
    ..aOM<$1.EventFilter>(2, _omitFieldNames ? '' : 'filter',
        subBuilder: $1.EventFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeEventsRequest clone() =>
      SubscribeEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeEventsRequest copyWith(
          void Function(SubscribeEventsRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeEventsRequest))
          as SubscribeEventsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeEventsRequest create() => SubscribeEventsRequest._();
  @$core.override
  SubscribeEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeEventsRequest> createRepeated() =>
      $pb.PbList<SubscribeEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeEventsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeEventsRequest>(create);
  static SubscribeEventsRequest? _defaultInstance;

  /// Optional. Mask for specifying which parts of the Event should be
  /// returned.
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

  /// Optional. DNF filter over indexed dimensions. If absent, every event is
  /// streamed.
  @$pb.TagNumber(2)
  $1.EventFilter get filter => $_getN(1);
  @$pb.TagNumber(2)
  set filter($1.EventFilter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.EventFilter ensureFilter() => $_ensure(1);
}

/// Response message for SubscriptionService.SubscribeEvents.
///
/// Mirrors ListEventsResponse, except there is no `end` field: a subscription
/// stream has no successful end.
class SubscribeEventsResponse extends $pb.GeneratedMessage {
  factory SubscribeEventsResponse({
    $5.Event? event,
    $4.Watermark? watermark,
  }) {
    final result = create();
    if (event != null) result.event = event;
    if (watermark != null) result.watermark = watermark;
    return result;
  }

  SubscribeEventsResponse._();

  factory SubscribeEventsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeEventsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeEventsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$5.Event>(1, _omitFieldNames ? '' : 'event',
        subBuilder: $5.Event.create)
    ..aOM<$4.Watermark>(2, _omitFieldNames ? '' : 'watermark',
        subBuilder: $4.Watermark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeEventsResponse clone() =>
      SubscribeEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeEventsResponse copyWith(
          void Function(SubscribeEventsResponse) updates) =>
      super.copyWith((message) => updates(message as SubscribeEventsResponse))
          as SubscribeEventsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeEventsResponse create() => SubscribeEventsResponse._();
  @$core.override
  SubscribeEventsResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeEventsResponse> createRepeated() =>
      $pb.PbList<SubscribeEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeEventsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeEventsResponse>(create);
  static SubscribeEventsResponse? _defaultInstance;

  /// One matching event. Its ledger position -- containing checkpoint,
  /// emitting transaction digest and offset, and index within that
  /// transaction's event list -- is reported by the corresponding fields on
  /// `Event`.
  @$pb.TagNumber(1)
  $5.Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event($5.Event value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  $5.Event ensureEvent() => $_ensure(0);

  /// Progress watermark as of this frame. Present on every frame.
  @$pb.TagNumber(2)
  $4.Watermark get watermark => $_getN(1);
  @$pb.TagNumber(2)
  set watermark($4.Watermark value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasWatermark() => $_has(1);
  @$pb.TagNumber(2)
  void clearWatermark() => $_clearField(2);
  @$pb.TagNumber(2)
  $4.Watermark ensureWatermark() => $_ensure(1);
}

/// SubscriptionService provides filtered, real-time streams of checkpoints,
/// transactions, and events.
///
/// Each Subscribe API pairs with the LedgerService List API of the same name:
/// requests take the same filter message, and responses carry the same item
/// and watermark shapes with identical cursor semantics.
///
/// Subscriptions do not support resumption. A new subscription always begins
/// at the current tip of the chain as seen by the server (the latest executed
/// checkpoint). To recover data missed between subscriptions, replay the gap
/// with the paired List API: pass the last received `Watermark.cursor` as
/// `options.after` on the List request (for checkpoints, pass the last
/// received `cursor + 1` as `start_checkpoint`). The List scan reads from the
/// indexed tip, which may trail the subscription's start position; repeat the
/// List call as the index advances until the replay reaches the position
/// established by the subscription's first frame.
///
/// A subscription behaves like an unbounded ascending scan: every frame
/// carries the subscriber's resume point, and progress advances as
/// checkpoints are fully covered. Two delivery guarantees keep sparse
/// filters live: the first frame on a filtered subscription is a
/// progress-only frame establishing the stream's start position, and
/// progress continues to advance with bounded staleness even when no item
/// matches.
///
/// Subscription streams have no successful end: they run until cancelled by
/// the client or terminated by the server with a gRPC status.
class SubscriptionServiceApi {
  final $pb.RpcClient _client;

  SubscriptionServiceApi(this._client);

  /// Subscribe to the stream of checkpoints.
  ///
  /// The stream begins at the latest executed checkpoint as seen by the
  /// server and yields checkpoints matching the filter as they are executed.
  /// A checkpoint matches if any transaction it contains satisfies the
  /// filter.
  $async.Future<SubscribeCheckpointsResponse> subscribeCheckpoints(
          $pb.ClientContext? ctx, SubscribeCheckpointsRequest request) =>
      _client.invoke<SubscribeCheckpointsResponse>(ctx, 'SubscriptionService',
          'SubscribeCheckpoints', request, SubscribeCheckpointsResponse());

  /// Subscribe to the stream of transactions.
  ///
  /// The stream begins at the latest executed checkpoint as seen by the
  /// server and yields transactions matching the filter as they are executed.
  $async.Future<SubscribeTransactionsResponse> subscribeTransactions(
          $pb.ClientContext? ctx, SubscribeTransactionsRequest request) =>
      _client.invoke<SubscribeTransactionsResponse>(ctx, 'SubscriptionService',
          'SubscribeTransactions', request, SubscribeTransactionsResponse());

  /// Subscribe to the stream of events.
  ///
  /// The stream begins at the latest executed checkpoint as seen by the
  /// server and yields events matching the filter as they are emitted.
  $async.Future<SubscribeEventsResponse> subscribeEvents(
          $pb.ClientContext? ctx, SubscribeEventsRequest request) =>
      _client.invoke<SubscribeEventsResponse>(ctx, 'SubscriptionService',
          'SubscribeEvents', request, SubscribeEventsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
