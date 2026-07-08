// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/executed_transaction.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/timestamp.pb.dart' as $4;
import 'balance_change.pb.dart' as $5;
import 'effects.pb.dart' as $2;
import 'event.pb.dart' as $3;
import 'object.pb.dart' as $6;
import 'signature.pb.dart' as $1;
import 'transaction.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ExecutedTransaction extends $pb.GeneratedMessage {
  factory ExecutedTransaction({
    $core.String? digest,
    $0.Transaction? transaction,
    $core.Iterable<$1.UserSignature>? signatures,
    $2.TransactionEffects? effects,
    $3.TransactionEvents? events,
    $fixnum.Int64? checkpoint,
    $4.Timestamp? timestamp,
    $core.Iterable<$5.BalanceChange>? balanceChanges,
    $6.ObjectSet? objects,
  }) {
    final result = create();
    if (digest != null) result.digest = digest;
    if (transaction != null) result.transaction = transaction;
    if (signatures != null) result.signatures.addAll(signatures);
    if (effects != null) result.effects = effects;
    if (events != null) result.events = events;
    if (checkpoint != null) result.checkpoint = checkpoint;
    if (timestamp != null) result.timestamp = timestamp;
    if (balanceChanges != null) result.balanceChanges.addAll(balanceChanges);
    if (objects != null) result.objects = objects;
    return result;
  }

  ExecutedTransaction._();

  factory ExecutedTransaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ExecutedTransaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExecutedTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'digest')
    ..aOM<$0.Transaction>(2, _omitFieldNames ? '' : 'transaction', subBuilder: $0.Transaction.create)
    ..pc<$1.UserSignature>(3, _omitFieldNames ? '' : 'signatures', $pb.PbFieldType.PM, subBuilder: $1.UserSignature.create)
    ..aOM<$2.TransactionEffects>(4, _omitFieldNames ? '' : 'effects', subBuilder: $2.TransactionEffects.create)
    ..aOM<$3.TransactionEvents>(5, _omitFieldNames ? '' : 'events', subBuilder: $3.TransactionEvents.create)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'checkpoint', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$4.Timestamp>(7, _omitFieldNames ? '' : 'timestamp', subBuilder: $4.Timestamp.create)
    ..pc<$5.BalanceChange>(8, _omitFieldNames ? '' : 'balanceChanges', $pb.PbFieldType.PM, subBuilder: $5.BalanceChange.create)
    ..aOM<$6.ObjectSet>(9, _omitFieldNames ? '' : 'objects', subBuilder: $6.ObjectSet.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutedTransaction clone() => ExecutedTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutedTransaction copyWith(void Function(ExecutedTransaction) updates) => super.copyWith((message) => updates(message as ExecutedTransaction)) as ExecutedTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutedTransaction create() => ExecutedTransaction._();
  @$core.override
  ExecutedTransaction createEmptyInstance() => create();
  static $pb.PbList<ExecutedTransaction> createRepeated() => $pb.PbList<ExecutedTransaction>();
  @$core.pragma('dart2js:noInline')
  static ExecutedTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecutedTransaction>(create);
  static ExecutedTransaction? _defaultInstance;

  /// The digest of this Transaction.
  @$pb.TagNumber(1)
  $core.String get digest => $_getSZ(0);
  @$pb.TagNumber(1)
  set digest($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDigest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDigest() => $_clearField(1);

  /// The transaction itself.
  @$pb.TagNumber(2)
  $0.Transaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction($0.Transaction value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Transaction ensureTransaction() => $_ensure(1);

  /// List of user signatures that are used to authorize the
  /// execution of this transaction.
  @$pb.TagNumber(3)
  $pb.PbList<$1.UserSignature> get signatures => $_getList(2);

  /// The `TransactionEffects` for this transaction.
  @$pb.TagNumber(4)
  $2.TransactionEffects get effects => $_getN(3);
  @$pb.TagNumber(4)
  set effects($2.TransactionEffects value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEffects() => $_has(3);
  @$pb.TagNumber(4)
  void clearEffects() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.TransactionEffects ensureEffects() => $_ensure(3);

  /// The `TransactionEvents` for this transaction.
  ///
  /// This field might be empty, even if it was explicitly requested, if the
  /// transaction didn't produce any events.
  /// `sui.types.TransactionEffects.events_digest` is populated if the
  /// transaction produced any events.
  @$pb.TagNumber(5)
  $3.TransactionEvents get events => $_getN(4);
  @$pb.TagNumber(5)
  set events($3.TransactionEvents value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasEvents() => $_has(4);
  @$pb.TagNumber(5)
  void clearEvents() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.TransactionEvents ensureEvents() => $_ensure(4);

  /// The sequence number for the checkpoint that includes this transaction.
  @$pb.TagNumber(6)
  $fixnum.Int64 get checkpoint => $_getI64(5);
  @$pb.TagNumber(6)
  set checkpoint($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCheckpoint() => $_has(5);
  @$pb.TagNumber(6)
  void clearCheckpoint() => $_clearField(6);

  /// The Unix timestamp of the checkpoint that includes this transaction.
  @$pb.TagNumber(7)
  $4.Timestamp get timestamp => $_getN(6);
  @$pb.TagNumber(7)
  set timestamp($4.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTimestamp() => $_has(6);
  @$pb.TagNumber(7)
  void clearTimestamp() => $_clearField(7);
  @$pb.TagNumber(7)
  $4.Timestamp ensureTimestamp() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<$5.BalanceChange> get balanceChanges => $_getList(7);

  /// Set of objects either referenced as inputs or produced as
  /// outputs from this Transaction.
  @$pb.TagNumber(9)
  $6.ObjectSet get objects => $_getN(8);
  @$pb.TagNumber(9)
  set objects($6.ObjectSet value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasObjects() => $_has(8);
  @$pb.TagNumber(9)
  void clearObjects() => $_clearField(9);
  @$pb.TagNumber(9)
  $6.ObjectSet ensureObjects() => $_ensure(8);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
