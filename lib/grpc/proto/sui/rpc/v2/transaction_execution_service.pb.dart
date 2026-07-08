// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction_execution_service.proto.

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

import '../../../google/protobuf/field_mask.pb.dart' as $2;
import '../../../google/protobuf/struct.pb.dart' as $6;
import 'argument.pb.dart' as $4;
import 'bcs.pb.dart' as $5;
import 'executed_transaction.pb.dart' as $3;
import 'signature.pb.dart' as $1;
import 'transaction.pb.dart' as $0;
import 'transaction_execution_service.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'transaction_execution_service.pbenum.dart';

class ExecuteTransactionRequest extends $pb.GeneratedMessage {
  factory ExecuteTransactionRequest({
    $0.Transaction? transaction,
    $core.Iterable<$1.UserSignature>? signatures,
    $2.FieldMask? readMask,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (signatures != null) result.signatures.addAll(signatures);
    if (readMask != null) result.readMask = readMask;
    return result;
  }

  ExecuteTransactionRequest._();

  factory ExecuteTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ExecuteTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExecuteTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Transaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $0.Transaction.create)
    ..pc<$1.UserSignature>(2, _omitFieldNames ? '' : 'signatures', $pb.PbFieldType.PM, subBuilder: $1.UserSignature.create)
    ..aOM<$2.FieldMask>(3, _omitFieldNames ? '' : 'readMask', subBuilder: $2.FieldMask.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteTransactionRequest clone() => ExecuteTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteTransactionRequest copyWith(void Function(ExecuteTransactionRequest) updates) => super.copyWith((message) => updates(message as ExecuteTransactionRequest)) as ExecuteTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecuteTransactionRequest create() => ExecuteTransactionRequest._();
  @$core.override
  ExecuteTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<ExecuteTransactionRequest> createRepeated() => $pb.PbList<ExecuteTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static ExecuteTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecuteTransactionRequest>(create);
  static ExecuteTransactionRequest? _defaultInstance;

  /// The transaction to execute.
  @$pb.TagNumber(1)
  $0.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($0.Transaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Transaction ensureTransaction() => $_ensure(0);

  /// Set of `UserSignature`s authorizing the execution of the provided
  /// transaction.
  @$pb.TagNumber(2)
  $pb.PbList<$1.UserSignature> get signatures => $_getList(1);

  /// Mask specifying which fields to read.
  /// If no mask is specified, defaults to `effects.status,checkpoint`.
  @$pb.TagNumber(3)
  $2.FieldMask get readMask => $_getN(2);
  @$pb.TagNumber(3)
  set readMask($2.FieldMask value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReadMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearReadMask() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.FieldMask ensureReadMask() => $_ensure(2);
}

/// Response message for `NodeService.ExecuteTransaction`.
class ExecuteTransactionResponse extends $pb.GeneratedMessage {
  factory ExecuteTransactionResponse({
    $3.ExecutedTransaction? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  ExecuteTransactionResponse._();

  factory ExecuteTransactionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ExecuteTransactionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExecuteTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$3.ExecutedTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $3.ExecutedTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteTransactionResponse clone() => ExecuteTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecuteTransactionResponse copyWith(void Function(ExecuteTransactionResponse) updates) => super.copyWith((message) => updates(message as ExecuteTransactionResponse)) as ExecuteTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecuteTransactionResponse create() => ExecuteTransactionResponse._();
  @$core.override
  ExecuteTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<ExecuteTransactionResponse> createRepeated() => $pb.PbList<ExecuteTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static ExecuteTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecuteTransactionResponse>(create);
  static ExecuteTransactionResponse? _defaultInstance;

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
}

class SimulateTransactionRequest extends $pb.GeneratedMessage {
  factory SimulateTransactionRequest({
    $0.Transaction? transaction,
    $2.FieldMask? readMask,
    SimulateTransactionRequest_TransactionChecks? checks,
    $core.bool? doGasSelection,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (readMask != null) result.readMask = readMask;
    if (checks != null) result.checks = checks;
    if (doGasSelection != null) result.doGasSelection = doGasSelection;
    return result;
  }

  SimulateTransactionRequest._();

  factory SimulateTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SimulateTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SimulateTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Transaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $0.Transaction.create)
    ..aOM<$2.FieldMask>(2, _omitFieldNames ? '' : 'readMask', subBuilder: $2.FieldMask.create)
    ..e<SimulateTransactionRequest_TransactionChecks>(3, _omitFieldNames ? '' : 'checks', $pb.PbFieldType.OE, defaultOrMaker: SimulateTransactionRequest_TransactionChecks.ENABLED, valueOf: SimulateTransactionRequest_TransactionChecks.valueOf, enumValues: SimulateTransactionRequest_TransactionChecks.values)
    ..aOB(4, _omitFieldNames ? '' : 'doGasSelection')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTransactionRequest clone() => SimulateTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTransactionRequest copyWith(void Function(SimulateTransactionRequest) updates) => super.copyWith((message) => updates(message as SimulateTransactionRequest)) as SimulateTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimulateTransactionRequest create() => SimulateTransactionRequest._();
  @$core.override
  SimulateTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SimulateTransactionRequest> createRepeated() => $pb.PbList<SimulateTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SimulateTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimulateTransactionRequest>(create);
  static SimulateTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Transaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($0.Transaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Transaction ensureTransaction() => $_ensure(0);

  /// Mask specifying which fields to read.
  @$pb.TagNumber(2)
  $2.FieldMask get readMask => $_getN(1);
  @$pb.TagNumber(2)
  set readMask($2.FieldMask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReadMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.FieldMask ensureReadMask() => $_ensure(1);

  /// Specify whether checks should be ENABLED (default) or DISABLED while executing the transaction
  @$pb.TagNumber(3)
  SimulateTransactionRequest_TransactionChecks get checks => $_getN(2);
  @$pb.TagNumber(3)
  set checks(SimulateTransactionRequest_TransactionChecks value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasChecks() => $_has(2);
  @$pb.TagNumber(3)
  void clearChecks() => $_clearField(3);

  /// Perform gas selection based on a budget estimation and include the
  /// selected gas payment and budget in the response.
  ///
  /// This option will be ignored if `checks` is `DISABLED`.
  @$pb.TagNumber(4)
  $core.bool get doGasSelection => $_getBF(3);
  @$pb.TagNumber(4)
  set doGasSelection($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDoGasSelection() => $_has(3);
  @$pb.TagNumber(4)
  void clearDoGasSelection() => $_clearField(4);
}

class SimulateTransactionResponse extends $pb.GeneratedMessage {
  factory SimulateTransactionResponse({
    $3.ExecutedTransaction? transaction,
    $core.Iterable<CommandResult>? commandOutputs,
    $fixnum.Int64? suggestedGasPrice,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (commandOutputs != null) result.commandOutputs.addAll(commandOutputs);
    if (suggestedGasPrice != null) result.suggestedGasPrice = suggestedGasPrice;
    return result;
  }

  SimulateTransactionResponse._();

  factory SimulateTransactionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SimulateTransactionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SimulateTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$3.ExecutedTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: $3.ExecutedTransaction.create)
    ..pc<CommandResult>(2, _omitFieldNames ? '' : 'commandOutputs', $pb.PbFieldType.PM, subBuilder: CommandResult.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'suggestedGasPrice', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTransactionResponse clone() => SimulateTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimulateTransactionResponse copyWith(void Function(SimulateTransactionResponse) updates) => super.copyWith((message) => updates(message as SimulateTransactionResponse)) as SimulateTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimulateTransactionResponse create() => SimulateTransactionResponse._();
  @$core.override
  SimulateTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SimulateTransactionResponse> createRepeated() => $pb.PbList<SimulateTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SimulateTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimulateTransactionResponse>(create);
  static SimulateTransactionResponse? _defaultInstance;

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

  @$pb.TagNumber(2)
  $pb.PbList<CommandResult> get commandOutputs => $_getList(1);

  /// A suggested gas price to use, that is above RGP, in order to provide a
  /// better chance of the transaction being included in the presence of
  /// congested objects.
  @$pb.TagNumber(3)
  $fixnum.Int64 get suggestedGasPrice => $_getI64(2);
  @$pb.TagNumber(3)
  set suggestedGasPrice($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuggestedGasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuggestedGasPrice() => $_clearField(3);
}

/// An intermediate result/output from the execution of a single command
class CommandResult extends $pb.GeneratedMessage {
  factory CommandResult({
    $core.Iterable<CommandOutput>? returnValues,
    $core.Iterable<CommandOutput>? mutatedByRef,
  }) {
    final result = create();
    if (returnValues != null) result.returnValues.addAll(returnValues);
    if (mutatedByRef != null) result.mutatedByRef.addAll(mutatedByRef);
    return result;
  }

  CommandResult._();

  factory CommandResult.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CommandResult.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommandResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<CommandOutput>(1, _omitFieldNames ? '' : 'returnValues', $pb.PbFieldType.PM, subBuilder: CommandOutput.create)
    ..pc<CommandOutput>(2, _omitFieldNames ? '' : 'mutatedByRef', $pb.PbFieldType.PM, subBuilder: CommandOutput.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandResult clone() => CommandResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandResult copyWith(void Function(CommandResult) updates) => super.copyWith((message) => updates(message as CommandResult)) as CommandResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandResult create() => CommandResult._();
  @$core.override
  CommandResult createEmptyInstance() => create();
  static $pb.PbList<CommandResult> createRepeated() => $pb.PbList<CommandResult>();
  @$core.pragma('dart2js:noInline')
  static CommandResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandResult>(create);
  static CommandResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CommandOutput> get returnValues => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<CommandOutput> get mutatedByRef => $_getList(1);
}

class CommandOutput extends $pb.GeneratedMessage {
  factory CommandOutput({
    $4.Argument? argument,
    $5.Bcs? value,
    $6.Value? json,
  }) {
    final result = create();
    if (argument != null) result.argument = argument;
    if (value != null) result.value = value;
    if (json != null) result.json = json;
    return result;
  }

  CommandOutput._();

  factory CommandOutput.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CommandOutput.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommandOutput', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$4.Argument>(1, _omitFieldNames ? '' : 'argument', subBuilder: $4.Argument.create)
    ..aOM<$5.Bcs>(2, _omitFieldNames ? '' : 'value', subBuilder: $5.Bcs.create)
    ..aOM<$6.Value>(3, _omitFieldNames ? '' : 'json', subBuilder: $6.Value.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandOutput clone() => CommandOutput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandOutput copyWith(void Function(CommandOutput) updates) => super.copyWith((message) => updates(message as CommandOutput)) as CommandOutput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandOutput create() => CommandOutput._();
  @$core.override
  CommandOutput createEmptyInstance() => create();
  static $pb.PbList<CommandOutput> createRepeated() => $pb.PbList<CommandOutput>();
  @$core.pragma('dart2js:noInline')
  static CommandOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandOutput>(create);
  static CommandOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $4.Argument get argument => $_getN(0);
  @$pb.TagNumber(1)
  set argument($4.Argument value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasArgument() => $_has(0);
  @$pb.TagNumber(1)
  void clearArgument() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Argument ensureArgument() => $_ensure(0);

  @$pb.TagNumber(2)
  $5.Bcs get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($5.Bcs value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
  @$pb.TagNumber(2)
  $5.Bcs ensureValue() => $_ensure(1);

  /// JSON rendering of the output.
  @$pb.TagNumber(3)
  $6.Value get json => $_getN(2);
  @$pb.TagNumber(3)
  set json($6.Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasJson() => $_has(2);
  @$pb.TagNumber(3)
  void clearJson() => $_clearField(3);
  @$pb.TagNumber(3)
  $6.Value ensureJson() => $_ensure(2);
}

class TransactionExecutionServiceApi {
  final $pb.RpcClient _client;

  TransactionExecutionServiceApi(this._client);

  $async.Future<ExecuteTransactionResponse> executeTransaction($pb.ClientContext? ctx, ExecuteTransactionRequest request) =>
    _client.invoke<ExecuteTransactionResponse>(ctx, 'TransactionExecutionService', 'ExecuteTransaction', request, ExecuteTransactionResponse())
  ;
  $async.Future<SimulateTransactionResponse> simulateTransaction($pb.ClientContext? ctx, SimulateTransactionRequest request) =>
    _client.invoke<SimulateTransactionResponse>(ctx, 'TransactionExecutionService', 'SimulateTransaction', request, SimulateTransactionResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
