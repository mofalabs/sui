// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/duration.pb.dart' as $7;
import '../../../google/protobuf/timestamp.pb.dart' as $2;
import 'argument.pb.dart' as $4;
import 'bcs.pb.dart' as $0;
import 'input.pb.dart' as $3;
import 'jwk.pb.dart' as $6;
import 'object.pb.dart' as $5;
import 'object_reference.pb.dart' as $1;
import 'transaction.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'transaction.pbenum.dart';

/// A transaction.
class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $0.Bcs? bcs,
    $core.String? digest,
    $core.int? version,
    TransactionKind? kind,
    $core.String? sender,
    GasPayment? gasPayment,
    TransactionExpiration? expiration,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (digest != null) result.digest = digest;
    if (version != null) result.version = version;
    if (kind != null) result.kind = kind;
    if (sender != null) result.sender = sender;
    if (gasPayment != null) result.gasPayment = gasPayment;
    if (expiration != null) result.expiration = expiration;
    return result;
  }

  Transaction._();

  factory Transaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..aOM<TransactionKind>(4, _omitFieldNames ? '' : 'kind',
        subBuilder: TransactionKind.create)
    ..aOS(5, _omitFieldNames ? '' : 'sender')
    ..aOM<GasPayment>(6, _omitFieldNames ? '' : 'gasPayment',
        subBuilder: GasPayment.create)
    ..aOM<TransactionExpiration>(7, _omitFieldNames ? '' : 'expiration',
        subBuilder: TransactionExpiration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction))
          as Transaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  @$core.override
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  /// This Transaction serialized as BCS.
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

  /// The digest of this Transaction.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Version of this Transaction.
  @$pb.TagNumber(3)
  $core.int get version => $_getIZ(2);
  @$pb.TagNumber(3)
  set version($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  TransactionKind get kind => $_getN(3);
  @$pb.TagNumber(4)
  set kind(TransactionKind value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearKind() => $_clearField(4);
  @$pb.TagNumber(4)
  TransactionKind ensureKind() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get sender => $_getSZ(4);
  @$pb.TagNumber(5)
  set sender($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSender() => $_has(4);
  @$pb.TagNumber(5)
  void clearSender() => $_clearField(5);

  @$pb.TagNumber(6)
  GasPayment get gasPayment => $_getN(5);
  @$pb.TagNumber(6)
  set gasPayment(GasPayment value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGasPayment() => $_has(5);
  @$pb.TagNumber(6)
  void clearGasPayment() => $_clearField(6);
  @$pb.TagNumber(6)
  GasPayment ensureGasPayment() => $_ensure(5);

  @$pb.TagNumber(7)
  TransactionExpiration get expiration => $_getN(6);
  @$pb.TagNumber(7)
  set expiration(TransactionExpiration value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasExpiration() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiration() => $_clearField(7);
  @$pb.TagNumber(7)
  TransactionExpiration ensureExpiration() => $_ensure(6);
}

/// Payment information for executing a transaction.
class GasPayment extends $pb.GeneratedMessage {
  factory GasPayment({
    $core.Iterable<$1.ObjectReference>? objects,
    $core.String? owner,
    $fixnum.Int64? price,
    $fixnum.Int64? budget,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    if (owner != null) result.owner = owner;
    if (price != null) result.price = price;
    if (budget != null) result.budget = budget;
    return result;
  }

  GasPayment._();

  factory GasPayment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GasPayment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GasPayment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<$1.ObjectReference>(
        1, _omitFieldNames ? '' : 'objects', $pb.PbFieldType.PM,
        subBuilder: $1.ObjectReference.create)
    ..aOS(2, _omitFieldNames ? '' : 'owner')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'budget', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasPayment clone() => GasPayment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasPayment copyWith(void Function(GasPayment) updates) =>
      super.copyWith((message) => updates(message as GasPayment)) as GasPayment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GasPayment create() => GasPayment._();
  @$core.override
  GasPayment createEmptyInstance() => create();
  static $pb.PbList<GasPayment> createRepeated() => $pb.PbList<GasPayment>();
  @$core.pragma('dart2js:noInline')
  static GasPayment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GasPayment>(create);
  static GasPayment? _defaultInstance;

  /// Set of gas objects to use for payment.
  @$pb.TagNumber(1)
  $pb.PbList<$1.ObjectReference> get objects => $_getList(0);

  /// Owner of the gas objects, either the transaction sender or a sponsor.
  @$pb.TagNumber(2)
  $core.String get owner => $_getSZ(1);
  @$pb.TagNumber(2)
  set owner($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwner() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwner() => $_clearField(2);

  /// Gas unit price to use when charging for computation.
  ///
  /// Must be greater than or equal to the network's current RGP (reference gas price).
  @$pb.TagNumber(3)
  $fixnum.Int64 get price => $_getI64(2);
  @$pb.TagNumber(3)
  set price($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);

  /// Total budget willing to spend for the execution of a transaction.
  @$pb.TagNumber(4)
  $fixnum.Int64 get budget => $_getI64(3);
  @$pb.TagNumber(4)
  set budget($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBudget() => $_has(3);
  @$pb.TagNumber(4)
  void clearBudget() => $_clearField(4);
}

/// A TTL for a transaction.
class TransactionExpiration extends $pb.GeneratedMessage {
  factory TransactionExpiration({
    TransactionExpiration_TransactionExpirationKind? kind,
    $fixnum.Int64? epoch,
    $fixnum.Int64? minEpoch,
    $2.Timestamp? minTimestamp,
    $2.Timestamp? maxTimestamp,
    $core.String? chain,
    $core.int? nonce,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (epoch != null) result.epoch = epoch;
    if (minEpoch != null) result.minEpoch = minEpoch;
    if (minTimestamp != null) result.minTimestamp = minTimestamp;
    if (maxTimestamp != null) result.maxTimestamp = maxTimestamp;
    if (chain != null) result.chain = chain;
    if (nonce != null) result.nonce = nonce;
    return result;
  }

  TransactionExpiration._();

  factory TransactionExpiration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionExpiration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionExpiration',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<TransactionExpiration_TransactionExpirationKind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: TransactionExpiration_TransactionExpirationKind
            .TRANSACTION_EXPIRATION_KIND_UNKNOWN,
        valueOf: TransactionExpiration_TransactionExpirationKind.valueOf,
        enumValues: TransactionExpiration_TransactionExpirationKind.values)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'minEpoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'minTimestamp',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'maxTimestamp',
        subBuilder: $2.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'chain')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionExpiration clone() =>
      TransactionExpiration()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionExpiration copyWith(
          void Function(TransactionExpiration) updates) =>
      super.copyWith((message) => updates(message as TransactionExpiration))
          as TransactionExpiration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionExpiration create() => TransactionExpiration._();
  @$core.override
  TransactionExpiration createEmptyInstance() => create();
  static $pb.PbList<TransactionExpiration> createRepeated() =>
      $pb.PbList<TransactionExpiration>();
  @$core.pragma('dart2js:noInline')
  static TransactionExpiration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionExpiration>(create);
  static TransactionExpiration? _defaultInstance;

  @$pb.TagNumber(1)
  TransactionExpiration_TransactionExpirationKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(TransactionExpiration_TransactionExpirationKind value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// Maximum epoch in which a transaction can be executed. The provided maximal epoch
  /// must be greater than or equal to the current epoch for a transaction to execute.
  @$pb.TagNumber(2)
  $fixnum.Int64 get epoch => $_getI64(1);
  @$pb.TagNumber(2)
  set epoch($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpoch() => $_clearField(2);

  /// Minimal epoch in which a transaction can be executed. The provided minimal epoch
  /// must be less than or equal to the current epoch for a transaction to execute.
  @$pb.TagNumber(3)
  $fixnum.Int64 get minEpoch => $_getI64(2);
  @$pb.TagNumber(3)
  set minEpoch($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinEpoch() => $_clearField(3);

  /// Minimal UNIX timestamp in which a transaction can be executed. The
  /// provided minimal timestamp must be less than or equal to the current
  /// clock.
  @$pb.TagNumber(4)
  $2.Timestamp get minTimestamp => $_getN(3);
  @$pb.TagNumber(4)
  set minTimestamp($2.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMinTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureMinTimestamp() => $_ensure(3);

  /// Maximum UNIX timestamp in which a transaction can be executed. The
  /// provided maximal timestamp must be greater than or equal to the current
  /// clock.
  @$pb.TagNumber(5)
  $2.Timestamp get maxTimestamp => $_getN(4);
  @$pb.TagNumber(5)
  set maxTimestamp($2.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasMaxTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureMaxTimestamp() => $_ensure(4);

  /// ChainId of the network this transaction is intended for in order to prevent cross-chain replay
  @$pb.TagNumber(6)
  $core.String get chain => $_getSZ(5);
  @$pb.TagNumber(6)
  set chain($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasChain() => $_has(5);
  @$pb.TagNumber(6)
  void clearChain() => $_clearField(6);

  /// User-provided uniqueness identifier to differentiate otherwise identical transactions
  @$pb.TagNumber(7)
  $core.int get nonce => $_getIZ(6);
  @$pb.TagNumber(7)
  set nonce($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNonce() => $_has(6);
  @$pb.TagNumber(7)
  void clearNonce() => $_clearField(7);
}

enum TransactionKind_Data {
  programmableTransaction,
  changeEpoch,
  genesis,
  consensusCommitPrologue,
  authenticatorStateUpdate,
  endOfEpoch,
  randomnessStateUpdate,
  notSet
}

/// Transaction type.
class TransactionKind extends $pb.GeneratedMessage {
  factory TransactionKind({
    TransactionKind_Kind? kind,
    ProgrammableTransaction? programmableTransaction,
    ChangeEpoch? changeEpoch,
    GenesisTransaction? genesis,
    ConsensusCommitPrologue? consensusCommitPrologue,
    AuthenticatorStateUpdate? authenticatorStateUpdate,
    EndOfEpochTransaction? endOfEpoch,
    RandomnessStateUpdate? randomnessStateUpdate,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (programmableTransaction != null)
      result.programmableTransaction = programmableTransaction;
    if (changeEpoch != null) result.changeEpoch = changeEpoch;
    if (genesis != null) result.genesis = genesis;
    if (consensusCommitPrologue != null)
      result.consensusCommitPrologue = consensusCommitPrologue;
    if (authenticatorStateUpdate != null)
      result.authenticatorStateUpdate = authenticatorStateUpdate;
    if (endOfEpoch != null) result.endOfEpoch = endOfEpoch;
    if (randomnessStateUpdate != null)
      result.randomnessStateUpdate = randomnessStateUpdate;
    return result;
  }

  TransactionKind._();

  factory TransactionKind.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionKind.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, TransactionKind_Data>
      _TransactionKind_DataByTag = {
    2: TransactionKind_Data.programmableTransaction,
    3: TransactionKind_Data.changeEpoch,
    4: TransactionKind_Data.genesis,
    5: TransactionKind_Data.consensusCommitPrologue,
    6: TransactionKind_Data.authenticatorStateUpdate,
    7: TransactionKind_Data.endOfEpoch,
    8: TransactionKind_Data.randomnessStateUpdate,
    0: TransactionKind_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionKind',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8])
    ..e<TransactionKind_Kind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: TransactionKind_Kind.KIND_UNKNOWN,
        valueOf: TransactionKind_Kind.valueOf,
        enumValues: TransactionKind_Kind.values)
    ..aOM<ProgrammableTransaction>(
        2, _omitFieldNames ? '' : 'programmableTransaction',
        subBuilder: ProgrammableTransaction.create)
    ..aOM<ChangeEpoch>(3, _omitFieldNames ? '' : 'changeEpoch',
        subBuilder: ChangeEpoch.create)
    ..aOM<GenesisTransaction>(4, _omitFieldNames ? '' : 'genesis',
        subBuilder: GenesisTransaction.create)
    ..aOM<ConsensusCommitPrologue>(
        5, _omitFieldNames ? '' : 'consensusCommitPrologue',
        subBuilder: ConsensusCommitPrologue.create)
    ..aOM<AuthenticatorStateUpdate>(
        6, _omitFieldNames ? '' : 'authenticatorStateUpdate',
        subBuilder: AuthenticatorStateUpdate.create)
    ..aOM<EndOfEpochTransaction>(7, _omitFieldNames ? '' : 'endOfEpoch',
        subBuilder: EndOfEpochTransaction.create)
    ..aOM<RandomnessStateUpdate>(
        8, _omitFieldNames ? '' : 'randomnessStateUpdate',
        subBuilder: RandomnessStateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionKind clone() => TransactionKind()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionKind copyWith(void Function(TransactionKind) updates) =>
      super.copyWith((message) => updates(message as TransactionKind))
          as TransactionKind;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionKind create() => TransactionKind._();
  @$core.override
  TransactionKind createEmptyInstance() => create();
  static $pb.PbList<TransactionKind> createRepeated() =>
      $pb.PbList<TransactionKind>();
  @$core.pragma('dart2js:noInline')
  static TransactionKind getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionKind>(create);
  static TransactionKind? _defaultInstance;

  TransactionKind_Data whichData() =>
      _TransactionKind_DataByTag[$_whichOneof(0)]!;
  void clearData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  TransactionKind_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(TransactionKind_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// A transaction comprised of a list of native commands and Move calls.
  @$pb.TagNumber(2)
  ProgrammableTransaction get programmableTransaction => $_getN(1);
  @$pb.TagNumber(2)
  set programmableTransaction(ProgrammableTransaction value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasProgrammableTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgrammableTransaction() => $_clearField(2);
  @$pb.TagNumber(2)
  ProgrammableTransaction ensureProgrammableTransaction() => $_ensure(1);

  /// System transaction used to end an epoch.
  ///
  /// The `ChangeEpoch` variant is now deprecated (but the `ChangeEpoch` struct is still used by
  /// `EndOfEpochTransaction`).
  @$pb.TagNumber(3)
  ChangeEpoch get changeEpoch => $_getN(2);
  @$pb.TagNumber(3)
  set changeEpoch(ChangeEpoch value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasChangeEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearChangeEpoch() => $_clearField(3);
  @$pb.TagNumber(3)
  ChangeEpoch ensureChangeEpoch() => $_ensure(2);

  /// Transaction used to initialize the chain state.
  ///
  /// Only valid if in the genesis checkpoint (0) and if this is the very first transaction ever
  /// executed on the chain.
  @$pb.TagNumber(4)
  GenesisTransaction get genesis => $_getN(3);
  @$pb.TagNumber(4)
  set genesis(GenesisTransaction value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasGenesis() => $_has(3);
  @$pb.TagNumber(4)
  void clearGenesis() => $_clearField(4);
  @$pb.TagNumber(4)
  GenesisTransaction ensureGenesis() => $_ensure(3);

  /// consensus commit update info
  @$pb.TagNumber(5)
  ConsensusCommitPrologue get consensusCommitPrologue => $_getN(4);
  @$pb.TagNumber(5)
  set consensusCommitPrologue(ConsensusCommitPrologue value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasConsensusCommitPrologue() => $_has(4);
  @$pb.TagNumber(5)
  void clearConsensusCommitPrologue() => $_clearField(5);
  @$pb.TagNumber(5)
  ConsensusCommitPrologue ensureConsensusCommitPrologue() => $_ensure(4);

  /// Update set of valid JWKs used for zklogin.
  @$pb.TagNumber(6)
  AuthenticatorStateUpdate get authenticatorStateUpdate => $_getN(5);
  @$pb.TagNumber(6)
  set authenticatorStateUpdate(AuthenticatorStateUpdate value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthenticatorStateUpdate() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthenticatorStateUpdate() => $_clearField(6);
  @$pb.TagNumber(6)
  AuthenticatorStateUpdate ensureAuthenticatorStateUpdate() => $_ensure(5);

  /// Set of operations to run at the end of the epoch to close out the current epoch and start
  /// the next one.
  @$pb.TagNumber(7)
  EndOfEpochTransaction get endOfEpoch => $_getN(6);
  @$pb.TagNumber(7)
  set endOfEpoch(EndOfEpochTransaction value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEndOfEpoch() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndOfEpoch() => $_clearField(7);
  @$pb.TagNumber(7)
  EndOfEpochTransaction ensureEndOfEpoch() => $_ensure(6);

  /// Randomness update.
  @$pb.TagNumber(8)
  RandomnessStateUpdate get randomnessStateUpdate => $_getN(7);
  @$pb.TagNumber(8)
  set randomnessStateUpdate(RandomnessStateUpdate value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasRandomnessStateUpdate() => $_has(7);
  @$pb.TagNumber(8)
  void clearRandomnessStateUpdate() => $_clearField(8);
  @$pb.TagNumber(8)
  RandomnessStateUpdate ensureRandomnessStateUpdate() => $_ensure(7);
}

/// A user transaction.
///
/// Contains a series of native commands and Move calls where the results of one command can be
/// used in future commands.
class ProgrammableTransaction extends $pb.GeneratedMessage {
  factory ProgrammableTransaction({
    $core.Iterable<$3.Input>? inputs,
    $core.Iterable<Command>? commands,
  }) {
    final result = create();
    if (inputs != null) result.inputs.addAll(inputs);
    if (commands != null) result.commands.addAll(commands);
    return result;
  }

  ProgrammableTransaction._();

  factory ProgrammableTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProgrammableTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProgrammableTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<$3.Input>(1, _omitFieldNames ? '' : 'inputs', $pb.PbFieldType.PM,
        subBuilder: $3.Input.create)
    ..pc<Command>(2, _omitFieldNames ? '' : 'commands', $pb.PbFieldType.PM,
        subBuilder: Command.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProgrammableTransaction clone() =>
      ProgrammableTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProgrammableTransaction copyWith(
          void Function(ProgrammableTransaction) updates) =>
      super.copyWith((message) => updates(message as ProgrammableTransaction))
          as ProgrammableTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProgrammableTransaction create() => ProgrammableTransaction._();
  @$core.override
  ProgrammableTransaction createEmptyInstance() => create();
  static $pb.PbList<ProgrammableTransaction> createRepeated() =>
      $pb.PbList<ProgrammableTransaction>();
  @$core.pragma('dart2js:noInline')
  static ProgrammableTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProgrammableTransaction>(create);
  static ProgrammableTransaction? _defaultInstance;

  /// Input objects or primitive values.
  @$pb.TagNumber(1)
  $pb.PbList<$3.Input> get inputs => $_getList(0);

  /// The commands to be executed sequentially. A failure in any command
  /// results in the failure of the entire transaction.
  @$pb.TagNumber(2)
  $pb.PbList<Command> get commands => $_getList(1);
}

enum Command_Command {
  moveCall,
  transferObjects,
  splitCoins,
  mergeCoins,
  publish,
  makeMoveVector,
  upgrade,
  notSet
}

/// A single command in a programmable transaction.
class Command extends $pb.GeneratedMessage {
  factory Command({
    MoveCall? moveCall,
    TransferObjects? transferObjects,
    SplitCoins? splitCoins,
    MergeCoins? mergeCoins,
    Publish? publish,
    MakeMoveVector? makeMoveVector,
    Upgrade? upgrade,
  }) {
    final result = create();
    if (moveCall != null) result.moveCall = moveCall;
    if (transferObjects != null) result.transferObjects = transferObjects;
    if (splitCoins != null) result.splitCoins = splitCoins;
    if (mergeCoins != null) result.mergeCoins = mergeCoins;
    if (publish != null) result.publish = publish;
    if (makeMoveVector != null) result.makeMoveVector = makeMoveVector;
    if (upgrade != null) result.upgrade = upgrade;
    return result;
  }

  Command._();

  factory Command.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Command.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Command_Command> _Command_CommandByTag = {
    1: Command_Command.moveCall,
    2: Command_Command.transferObjects,
    3: Command_Command.splitCoins,
    4: Command_Command.mergeCoins,
    5: Command_Command.publish,
    6: Command_Command.makeMoveVector,
    7: Command_Command.upgrade,
    0: Command_Command.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Command',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<MoveCall>(1, _omitFieldNames ? '' : 'moveCall',
        subBuilder: MoveCall.create)
    ..aOM<TransferObjects>(2, _omitFieldNames ? '' : 'transferObjects',
        subBuilder: TransferObjects.create)
    ..aOM<SplitCoins>(3, _omitFieldNames ? '' : 'splitCoins',
        subBuilder: SplitCoins.create)
    ..aOM<MergeCoins>(4, _omitFieldNames ? '' : 'mergeCoins',
        subBuilder: MergeCoins.create)
    ..aOM<Publish>(5, _omitFieldNames ? '' : 'publish',
        subBuilder: Publish.create)
    ..aOM<MakeMoveVector>(6, _omitFieldNames ? '' : 'makeMoveVector',
        subBuilder: MakeMoveVector.create)
    ..aOM<Upgrade>(7, _omitFieldNames ? '' : 'upgrade',
        subBuilder: Upgrade.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command clone() => Command()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command copyWith(void Function(Command) updates) =>
      super.copyWith((message) => updates(message as Command)) as Command;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Command create() => Command._();
  @$core.override
  Command createEmptyInstance() => create();
  static $pb.PbList<Command> createRepeated() => $pb.PbList<Command>();
  @$core.pragma('dart2js:noInline')
  static Command getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Command>(create);
  static Command? _defaultInstance;

  Command_Command whichCommand() => _Command_CommandByTag[$_whichOneof(0)]!;
  void clearCommand() => $_clearField($_whichOneof(0));

  /// A call to either an entry or a public Move function.
  @$pb.TagNumber(1)
  MoveCall get moveCall => $_getN(0);
  @$pb.TagNumber(1)
  set moveCall(MoveCall value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMoveCall() => $_has(0);
  @$pb.TagNumber(1)
  void clearMoveCall() => $_clearField(1);
  @$pb.TagNumber(1)
  MoveCall ensureMoveCall() => $_ensure(0);

  /// `(Vec<forall T:key+store. T>, address)`
  /// It sends n-objects to the specified address. These objects must have store
  /// (public transfer) and either the previous owner must be an address or the object must
  /// be newly created.
  @$pb.TagNumber(2)
  TransferObjects get transferObjects => $_getN(1);
  @$pb.TagNumber(2)
  set transferObjects(TransferObjects value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTransferObjects() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransferObjects() => $_clearField(2);
  @$pb.TagNumber(2)
  TransferObjects ensureTransferObjects() => $_ensure(1);

  /// `(&mut Coin<T>, Vec<u64>)` -> `Vec<Coin<T>>`
  /// It splits off some amounts into new coins with those amounts.
  @$pb.TagNumber(3)
  SplitCoins get splitCoins => $_getN(2);
  @$pb.TagNumber(3)
  set splitCoins(SplitCoins value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSplitCoins() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplitCoins() => $_clearField(3);
  @$pb.TagNumber(3)
  SplitCoins ensureSplitCoins() => $_ensure(2);

  /// `(&mut Coin<T>, Vec<Coin<T>>)`
  /// It merges n-coins into the first coin.
  @$pb.TagNumber(4)
  MergeCoins get mergeCoins => $_getN(3);
  @$pb.TagNumber(4)
  set mergeCoins(MergeCoins value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMergeCoins() => $_has(3);
  @$pb.TagNumber(4)
  void clearMergeCoins() => $_clearField(4);
  @$pb.TagNumber(4)
  MergeCoins ensureMergeCoins() => $_ensure(3);

  /// Publishes a Move package. It takes the package bytes and a list of the package's transitive
  /// dependencies to link against on chain.
  @$pb.TagNumber(5)
  Publish get publish => $_getN(4);
  @$pb.TagNumber(5)
  set publish(Publish value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPublish() => $_has(4);
  @$pb.TagNumber(5)
  void clearPublish() => $_clearField(5);
  @$pb.TagNumber(5)
  Publish ensurePublish() => $_ensure(4);

  /// `forall T: Vec<T> -> vector<T>`
  /// Given n-values of the same type, it constructs a vector. For non-objects or an empty vector,
  /// the type tag must be specified.
  @$pb.TagNumber(6)
  MakeMoveVector get makeMoveVector => $_getN(5);
  @$pb.TagNumber(6)
  set makeMoveVector(MakeMoveVector value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasMakeMoveVector() => $_has(5);
  @$pb.TagNumber(6)
  void clearMakeMoveVector() => $_clearField(6);
  @$pb.TagNumber(6)
  MakeMoveVector ensureMakeMoveVector() => $_ensure(5);

  /// Upgrades a Move package.
  /// Takes (in order):
  /// 1. A vector of serialized modules for the package.
  /// 2. A vector of object ids for the transitive dependencies of the new package.
  /// 3. The object ID of the package being upgraded.
  /// 4. An argument holding the `UpgradeTicket` that must have been produced from an earlier command in the same
  ///    programmable transaction.
  @$pb.TagNumber(7)
  Upgrade get upgrade => $_getN(6);
  @$pb.TagNumber(7)
  set upgrade(Upgrade value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUpgrade() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpgrade() => $_clearField(7);
  @$pb.TagNumber(7)
  Upgrade ensureUpgrade() => $_ensure(6);
}

/// Command to call a Move function.
///
/// Functions that can be called by a `MoveCall` command are those that have a function signature
/// that is either `entry` or `public` (which don't have a reference return type).
class MoveCall extends $pb.GeneratedMessage {
  factory MoveCall({
    $core.String? package,
    $core.String? module,
    $core.String? function,
    $core.Iterable<$core.String>? typeArguments,
    $core.Iterable<$4.Argument>? arguments,
  }) {
    final result = create();
    if (package != null) result.package = package;
    if (module != null) result.module = module;
    if (function != null) result.function = function;
    if (typeArguments != null) result.typeArguments.addAll(typeArguments);
    if (arguments != null) result.arguments.addAll(arguments);
    return result;
  }

  MoveCall._();

  factory MoveCall.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveCall.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveCall',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'package')
    ..aOS(2, _omitFieldNames ? '' : 'module')
    ..aOS(3, _omitFieldNames ? '' : 'function')
    ..pPS(4, _omitFieldNames ? '' : 'typeArguments')
    ..pc<$4.Argument>(5, _omitFieldNames ? '' : 'arguments', $pb.PbFieldType.PM,
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveCall clone() => MoveCall()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveCall copyWith(void Function(MoveCall) updates) =>
      super.copyWith((message) => updates(message as MoveCall)) as MoveCall;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveCall create() => MoveCall._();
  @$core.override
  MoveCall createEmptyInstance() => create();
  static $pb.PbList<MoveCall> createRepeated() => $pb.PbList<MoveCall>();
  @$core.pragma('dart2js:noInline')
  static MoveCall getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveCall>(create);
  static MoveCall? _defaultInstance;

  /// The package containing the module and function.
  @$pb.TagNumber(1)
  $core.String get package => $_getSZ(0);
  @$pb.TagNumber(1)
  set package($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackage() => $_clearField(1);

  /// The specific module in the package containing the function.
  @$pb.TagNumber(2)
  $core.String get module => $_getSZ(1);
  @$pb.TagNumber(2)
  set module($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModule() => $_has(1);
  @$pb.TagNumber(2)
  void clearModule() => $_clearField(2);

  /// The function to be called.
  @$pb.TagNumber(3)
  $core.String get function => $_getSZ(2);
  @$pb.TagNumber(3)
  set function($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => $_clearField(3);

  /// The type arguments to the function.
  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get typeArguments => $_getList(3);

  /// The arguments to the function.
  @$pb.TagNumber(5)
  $pb.PbList<$4.Argument> get arguments => $_getList(4);
}

/// Command to transfer ownership of a set of objects to an address.
class TransferObjects extends $pb.GeneratedMessage {
  factory TransferObjects({
    $core.Iterable<$4.Argument>? objects,
    $4.Argument? address,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    if (address != null) result.address = address;
    return result;
  }

  TransferObjects._();

  factory TransferObjects.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferObjects.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferObjects',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<$4.Argument>(1, _omitFieldNames ? '' : 'objects', $pb.PbFieldType.PM,
        subBuilder: $4.Argument.create)
    ..aOM<$4.Argument>(2, _omitFieldNames ? '' : 'address',
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferObjects clone() => TransferObjects()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferObjects copyWith(void Function(TransferObjects) updates) =>
      super.copyWith((message) => updates(message as TransferObjects))
          as TransferObjects;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferObjects create() => TransferObjects._();
  @$core.override
  TransferObjects createEmptyInstance() => create();
  static $pb.PbList<TransferObjects> createRepeated() =>
      $pb.PbList<TransferObjects>();
  @$core.pragma('dart2js:noInline')
  static TransferObjects getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferObjects>(create);
  static TransferObjects? _defaultInstance;

  /// Set of objects to transfer.
  @$pb.TagNumber(1)
  $pb.PbList<$4.Argument> get objects => $_getList(0);

  /// The address to transfer ownership to.
  @$pb.TagNumber(2)
  $4.Argument get address => $_getN(1);
  @$pb.TagNumber(2)
  set address($4.Argument value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);
  @$pb.TagNumber(2)
  $4.Argument ensureAddress() => $_ensure(1);
}

/// Command to split a single coin object into multiple coins.
class SplitCoins extends $pb.GeneratedMessage {
  factory SplitCoins({
    $4.Argument? coin,
    $core.Iterable<$4.Argument>? amounts,
  }) {
    final result = create();
    if (coin != null) result.coin = coin;
    if (amounts != null) result.amounts.addAll(amounts);
    return result;
  }

  SplitCoins._();

  factory SplitCoins.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SplitCoins.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SplitCoins',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$4.Argument>(1, _omitFieldNames ? '' : 'coin',
        subBuilder: $4.Argument.create)
    ..pc<$4.Argument>(2, _omitFieldNames ? '' : 'amounts', $pb.PbFieldType.PM,
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitCoins clone() => SplitCoins()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SplitCoins copyWith(void Function(SplitCoins) updates) =>
      super.copyWith((message) => updates(message as SplitCoins)) as SplitCoins;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SplitCoins create() => SplitCoins._();
  @$core.override
  SplitCoins createEmptyInstance() => create();
  static $pb.PbList<SplitCoins> createRepeated() => $pb.PbList<SplitCoins>();
  @$core.pragma('dart2js:noInline')
  static SplitCoins getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SplitCoins>(create);
  static SplitCoins? _defaultInstance;

  /// The coin to split.
  @$pb.TagNumber(1)
  $4.Argument get coin => $_getN(0);
  @$pb.TagNumber(1)
  set coin($4.Argument value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCoin() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoin() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Argument ensureCoin() => $_ensure(0);

  /// The amounts to split off.
  @$pb.TagNumber(2)
  $pb.PbList<$4.Argument> get amounts => $_getList(1);
}

/// Command to merge multiple coins of the same type into a single coin.
class MergeCoins extends $pb.GeneratedMessage {
  factory MergeCoins({
    $4.Argument? coin,
    $core.Iterable<$4.Argument>? coinsToMerge,
  }) {
    final result = create();
    if (coin != null) result.coin = coin;
    if (coinsToMerge != null) result.coinsToMerge.addAll(coinsToMerge);
    return result;
  }

  MergeCoins._();

  factory MergeCoins.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MergeCoins.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MergeCoins',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$4.Argument>(1, _omitFieldNames ? '' : 'coin',
        subBuilder: $4.Argument.create)
    ..pc<$4.Argument>(
        2, _omitFieldNames ? '' : 'coinsToMerge', $pb.PbFieldType.PM,
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeCoins clone() => MergeCoins()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MergeCoins copyWith(void Function(MergeCoins) updates) =>
      super.copyWith((message) => updates(message as MergeCoins)) as MergeCoins;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MergeCoins create() => MergeCoins._();
  @$core.override
  MergeCoins createEmptyInstance() => create();
  static $pb.PbList<MergeCoins> createRepeated() => $pb.PbList<MergeCoins>();
  @$core.pragma('dart2js:noInline')
  static MergeCoins getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MergeCoins>(create);
  static MergeCoins? _defaultInstance;

  /// Coin to merge coins into.
  @$pb.TagNumber(1)
  $4.Argument get coin => $_getN(0);
  @$pb.TagNumber(1)
  set coin($4.Argument value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCoin() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoin() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Argument ensureCoin() => $_ensure(0);

  /// Set of coins to merge into `coin`.
  ///
  /// All listed coins must be of the same type and be the same type as `coin`
  @$pb.TagNumber(2)
  $pb.PbList<$4.Argument> get coinsToMerge => $_getList(1);
}

/// Command to publish a new Move package.
class Publish extends $pb.GeneratedMessage {
  factory Publish({
    $core.Iterable<$core.List<$core.int>>? modules,
    $core.Iterable<$core.String>? dependencies,
  }) {
    final result = create();
    if (modules != null) result.modules.addAll(modules);
    if (dependencies != null) result.dependencies.addAll(dependencies);
    return result;
  }

  Publish._();

  factory Publish.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Publish.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Publish',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..p<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'modules', $pb.PbFieldType.PY)
    ..pPS(2, _omitFieldNames ? '' : 'dependencies')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Publish clone() => Publish()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Publish copyWith(void Function(Publish) updates) =>
      super.copyWith((message) => updates(message as Publish)) as Publish;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Publish create() => Publish._();
  @$core.override
  Publish createEmptyInstance() => create();
  static $pb.PbList<Publish> createRepeated() => $pb.PbList<Publish>();
  @$core.pragma('dart2js:noInline')
  static Publish getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Publish>(create);
  static Publish? _defaultInstance;

  /// The serialized Move modules.
  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get modules => $_getList(0);

  /// Set of packages that the to-be published package depends on.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get dependencies => $_getList(1);
}

/// Command to build a Move vector out of a set of individual elements.
class MakeMoveVector extends $pb.GeneratedMessage {
  factory MakeMoveVector({
    $core.String? elementType,
    $core.Iterable<$4.Argument>? elements,
  }) {
    final result = create();
    if (elementType != null) result.elementType = elementType;
    if (elements != null) result.elements.addAll(elements);
    return result;
  }

  MakeMoveVector._();

  factory MakeMoveVector.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MakeMoveVector.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeMoveVector',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'elementType')
    ..pc<$4.Argument>(2, _omitFieldNames ? '' : 'elements', $pb.PbFieldType.PM,
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeMoveVector clone() => MakeMoveVector()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeMoveVector copyWith(void Function(MakeMoveVector) updates) =>
      super.copyWith((message) => updates(message as MakeMoveVector))
          as MakeMoveVector;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MakeMoveVector create() => MakeMoveVector._();
  @$core.override
  MakeMoveVector createEmptyInstance() => create();
  static $pb.PbList<MakeMoveVector> createRepeated() =>
      $pb.PbList<MakeMoveVector>();
  @$core.pragma('dart2js:noInline')
  static MakeMoveVector getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MakeMoveVector>(create);
  static MakeMoveVector? _defaultInstance;

  /// Type of the individual elements.
  ///
  /// This is required to be set when the type can't be inferred, for example when the set of
  /// provided arguments are all pure input values.
  @$pb.TagNumber(1)
  $core.String get elementType => $_getSZ(0);
  @$pb.TagNumber(1)
  set elementType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasElementType() => $_has(0);
  @$pb.TagNumber(1)
  void clearElementType() => $_clearField(1);

  /// The set individual elements to build the vector with.
  @$pb.TagNumber(2)
  $pb.PbList<$4.Argument> get elements => $_getList(1);
}

/// Command to upgrade an already published package.
class Upgrade extends $pb.GeneratedMessage {
  factory Upgrade({
    $core.Iterable<$core.List<$core.int>>? modules,
    $core.Iterable<$core.String>? dependencies,
    $core.String? package,
    $4.Argument? ticket,
  }) {
    final result = create();
    if (modules != null) result.modules.addAll(modules);
    if (dependencies != null) result.dependencies.addAll(dependencies);
    if (package != null) result.package = package;
    if (ticket != null) result.ticket = ticket;
    return result;
  }

  Upgrade._();

  factory Upgrade.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Upgrade.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Upgrade',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..p<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'modules', $pb.PbFieldType.PY)
    ..pPS(2, _omitFieldNames ? '' : 'dependencies')
    ..aOS(3, _omitFieldNames ? '' : 'package')
    ..aOM<$4.Argument>(4, _omitFieldNames ? '' : 'ticket',
        subBuilder: $4.Argument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Upgrade clone() => Upgrade()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Upgrade copyWith(void Function(Upgrade) updates) =>
      super.copyWith((message) => updates(message as Upgrade)) as Upgrade;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Upgrade create() => Upgrade._();
  @$core.override
  Upgrade createEmptyInstance() => create();
  static $pb.PbList<Upgrade> createRepeated() => $pb.PbList<Upgrade>();
  @$core.pragma('dart2js:noInline')
  static Upgrade getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Upgrade>(create);
  static Upgrade? _defaultInstance;

  /// The serialized Move modules.
  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get modules => $_getList(0);

  /// Set of packages that the to-be published package depends on.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get dependencies => $_getList(1);

  /// Package ID of the package to upgrade.
  @$pb.TagNumber(3)
  $core.String get package => $_getSZ(2);
  @$pb.TagNumber(3)
  set package($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPackage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPackage() => $_clearField(3);

  /// Ticket authorizing the upgrade.
  @$pb.TagNumber(4)
  $4.Argument get ticket => $_getN(3);
  @$pb.TagNumber(4)
  set ticket($4.Argument value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTicket() => $_has(3);
  @$pb.TagNumber(4)
  void clearTicket() => $_clearField(4);
  @$pb.TagNumber(4)
  $4.Argument ensureTicket() => $_ensure(3);
}

/// Randomness update.
class RandomnessStateUpdate extends $pb.GeneratedMessage {
  factory RandomnessStateUpdate({
    $fixnum.Int64? epoch,
    $fixnum.Int64? randomnessRound,
    $core.List<$core.int>? randomBytes,
    $fixnum.Int64? randomnessObjectInitialSharedVersion,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (randomnessRound != null) result.randomnessRound = randomnessRound;
    if (randomBytes != null) result.randomBytes = randomBytes;
    if (randomnessObjectInitialSharedVersion != null)
      result.randomnessObjectInitialSharedVersion =
          randomnessObjectInitialSharedVersion;
    return result;
  }

  RandomnessStateUpdate._();

  factory RandomnessStateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RandomnessStateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RandomnessStateUpdate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'randomnessRound', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'randomBytes', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(
        4,
        _omitFieldNames ? '' : 'randomnessObjectInitialSharedVersion',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RandomnessStateUpdate clone() =>
      RandomnessStateUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RandomnessStateUpdate copyWith(
          void Function(RandomnessStateUpdate) updates) =>
      super.copyWith((message) => updates(message as RandomnessStateUpdate))
          as RandomnessStateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RandomnessStateUpdate create() => RandomnessStateUpdate._();
  @$core.override
  RandomnessStateUpdate createEmptyInstance() => create();
  static $pb.PbList<RandomnessStateUpdate> createRepeated() =>
      $pb.PbList<RandomnessStateUpdate>();
  @$core.pragma('dart2js:noInline')
  static RandomnessStateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RandomnessStateUpdate>(create);
  static RandomnessStateUpdate? _defaultInstance;

  /// Epoch of the randomness state update transaction.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// Randomness round of the update.
  @$pb.TagNumber(2)
  $fixnum.Int64 get randomnessRound => $_getI64(1);
  @$pb.TagNumber(2)
  set randomnessRound($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRandomnessRound() => $_has(1);
  @$pb.TagNumber(2)
  void clearRandomnessRound() => $_clearField(2);

  /// Updated random bytes.
  @$pb.TagNumber(3)
  $core.List<$core.int> get randomBytes => $_getN(2);
  @$pb.TagNumber(3)
  set randomBytes($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRandomBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearRandomBytes() => $_clearField(3);

  /// The initial version of the randomness object that it was shared at.
  @$pb.TagNumber(4)
  $fixnum.Int64 get randomnessObjectInitialSharedVersion => $_getI64(3);
  @$pb.TagNumber(4)
  set randomnessObjectInitialSharedVersion($fixnum.Int64 value) =>
      $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRandomnessObjectInitialSharedVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearRandomnessObjectInitialSharedVersion() => $_clearField(4);
}

/// System transaction used to change the epoch.
class ChangeEpoch extends $pb.GeneratedMessage {
  factory ChangeEpoch({
    $fixnum.Int64? epoch,
    $fixnum.Int64? protocolVersion,
    $fixnum.Int64? storageCharge,
    $fixnum.Int64? computationCharge,
    $fixnum.Int64? storageRebate,
    $fixnum.Int64? nonRefundableStorageFee,
    $2.Timestamp? epochStartTimestamp,
    $core.Iterable<SystemPackage>? systemPackages,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (protocolVersion != null) result.protocolVersion = protocolVersion;
    if (storageCharge != null) result.storageCharge = storageCharge;
    if (computationCharge != null) result.computationCharge = computationCharge;
    if (storageRebate != null) result.storageRebate = storageRebate;
    if (nonRefundableStorageFee != null)
      result.nonRefundableStorageFee = nonRefundableStorageFee;
    if (epochStartTimestamp != null)
      result.epochStartTimestamp = epochStartTimestamp;
    if (systemPackages != null) result.systemPackages.addAll(systemPackages);
    return result;
  }

  ChangeEpoch._();

  factory ChangeEpoch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangeEpoch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangeEpoch',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'protocolVersion', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'storageCharge', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'computationCharge', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'storageRebate', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'nonRefundableStorageFee',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'epochStartTimestamp',
        subBuilder: $2.Timestamp.create)
    ..pc<SystemPackage>(
        8, _omitFieldNames ? '' : 'systemPackages', $pb.PbFieldType.PM,
        subBuilder: SystemPackage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeEpoch clone() => ChangeEpoch()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangeEpoch copyWith(void Function(ChangeEpoch) updates) =>
      super.copyWith((message) => updates(message as ChangeEpoch))
          as ChangeEpoch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeEpoch create() => ChangeEpoch._();
  @$core.override
  ChangeEpoch createEmptyInstance() => create();
  static $pb.PbList<ChangeEpoch> createRepeated() => $pb.PbList<ChangeEpoch>();
  @$core.pragma('dart2js:noInline')
  static ChangeEpoch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeEpoch>(create);
  static ChangeEpoch? _defaultInstance;

  /// The next (to become) epoch ID.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// The protocol version in effect in the new epoch.
  @$pb.TagNumber(2)
  $fixnum.Int64 get protocolVersion => $_getI64(1);
  @$pb.TagNumber(2)
  set protocolVersion($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProtocolVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearProtocolVersion() => $_clearField(2);

  /// The total amount of gas charged for storage during the epoch.
  @$pb.TagNumber(3)
  $fixnum.Int64 get storageCharge => $_getI64(2);
  @$pb.TagNumber(3)
  set storageCharge($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStorageCharge() => $_has(2);
  @$pb.TagNumber(3)
  void clearStorageCharge() => $_clearField(3);

  /// The total amount of gas charged for computation during the epoch.
  @$pb.TagNumber(4)
  $fixnum.Int64 get computationCharge => $_getI64(3);
  @$pb.TagNumber(4)
  set computationCharge($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasComputationCharge() => $_has(3);
  @$pb.TagNumber(4)
  void clearComputationCharge() => $_clearField(4);

  /// The amount of storage rebate refunded to the txn senders.
  @$pb.TagNumber(5)
  $fixnum.Int64 get storageRebate => $_getI64(4);
  @$pb.TagNumber(5)
  set storageRebate($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStorageRebate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStorageRebate() => $_clearField(5);

  /// The non-refundable storage fee.
  @$pb.TagNumber(6)
  $fixnum.Int64 get nonRefundableStorageFee => $_getI64(5);
  @$pb.TagNumber(6)
  set nonRefundableStorageFee($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNonRefundableStorageFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearNonRefundableStorageFee() => $_clearField(6);

  /// Unix timestamp when epoch started.
  @$pb.TagNumber(7)
  $2.Timestamp get epochStartTimestamp => $_getN(6);
  @$pb.TagNumber(7)
  set epochStartTimestamp($2.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEpochStartTimestamp() => $_has(6);
  @$pb.TagNumber(7)
  void clearEpochStartTimestamp() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureEpochStartTimestamp() => $_ensure(6);

  /// System packages (specifically framework and Move stdlib) that are written before the new
  /// epoch starts. This tracks framework upgrades on chain. When executing the `ChangeEpoch` txn,
  /// the validator must write out the following modules.  Modules are provided with the version they
  /// will be upgraded to, their modules in serialized form (which include their package ID), and
  /// a list of their transitive dependencies.
  @$pb.TagNumber(8)
  $pb.PbList<SystemPackage> get systemPackages => $_getList(7);
}

/// System package.
class SystemPackage extends $pb.GeneratedMessage {
  factory SystemPackage({
    $fixnum.Int64? version,
    $core.Iterable<$core.List<$core.int>>? modules,
    $core.Iterable<$core.String>? dependencies,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (modules != null) result.modules.addAll(modules);
    if (dependencies != null) result.dependencies.addAll(dependencies);
    return result;
  }

  SystemPackage._();

  factory SystemPackage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SystemPackage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SystemPackage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'modules', $pb.PbFieldType.PY)
    ..pPS(3, _omitFieldNames ? '' : 'dependencies')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemPackage clone() => SystemPackage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemPackage copyWith(void Function(SystemPackage) updates) =>
      super.copyWith((message) => updates(message as SystemPackage))
          as SystemPackage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemPackage create() => SystemPackage._();
  @$core.override
  SystemPackage createEmptyInstance() => create();
  static $pb.PbList<SystemPackage> createRepeated() =>
      $pb.PbList<SystemPackage>();
  @$core.pragma('dart2js:noInline')
  static SystemPackage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SystemPackage>(create);
  static SystemPackage? _defaultInstance;

  /// Version of the package.
  @$pb.TagNumber(1)
  $fixnum.Int64 get version => $_getI64(0);
  @$pb.TagNumber(1)
  set version($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  /// Move modules.
  @$pb.TagNumber(2)
  $pb.PbList<$core.List<$core.int>> get modules => $_getList(1);

  /// Package dependencies.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get dependencies => $_getList(2);
}

/// The genesis transaction.
class GenesisTransaction extends $pb.GeneratedMessage {
  factory GenesisTransaction({
    $core.Iterable<$5.Object>? objects,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    return result;
  }

  GenesisTransaction._();

  factory GenesisTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenesisTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenesisTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<$5.Object>(1, _omitFieldNames ? '' : 'objects', $pb.PbFieldType.PM,
        subBuilder: $5.Object.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenesisTransaction clone() => GenesisTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenesisTransaction copyWith(void Function(GenesisTransaction) updates) =>
      super.copyWith((message) => updates(message as GenesisTransaction))
          as GenesisTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenesisTransaction create() => GenesisTransaction._();
  @$core.override
  GenesisTransaction createEmptyInstance() => create();
  static $pb.PbList<GenesisTransaction> createRepeated() =>
      $pb.PbList<GenesisTransaction>();
  @$core.pragma('dart2js:noInline')
  static GenesisTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenesisTransaction>(create);
  static GenesisTransaction? _defaultInstance;

  /// Set of genesis objects.
  @$pb.TagNumber(1)
  $pb.PbList<$5.Object> get objects => $_getList(0);
}

/// Consensus commit prologue system transaction.
///
/// This message can represent V1, V2, and V3 prologue types.
class ConsensusCommitPrologue extends $pb.GeneratedMessage {
  factory ConsensusCommitPrologue({
    $fixnum.Int64? epoch,
    $fixnum.Int64? round,
    $2.Timestamp? commitTimestamp,
    $core.String? consensusCommitDigest,
    $fixnum.Int64? subDagIndex,
    ConsensusDeterminedVersionAssignments?
        consensusDeterminedVersionAssignments,
    $core.String? additionalStateDigest,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (round != null) result.round = round;
    if (commitTimestamp != null) result.commitTimestamp = commitTimestamp;
    if (consensusCommitDigest != null)
      result.consensusCommitDigest = consensusCommitDigest;
    if (subDagIndex != null) result.subDagIndex = subDagIndex;
    if (consensusDeterminedVersionAssignments != null)
      result.consensusDeterminedVersionAssignments =
          consensusDeterminedVersionAssignments;
    if (additionalStateDigest != null)
      result.additionalStateDigest = additionalStateDigest;
    return result;
  }

  ConsensusCommitPrologue._();

  factory ConsensusCommitPrologue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConsensusCommitPrologue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConsensusCommitPrologue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'round', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'commitTimestamp',
        subBuilder: $2.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'consensusCommitDigest')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'subDagIndex', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<ConsensusDeterminedVersionAssignments>(
        6, _omitFieldNames ? '' : 'consensusDeterminedVersionAssignments',
        subBuilder: ConsensusDeterminedVersionAssignments.create)
    ..aOS(7, _omitFieldNames ? '' : 'additionalStateDigest')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConsensusCommitPrologue clone() =>
      ConsensusCommitPrologue()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConsensusCommitPrologue copyWith(
          void Function(ConsensusCommitPrologue) updates) =>
      super.copyWith((message) => updates(message as ConsensusCommitPrologue))
          as ConsensusCommitPrologue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsensusCommitPrologue create() => ConsensusCommitPrologue._();
  @$core.override
  ConsensusCommitPrologue createEmptyInstance() => create();
  static $pb.PbList<ConsensusCommitPrologue> createRepeated() =>
      $pb.PbList<ConsensusCommitPrologue>();
  @$core.pragma('dart2js:noInline')
  static ConsensusCommitPrologue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConsensusCommitPrologue>(create);
  static ConsensusCommitPrologue? _defaultInstance;

  /// Epoch of the commit prologue transaction.
  ///
  /// Present in V1, V2, V3, V4.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// Consensus round of the commit.
  ///
  /// Present in V1, V2, V3, V4.
  @$pb.TagNumber(2)
  $fixnum.Int64 get round => $_getI64(1);
  @$pb.TagNumber(2)
  set round($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRound() => $_has(1);
  @$pb.TagNumber(2)
  void clearRound() => $_clearField(2);

  /// Unix timestamp from consensus.
  ///
  /// Present in V1, V2, V3, V4.
  @$pb.TagNumber(3)
  $2.Timestamp get commitTimestamp => $_getN(2);
  @$pb.TagNumber(3)
  set commitTimestamp($2.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCommitTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommitTimestamp() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureCommitTimestamp() => $_ensure(2);

  /// Digest of consensus output.
  ///
  /// Present in V2, V3, V4.
  @$pb.TagNumber(4)
  $core.String get consensusCommitDigest => $_getSZ(3);
  @$pb.TagNumber(4)
  set consensusCommitDigest($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConsensusCommitDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearConsensusCommitDigest() => $_clearField(4);

  /// The sub DAG index of the consensus commit. This field is populated if there
  /// are multiple consensus commits per round.
  ///
  /// Present in V3, V4.
  @$pb.TagNumber(5)
  $fixnum.Int64 get subDagIndex => $_getI64(4);
  @$pb.TagNumber(5)
  set subDagIndex($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSubDagIndex() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubDagIndex() => $_clearField(5);

  /// Stores consensus handler determined consensus object version assignments.
  ///
  /// Present in V3, V4.
  @$pb.TagNumber(6)
  ConsensusDeterminedVersionAssignments
      get consensusDeterminedVersionAssignments => $_getN(5);
  @$pb.TagNumber(6)
  set consensusDeterminedVersionAssignments(
          ConsensusDeterminedVersionAssignments value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasConsensusDeterminedVersionAssignments() => $_has(5);
  @$pb.TagNumber(6)
  void clearConsensusDeterminedVersionAssignments() => $_clearField(6);
  @$pb.TagNumber(6)
  ConsensusDeterminedVersionAssignments
      ensureConsensusDeterminedVersionAssignments() => $_ensure(5);

  /// Digest of any additional state computed by the consensus handler.
  /// Used to detect forking bugs as early as possible.
  ///
  /// Present in V4.
  @$pb.TagNumber(7)
  $core.String get additionalStateDigest => $_getSZ(6);
  @$pb.TagNumber(7)
  set additionalStateDigest($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAdditionalStateDigest() => $_has(6);
  @$pb.TagNumber(7)
  void clearAdditionalStateDigest() => $_clearField(7);
}

/// Object version assignment from consensus.
class VersionAssignment extends $pb.GeneratedMessage {
  factory VersionAssignment({
    $core.String? objectId,
    $fixnum.Int64? startVersion,
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (objectId != null) result.objectId = objectId;
    if (startVersion != null) result.startVersion = startVersion;
    if (version != null) result.version = version;
    return result;
  }

  VersionAssignment._();

  factory VersionAssignment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionAssignment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionAssignment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'objectId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'startVersion', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAssignment clone() => VersionAssignment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAssignment copyWith(void Function(VersionAssignment) updates) =>
      super.copyWith((message) => updates(message as VersionAssignment))
          as VersionAssignment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionAssignment create() => VersionAssignment._();
  @$core.override
  VersionAssignment createEmptyInstance() => create();
  static $pb.PbList<VersionAssignment> createRepeated() =>
      $pb.PbList<VersionAssignment>();
  @$core.pragma('dart2js:noInline')
  static VersionAssignment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionAssignment>(create);
  static VersionAssignment? _defaultInstance;

  /// `ObjectId` of the object.
  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => $_clearField(1);

  /// start version of the consensus stream for this object
  @$pb.TagNumber(2)
  $fixnum.Int64 get startVersion => $_getI64(1);
  @$pb.TagNumber(2)
  set startVersion($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartVersion() => $_clearField(2);

  /// Assigned version.
  @$pb.TagNumber(3)
  $fixnum.Int64 get version => $_getI64(2);
  @$pb.TagNumber(3)
  set version($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
}

/// A transaction that was canceled.
class CanceledTransaction extends $pb.GeneratedMessage {
  factory CanceledTransaction({
    $core.String? digest,
    $core.Iterable<VersionAssignment>? versionAssignments,
  }) {
    final result = create();
    if (digest != null) result.digest = digest;
    if (versionAssignments != null)
      result.versionAssignments.addAll(versionAssignments);
    return result;
  }

  CanceledTransaction._();

  factory CanceledTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CanceledTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CanceledTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'digest')
    ..pc<VersionAssignment>(
        2, _omitFieldNames ? '' : 'versionAssignments', $pb.PbFieldType.PM,
        subBuilder: VersionAssignment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CanceledTransaction clone() => CanceledTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CanceledTransaction copyWith(void Function(CanceledTransaction) updates) =>
      super.copyWith((message) => updates(message as CanceledTransaction))
          as CanceledTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CanceledTransaction create() => CanceledTransaction._();
  @$core.override
  CanceledTransaction createEmptyInstance() => create();
  static $pb.PbList<CanceledTransaction> createRepeated() =>
      $pb.PbList<CanceledTransaction>();
  @$core.pragma('dart2js:noInline')
  static CanceledTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CanceledTransaction>(create);
  static CanceledTransaction? _defaultInstance;

  /// Digest of the canceled transaction.
  @$pb.TagNumber(1)
  $core.String get digest => $_getSZ(0);
  @$pb.TagNumber(1)
  set digest($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDigest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDigest() => $_clearField(1);

  /// List of object version assignments.
  @$pb.TagNumber(2)
  $pb.PbList<VersionAssignment> get versionAssignments => $_getList(1);
}

/// Version assignments performed by consensus.
class ConsensusDeterminedVersionAssignments extends $pb.GeneratedMessage {
  factory ConsensusDeterminedVersionAssignments({
    $core.int? version,
    $core.Iterable<CanceledTransaction>? canceledTransactions,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (canceledTransactions != null)
      result.canceledTransactions.addAll(canceledTransactions);
    return result;
  }

  ConsensusDeterminedVersionAssignments._();

  factory ConsensusDeterminedVersionAssignments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConsensusDeterminedVersionAssignments.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConsensusDeterminedVersionAssignments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..pc<CanceledTransaction>(
        3, _omitFieldNames ? '' : 'canceledTransactions', $pb.PbFieldType.PM,
        subBuilder: CanceledTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConsensusDeterminedVersionAssignments clone() =>
      ConsensusDeterminedVersionAssignments()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConsensusDeterminedVersionAssignments copyWith(
          void Function(ConsensusDeterminedVersionAssignments) updates) =>
      super.copyWith((message) =>
              updates(message as ConsensusDeterminedVersionAssignments))
          as ConsensusDeterminedVersionAssignments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsensusDeterminedVersionAssignments create() =>
      ConsensusDeterminedVersionAssignments._();
  @$core.override
  ConsensusDeterminedVersionAssignments createEmptyInstance() => create();
  static $pb.PbList<ConsensusDeterminedVersionAssignments> createRepeated() =>
      $pb.PbList<ConsensusDeterminedVersionAssignments>();
  @$core.pragma('dart2js:noInline')
  static ConsensusDeterminedVersionAssignments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ConsensusDeterminedVersionAssignments>(create);
  static ConsensusDeterminedVersionAssignments? _defaultInstance;

  /// Version of this message
  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  /// Canceled transaction version assignment.
  @$pb.TagNumber(3)
  $pb.PbList<CanceledTransaction> get canceledTransactions => $_getList(1);
}

/// Update the set of valid JWKs.
class AuthenticatorStateUpdate extends $pb.GeneratedMessage {
  factory AuthenticatorStateUpdate({
    $fixnum.Int64? epoch,
    $fixnum.Int64? round,
    $core.Iterable<ActiveJwk>? newActiveJwks,
    $fixnum.Int64? authenticatorObjectInitialSharedVersion,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (round != null) result.round = round;
    if (newActiveJwks != null) result.newActiveJwks.addAll(newActiveJwks);
    if (authenticatorObjectInitialSharedVersion != null)
      result.authenticatorObjectInitialSharedVersion =
          authenticatorObjectInitialSharedVersion;
    return result;
  }

  AuthenticatorStateUpdate._();

  factory AuthenticatorStateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthenticatorStateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthenticatorStateUpdate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'round', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ActiveJwk>(
        3, _omitFieldNames ? '' : 'newActiveJwks', $pb.PbFieldType.PM,
        subBuilder: ActiveJwk.create)
    ..a<$fixnum.Int64>(
        4,
        _omitFieldNames ? '' : 'authenticatorObjectInitialSharedVersion',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticatorStateUpdate clone() =>
      AuthenticatorStateUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticatorStateUpdate copyWith(
          void Function(AuthenticatorStateUpdate) updates) =>
      super.copyWith((message) => updates(message as AuthenticatorStateUpdate))
          as AuthenticatorStateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthenticatorStateUpdate create() => AuthenticatorStateUpdate._();
  @$core.override
  AuthenticatorStateUpdate createEmptyInstance() => create();
  static $pb.PbList<AuthenticatorStateUpdate> createRepeated() =>
      $pb.PbList<AuthenticatorStateUpdate>();
  @$core.pragma('dart2js:noInline')
  static AuthenticatorStateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthenticatorStateUpdate>(create);
  static AuthenticatorStateUpdate? _defaultInstance;

  /// Epoch of the authenticator state update transaction.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// Consensus round of the authenticator state update.
  @$pb.TagNumber(2)
  $fixnum.Int64 get round => $_getI64(1);
  @$pb.TagNumber(2)
  set round($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRound() => $_has(1);
  @$pb.TagNumber(2)
  void clearRound() => $_clearField(2);

  /// Newly active JWKs.
  @$pb.TagNumber(3)
  $pb.PbList<ActiveJwk> get newActiveJwks => $_getList(2);

  /// The initial version of the authenticator object that it was shared at.
  @$pb.TagNumber(4)
  $fixnum.Int64 get authenticatorObjectInitialSharedVersion => $_getI64(3);
  @$pb.TagNumber(4)
  set authenticatorObjectInitialSharedVersion($fixnum.Int64 value) =>
      $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthenticatorObjectInitialSharedVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthenticatorObjectInitialSharedVersion() => $_clearField(4);
}

/// A new JWK.
class ActiveJwk extends $pb.GeneratedMessage {
  factory ActiveJwk({
    $6.JwkId? id,
    $6.Jwk? jwk,
    $fixnum.Int64? epoch,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (jwk != null) result.jwk = jwk;
    if (epoch != null) result.epoch = epoch;
    return result;
  }

  ActiveJwk._();

  factory ActiveJwk.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActiveJwk.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActiveJwk',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$6.JwkId>(1, _omitFieldNames ? '' : 'id', subBuilder: $6.JwkId.create)
    ..aOM<$6.Jwk>(2, _omitFieldNames ? '' : 'jwk', subBuilder: $6.Jwk.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActiveJwk clone() => ActiveJwk()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActiveJwk copyWith(void Function(ActiveJwk) updates) =>
      super.copyWith((message) => updates(message as ActiveJwk)) as ActiveJwk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActiveJwk create() => ActiveJwk._();
  @$core.override
  ActiveJwk createEmptyInstance() => create();
  static $pb.PbList<ActiveJwk> createRepeated() => $pb.PbList<ActiveJwk>();
  @$core.pragma('dart2js:noInline')
  static ActiveJwk getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActiveJwk>(create);
  static ActiveJwk? _defaultInstance;

  /// Identifier used to uniquely identify a JWK.
  @$pb.TagNumber(1)
  $6.JwkId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($6.JwkId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
  @$pb.TagNumber(1)
  $6.JwkId ensureId() => $_ensure(0);

  /// The JWK.
  @$pb.TagNumber(2)
  $6.Jwk get jwk => $_getN(1);
  @$pb.TagNumber(2)
  set jwk($6.Jwk value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasJwk() => $_has(1);
  @$pb.TagNumber(2)
  void clearJwk() => $_clearField(2);
  @$pb.TagNumber(2)
  $6.Jwk ensureJwk() => $_ensure(1);

  /// Most recent epoch in which the JWK was validated.
  @$pb.TagNumber(3)
  $fixnum.Int64 get epoch => $_getI64(2);
  @$pb.TagNumber(3)
  set epoch($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpoch() => $_clearField(3);
}

/// Set of operations run at the end of the epoch to close out the current epoch
/// and start the next one.
class EndOfEpochTransaction extends $pb.GeneratedMessage {
  factory EndOfEpochTransaction({
    $core.Iterable<EndOfEpochTransactionKind>? transactions,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  EndOfEpochTransaction._();

  factory EndOfEpochTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndOfEpochTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndOfEpochTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<EndOfEpochTransactionKind>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: EndOfEpochTransactionKind.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochTransaction clone() =>
      EndOfEpochTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochTransaction copyWith(
          void Function(EndOfEpochTransaction) updates) =>
      super.copyWith((message) => updates(message as EndOfEpochTransaction))
          as EndOfEpochTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndOfEpochTransaction create() => EndOfEpochTransaction._();
  @$core.override
  EndOfEpochTransaction createEmptyInstance() => create();
  static $pb.PbList<EndOfEpochTransaction> createRepeated() =>
      $pb.PbList<EndOfEpochTransaction>();
  @$core.pragma('dart2js:noInline')
  static EndOfEpochTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndOfEpochTransaction>(create);
  static EndOfEpochTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EndOfEpochTransactionKind> get transactions => $_getList(0);
}

enum EndOfEpochTransactionKind_Data {
  changeEpoch,
  authenticatorStateExpire,
  executionTimeObservations,
  bridgeChainId,
  bridgeObjectVersion,
  storageCost,
  notSet
}

/// Operation run at the end of an epoch.
class EndOfEpochTransactionKind extends $pb.GeneratedMessage {
  factory EndOfEpochTransactionKind({
    EndOfEpochTransactionKind_Kind? kind,
    ChangeEpoch? changeEpoch,
    AuthenticatorStateExpire? authenticatorStateExpire,
    ExecutionTimeObservations? executionTimeObservations,
    $core.String? bridgeChainId,
    $fixnum.Int64? bridgeObjectVersion,
    $fixnum.Int64? storageCost,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (changeEpoch != null) result.changeEpoch = changeEpoch;
    if (authenticatorStateExpire != null)
      result.authenticatorStateExpire = authenticatorStateExpire;
    if (executionTimeObservations != null)
      result.executionTimeObservations = executionTimeObservations;
    if (bridgeChainId != null) result.bridgeChainId = bridgeChainId;
    if (bridgeObjectVersion != null)
      result.bridgeObjectVersion = bridgeObjectVersion;
    if (storageCost != null) result.storageCost = storageCost;
    return result;
  }

  EndOfEpochTransactionKind._();

  factory EndOfEpochTransactionKind.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndOfEpochTransactionKind.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, EndOfEpochTransactionKind_Data>
      _EndOfEpochTransactionKind_DataByTag = {
    2: EndOfEpochTransactionKind_Data.changeEpoch,
    3: EndOfEpochTransactionKind_Data.authenticatorStateExpire,
    4: EndOfEpochTransactionKind_Data.executionTimeObservations,
    5: EndOfEpochTransactionKind_Data.bridgeChainId,
    6: EndOfEpochTransactionKind_Data.bridgeObjectVersion,
    7: EndOfEpochTransactionKind_Data.storageCost,
    0: EndOfEpochTransactionKind_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndOfEpochTransactionKind',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7])
    ..e<EndOfEpochTransactionKind_Kind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: EndOfEpochTransactionKind_Kind.KIND_UNKNOWN,
        valueOf: EndOfEpochTransactionKind_Kind.valueOf,
        enumValues: EndOfEpochTransactionKind_Kind.values)
    ..aOM<ChangeEpoch>(2, _omitFieldNames ? '' : 'changeEpoch',
        subBuilder: ChangeEpoch.create)
    ..aOM<AuthenticatorStateExpire>(
        3, _omitFieldNames ? '' : 'authenticatorStateExpire',
        subBuilder: AuthenticatorStateExpire.create)
    ..aOM<ExecutionTimeObservations>(
        4, _omitFieldNames ? '' : 'executionTimeObservations',
        subBuilder: ExecutionTimeObservations.create)
    ..aOS(5, _omitFieldNames ? '' : 'bridgeChainId')
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'bridgeObjectVersion', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'storageCost', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochTransactionKind clone() =>
      EndOfEpochTransactionKind()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochTransactionKind copyWith(
          void Function(EndOfEpochTransactionKind) updates) =>
      super.copyWith((message) => updates(message as EndOfEpochTransactionKind))
          as EndOfEpochTransactionKind;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndOfEpochTransactionKind create() => EndOfEpochTransactionKind._();
  @$core.override
  EndOfEpochTransactionKind createEmptyInstance() => create();
  static $pb.PbList<EndOfEpochTransactionKind> createRepeated() =>
      $pb.PbList<EndOfEpochTransactionKind>();
  @$core.pragma('dart2js:noInline')
  static EndOfEpochTransactionKind getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndOfEpochTransactionKind>(create);
  static EndOfEpochTransactionKind? _defaultInstance;

  EndOfEpochTransactionKind_Data whichData() =>
      _EndOfEpochTransactionKind_DataByTag[$_whichOneof(0)]!;
  void clearData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  EndOfEpochTransactionKind_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(EndOfEpochTransactionKind_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// End the epoch and start the next one.
  @$pb.TagNumber(2)
  ChangeEpoch get changeEpoch => $_getN(1);
  @$pb.TagNumber(2)
  set changeEpoch(ChangeEpoch value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChangeEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearChangeEpoch() => $_clearField(2);
  @$pb.TagNumber(2)
  ChangeEpoch ensureChangeEpoch() => $_ensure(1);

  /// Expire JWKs used for zklogin.
  @$pb.TagNumber(3)
  AuthenticatorStateExpire get authenticatorStateExpire => $_getN(2);
  @$pb.TagNumber(3)
  set authenticatorStateExpire(AuthenticatorStateExpire value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthenticatorStateExpire() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthenticatorStateExpire() => $_clearField(3);
  @$pb.TagNumber(3)
  AuthenticatorStateExpire ensureAuthenticatorStateExpire() => $_ensure(2);

  /// Execution time observations from the committee to preserve cross epoch
  @$pb.TagNumber(4)
  ExecutionTimeObservations get executionTimeObservations => $_getN(3);
  @$pb.TagNumber(4)
  set executionTimeObservations(ExecutionTimeObservations value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasExecutionTimeObservations() => $_has(3);
  @$pb.TagNumber(4)
  void clearExecutionTimeObservations() => $_clearField(4);
  @$pb.TagNumber(4)
  ExecutionTimeObservations ensureExecutionTimeObservations() => $_ensure(3);

  /// ChainId used when initializing the bridge
  @$pb.TagNumber(5)
  $core.String get bridgeChainId => $_getSZ(4);
  @$pb.TagNumber(5)
  set bridgeChainId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBridgeChainId() => $_has(4);
  @$pb.TagNumber(5)
  void clearBridgeChainId() => $_clearField(5);

  /// Start version of the Bridge object
  @$pb.TagNumber(6)
  $fixnum.Int64 get bridgeObjectVersion => $_getI64(5);
  @$pb.TagNumber(6)
  set bridgeObjectVersion($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBridgeObjectVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearBridgeObjectVersion() => $_clearField(6);

  /// Contains the end-of-epoch-computed storage cost for accumulator objects.
  @$pb.TagNumber(7)
  $fixnum.Int64 get storageCost => $_getI64(6);
  @$pb.TagNumber(7)
  set storageCost($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStorageCost() => $_has(6);
  @$pb.TagNumber(7)
  void clearStorageCost() => $_clearField(7);
}

/// Expire old JWKs.
class AuthenticatorStateExpire extends $pb.GeneratedMessage {
  factory AuthenticatorStateExpire({
    $fixnum.Int64? minEpoch,
    $fixnum.Int64? authenticatorObjectInitialSharedVersion,
  }) {
    final result = create();
    if (minEpoch != null) result.minEpoch = minEpoch;
    if (authenticatorObjectInitialSharedVersion != null)
      result.authenticatorObjectInitialSharedVersion =
          authenticatorObjectInitialSharedVersion;
    return result;
  }

  AuthenticatorStateExpire._();

  factory AuthenticatorStateExpire.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthenticatorStateExpire.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthenticatorStateExpire',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'minEpoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2,
        _omitFieldNames ? '' : 'authenticatorObjectInitialSharedVersion',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticatorStateExpire clone() =>
      AuthenticatorStateExpire()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticatorStateExpire copyWith(
          void Function(AuthenticatorStateExpire) updates) =>
      super.copyWith((message) => updates(message as AuthenticatorStateExpire))
          as AuthenticatorStateExpire;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthenticatorStateExpire create() => AuthenticatorStateExpire._();
  @$core.override
  AuthenticatorStateExpire createEmptyInstance() => create();
  static $pb.PbList<AuthenticatorStateExpire> createRepeated() =>
      $pb.PbList<AuthenticatorStateExpire>();
  @$core.pragma('dart2js:noInline')
  static AuthenticatorStateExpire getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthenticatorStateExpire>(create);
  static AuthenticatorStateExpire? _defaultInstance;

  /// Expire JWKs that have a lower epoch than this.
  @$pb.TagNumber(1)
  $fixnum.Int64 get minEpoch => $_getI64(0);
  @$pb.TagNumber(1)
  set minEpoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMinEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinEpoch() => $_clearField(1);

  /// The initial version of the authenticator object that it was shared at.
  @$pb.TagNumber(2)
  $fixnum.Int64 get authenticatorObjectInitialSharedVersion => $_getI64(1);
  @$pb.TagNumber(2)
  set authenticatorObjectInitialSharedVersion($fixnum.Int64 value) =>
      $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthenticatorObjectInitialSharedVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthenticatorObjectInitialSharedVersion() => $_clearField(2);
}

class ExecutionTimeObservations extends $pb.GeneratedMessage {
  factory ExecutionTimeObservations({
    $core.int? version,
    $core.Iterable<ExecutionTimeObservation>? observations,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (observations != null) result.observations.addAll(observations);
    return result;
  }

  ExecutionTimeObservations._();

  factory ExecutionTimeObservations.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionTimeObservations.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionTimeObservations',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..pc<ExecutionTimeObservation>(
        2, _omitFieldNames ? '' : 'observations', $pb.PbFieldType.PM,
        subBuilder: ExecutionTimeObservation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionTimeObservations clone() =>
      ExecutionTimeObservations()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionTimeObservations copyWith(
          void Function(ExecutionTimeObservations) updates) =>
      super.copyWith((message) => updates(message as ExecutionTimeObservations))
          as ExecutionTimeObservations;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionTimeObservations create() => ExecutionTimeObservations._();
  @$core.override
  ExecutionTimeObservations createEmptyInstance() => create();
  static $pb.PbList<ExecutionTimeObservations> createRepeated() =>
      $pb.PbList<ExecutionTimeObservations>();
  @$core.pragma('dart2js:noInline')
  static ExecutionTimeObservations getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionTimeObservations>(create);
  static ExecutionTimeObservations? _defaultInstance;

  /// Version of this ExecutionTimeObservations
  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ExecutionTimeObservation> get observations => $_getList(1);
}

class ExecutionTimeObservation extends $pb.GeneratedMessage {
  factory ExecutionTimeObservation({
    ExecutionTimeObservation_ExecutionTimeObservationKind? kind,
    MoveCall? moveEntryPoint,
    $core.Iterable<ValidatorExecutionTimeObservation>? validatorObservations,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (moveEntryPoint != null) result.moveEntryPoint = moveEntryPoint;
    if (validatorObservations != null)
      result.validatorObservations.addAll(validatorObservations);
    return result;
  }

  ExecutionTimeObservation._();

  factory ExecutionTimeObservation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionTimeObservation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionTimeObservation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<ExecutionTimeObservation_ExecutionTimeObservationKind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: ExecutionTimeObservation_ExecutionTimeObservationKind
            .EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN,
        valueOf: ExecutionTimeObservation_ExecutionTimeObservationKind.valueOf,
        enumValues:
            ExecutionTimeObservation_ExecutionTimeObservationKind.values)
    ..aOM<MoveCall>(2, _omitFieldNames ? '' : 'moveEntryPoint',
        subBuilder: MoveCall.create)
    ..pc<ValidatorExecutionTimeObservation>(
        3, _omitFieldNames ? '' : 'validatorObservations', $pb.PbFieldType.PM,
        subBuilder: ValidatorExecutionTimeObservation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionTimeObservation clone() =>
      ExecutionTimeObservation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionTimeObservation copyWith(
          void Function(ExecutionTimeObservation) updates) =>
      super.copyWith((message) => updates(message as ExecutionTimeObservation))
          as ExecutionTimeObservation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionTimeObservation create() => ExecutionTimeObservation._();
  @$core.override
  ExecutionTimeObservation createEmptyInstance() => create();
  static $pb.PbList<ExecutionTimeObservation> createRepeated() =>
      $pb.PbList<ExecutionTimeObservation>();
  @$core.pragma('dart2js:noInline')
  static ExecutionTimeObservation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionTimeObservation>(create);
  static ExecutionTimeObservation? _defaultInstance;

  @$pb.TagNumber(1)
  ExecutionTimeObservation_ExecutionTimeObservationKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(ExecutionTimeObservation_ExecutionTimeObservationKind value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  MoveCall get moveEntryPoint => $_getN(1);
  @$pb.TagNumber(2)
  set moveEntryPoint(MoveCall value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMoveEntryPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoveEntryPoint() => $_clearField(2);
  @$pb.TagNumber(2)
  MoveCall ensureMoveEntryPoint() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<ValidatorExecutionTimeObservation> get validatorObservations =>
      $_getList(2);
}

class ValidatorExecutionTimeObservation extends $pb.GeneratedMessage {
  factory ValidatorExecutionTimeObservation({
    $core.List<$core.int>? validator,
    $7.Duration? duration,
  }) {
    final result = create();
    if (validator != null) result.validator = validator;
    if (duration != null) result.duration = duration;
    return result;
  }

  ValidatorExecutionTimeObservation._();

  factory ValidatorExecutionTimeObservation.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidatorExecutionTimeObservation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidatorExecutionTimeObservation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'validator', $pb.PbFieldType.OY)
    ..aOM<$7.Duration>(2, _omitFieldNames ? '' : 'duration',
        subBuilder: $7.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorExecutionTimeObservation clone() =>
      ValidatorExecutionTimeObservation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorExecutionTimeObservation copyWith(
          void Function(ValidatorExecutionTimeObservation) updates) =>
      super.copyWith((message) =>
              updates(message as ValidatorExecutionTimeObservation))
          as ValidatorExecutionTimeObservation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorExecutionTimeObservation create() =>
      ValidatorExecutionTimeObservation._();
  @$core.override
  ValidatorExecutionTimeObservation createEmptyInstance() => create();
  static $pb.PbList<ValidatorExecutionTimeObservation> createRepeated() =>
      $pb.PbList<ValidatorExecutionTimeObservation>();
  @$core.pragma('dart2js:noInline')
  static ValidatorExecutionTimeObservation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidatorExecutionTimeObservation>(
          create);
  static ValidatorExecutionTimeObservation? _defaultInstance;

  /// Bls12381 public key of the validator
  @$pb.TagNumber(1)
  $core.List<$core.int> get validator => $_getN(0);
  @$pb.TagNumber(1)
  set validator($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValidator() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidator() => $_clearField(1);

  /// Duration of an execution observation
  @$pb.TagNumber(2)
  $7.Duration get duration => $_getN(1);
  @$pb.TagNumber(2)
  set duration($7.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDuration() => $_has(1);
  @$pb.TagNumber(2)
  void clearDuration() => $_clearField(2);
  @$pb.TagNumber(2)
  $7.Duration ensureDuration() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
