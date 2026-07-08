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

import 'package:protobuf/protobuf.dart' as $pb;

class TransactionExpiration_TransactionExpirationKind extends $pb.ProtobufEnum {
  static const TransactionExpiration_TransactionExpirationKind TRANSACTION_EXPIRATION_KIND_UNKNOWN = TransactionExpiration_TransactionExpirationKind._(0, _omitEnumNames ? '' : 'TRANSACTION_EXPIRATION_KIND_UNKNOWN');
  /// The transaction has no expiration.
  static const TransactionExpiration_TransactionExpirationKind NONE = TransactionExpiration_TransactionExpirationKind._(1, _omitEnumNames ? '' : 'NONE');
  /// Validators won't sign and execute transaction unless the expiration epoch
  /// is greater than or equal to the current epoch.
  static const TransactionExpiration_TransactionExpirationKind EPOCH = TransactionExpiration_TransactionExpirationKind._(2, _omitEnumNames ? '' : 'EPOCH');
  /// This variant enables gas payments from address balances.
  ///
  /// When transactions use address balances for gas payment instead of explicit gas coins,
  /// we lose the natural transaction uniqueness and replay prevention that comes from
  /// mutation of gas coin objects.
  ///
  /// By bounding expiration and providing a nonce, validators must only retain
  /// executed digests for the maximum possible expiry range to differentiate
  /// retries from unique transactions with otherwise identical inputs.
  static const TransactionExpiration_TransactionExpirationKind VALID_DURING = TransactionExpiration_TransactionExpirationKind._(3, _omitEnumNames ? '' : 'VALID_DURING');

  static const $core.List<TransactionExpiration_TransactionExpirationKind> values = <TransactionExpiration_TransactionExpirationKind> [
    TRANSACTION_EXPIRATION_KIND_UNKNOWN,
    NONE,
    EPOCH,
    VALID_DURING,
  ];

  static final $core.List<TransactionExpiration_TransactionExpirationKind?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TransactionExpiration_TransactionExpirationKind? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransactionExpiration_TransactionExpirationKind._(super.value, super.name);
}

class TransactionKind_Kind extends $pb.ProtobufEnum {
  static const TransactionKind_Kind KIND_UNKNOWN = TransactionKind_Kind._(0, _omitEnumNames ? '' : 'KIND_UNKNOWN');
  /// A user transaction comprised of a list of native commands and Move calls.
  static const TransactionKind_Kind PROGRAMMABLE_TRANSACTION = TransactionKind_Kind._(1, _omitEnumNames ? '' : 'PROGRAMMABLE_TRANSACTION');
  /// System transaction used to end an epoch.
  ///
  /// The `ChangeEpoch` variant is now deprecated (but the `ChangeEpoch` struct is still used by
  /// `EndOfEpochTransaction`).
  static const TransactionKind_Kind CHANGE_EPOCH = TransactionKind_Kind._(2, _omitEnumNames ? '' : 'CHANGE_EPOCH');
  /// Transaction used to initialize the chain state.
  ///
  /// Only valid if in the genesis checkpoint (0) and if this is the very first transaction ever
  /// executed on the chain.
  static const TransactionKind_Kind GENESIS = TransactionKind_Kind._(3, _omitEnumNames ? '' : 'GENESIS');
  /// V1 consensus commit update.
  static const TransactionKind_Kind CONSENSUS_COMMIT_PROLOGUE_V1 = TransactionKind_Kind._(4, _omitEnumNames ? '' : 'CONSENSUS_COMMIT_PROLOGUE_V1');
  /// Update set of valid JWKs used for zklogin.
  static const TransactionKind_Kind AUTHENTICATOR_STATE_UPDATE = TransactionKind_Kind._(5, _omitEnumNames ? '' : 'AUTHENTICATOR_STATE_UPDATE');
  /// Set of operations to run at the end of the epoch to close out the current epoch and start
  /// the next one.
  static const TransactionKind_Kind END_OF_EPOCH = TransactionKind_Kind._(6, _omitEnumNames ? '' : 'END_OF_EPOCH');
  /// Randomness update.
  static const TransactionKind_Kind RANDOMNESS_STATE_UPDATE = TransactionKind_Kind._(7, _omitEnumNames ? '' : 'RANDOMNESS_STATE_UPDATE');
  /// V2 consensus commit update.
  static const TransactionKind_Kind CONSENSUS_COMMIT_PROLOGUE_V2 = TransactionKind_Kind._(8, _omitEnumNames ? '' : 'CONSENSUS_COMMIT_PROLOGUE_V2');
  /// V3 consensus commit update.
  static const TransactionKind_Kind CONSENSUS_COMMIT_PROLOGUE_V3 = TransactionKind_Kind._(9, _omitEnumNames ? '' : 'CONSENSUS_COMMIT_PROLOGUE_V3');
  /// V4 consensus commit update.
  static const TransactionKind_Kind CONSENSUS_COMMIT_PROLOGUE_V4 = TransactionKind_Kind._(10, _omitEnumNames ? '' : 'CONSENSUS_COMMIT_PROLOGUE_V4');
  /// A system transaction comprised of a list of native commands and Move calls.
  static const TransactionKind_Kind PROGRAMMABLE_SYSTEM_TRANSACTION = TransactionKind_Kind._(11, _omitEnumNames ? '' : 'PROGRAMMABLE_SYSTEM_TRANSACTION');

  static const $core.List<TransactionKind_Kind> values = <TransactionKind_Kind> [
    KIND_UNKNOWN,
    PROGRAMMABLE_TRANSACTION,
    CHANGE_EPOCH,
    GENESIS,
    CONSENSUS_COMMIT_PROLOGUE_V1,
    AUTHENTICATOR_STATE_UPDATE,
    END_OF_EPOCH,
    RANDOMNESS_STATE_UPDATE,
    CONSENSUS_COMMIT_PROLOGUE_V2,
    CONSENSUS_COMMIT_PROLOGUE_V3,
    CONSENSUS_COMMIT_PROLOGUE_V4,
    PROGRAMMABLE_SYSTEM_TRANSACTION,
  ];

  static final $core.List<TransactionKind_Kind?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 11);
  static TransactionKind_Kind? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TransactionKind_Kind._(super.value, super.name);
}

class EndOfEpochTransactionKind_Kind extends $pb.ProtobufEnum {
  static const EndOfEpochTransactionKind_Kind KIND_UNKNOWN = EndOfEpochTransactionKind_Kind._(0, _omitEnumNames ? '' : 'KIND_UNKNOWN');
  /// End the epoch and start the next one.
  static const EndOfEpochTransactionKind_Kind CHANGE_EPOCH = EndOfEpochTransactionKind_Kind._(1, _omitEnumNames ? '' : 'CHANGE_EPOCH');
  /// Create and initialize the authenticator object used for zklogin.
  static const EndOfEpochTransactionKind_Kind AUTHENTICATOR_STATE_CREATE = EndOfEpochTransactionKind_Kind._(2, _omitEnumNames ? '' : 'AUTHENTICATOR_STATE_CREATE');
  /// Expire JWKs used for zklogin.
  static const EndOfEpochTransactionKind_Kind AUTHENTICATOR_STATE_EXPIRE = EndOfEpochTransactionKind_Kind._(3, _omitEnumNames ? '' : 'AUTHENTICATOR_STATE_EXPIRE');
  /// Create and initialize the randomness object.
  static const EndOfEpochTransactionKind_Kind RANDOMNESS_STATE_CREATE = EndOfEpochTransactionKind_Kind._(4, _omitEnumNames ? '' : 'RANDOMNESS_STATE_CREATE');
  /// Create and initialize the deny list object.
  static const EndOfEpochTransactionKind_Kind DENY_LIST_STATE_CREATE = EndOfEpochTransactionKind_Kind._(5, _omitEnumNames ? '' : 'DENY_LIST_STATE_CREATE');
  /// Create and initialize the bridge object.
  static const EndOfEpochTransactionKind_Kind BRIDGE_STATE_CREATE = EndOfEpochTransactionKind_Kind._(6, _omitEnumNames ? '' : 'BRIDGE_STATE_CREATE');
  /// Initialize the bridge committee.
  static const EndOfEpochTransactionKind_Kind BRIDGE_COMMITTEE_INIT = EndOfEpochTransactionKind_Kind._(7, _omitEnumNames ? '' : 'BRIDGE_COMMITTEE_INIT');
  /// Execution time observations from the committee to preserve cross epoch
  static const EndOfEpochTransactionKind_Kind STORE_EXECUTION_TIME_OBSERVATIONS = EndOfEpochTransactionKind_Kind._(8, _omitEnumNames ? '' : 'STORE_EXECUTION_TIME_OBSERVATIONS');
  /// Create the accumulator root object.
  static const EndOfEpochTransactionKind_Kind ACCUMULATOR_ROOT_CREATE = EndOfEpochTransactionKind_Kind._(9, _omitEnumNames ? '' : 'ACCUMULATOR_ROOT_CREATE');
  /// Create and initialize the Coin Registry object.
  static const EndOfEpochTransactionKind_Kind COIN_REGISTRY_CREATE = EndOfEpochTransactionKind_Kind._(10, _omitEnumNames ? '' : 'COIN_REGISTRY_CREATE');
  /// Create and initialize the Display Registry object.
  static const EndOfEpochTransactionKind_Kind DISPLAY_REGISTRY_CREATE = EndOfEpochTransactionKind_Kind._(11, _omitEnumNames ? '' : 'DISPLAY_REGISTRY_CREATE');
  /// Create and initialize the Address Alias State object.
  static const EndOfEpochTransactionKind_Kind ADDRESS_ALIAS_STATE_CREATE = EndOfEpochTransactionKind_Kind._(12, _omitEnumNames ? '' : 'ADDRESS_ALIAS_STATE_CREATE');
  /// Write the end-of-epoch-computed storage cost for accumulator objects.
  static const EndOfEpochTransactionKind_Kind WRITE_ACCUMULATOR_STORAGE_COST = EndOfEpochTransactionKind_Kind._(13, _omitEnumNames ? '' : 'WRITE_ACCUMULATOR_STORAGE_COST');

  static const $core.List<EndOfEpochTransactionKind_Kind> values = <EndOfEpochTransactionKind_Kind> [
    KIND_UNKNOWN,
    CHANGE_EPOCH,
    AUTHENTICATOR_STATE_CREATE,
    AUTHENTICATOR_STATE_EXPIRE,
    RANDOMNESS_STATE_CREATE,
    DENY_LIST_STATE_CREATE,
    BRIDGE_STATE_CREATE,
    BRIDGE_COMMITTEE_INIT,
    STORE_EXECUTION_TIME_OBSERVATIONS,
    ACCUMULATOR_ROOT_CREATE,
    COIN_REGISTRY_CREATE,
    DISPLAY_REGISTRY_CREATE,
    ADDRESS_ALIAS_STATE_CREATE,
    WRITE_ACCUMULATOR_STORAGE_COST,
  ];

  static final $core.List<EndOfEpochTransactionKind_Kind?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 13);
  static EndOfEpochTransactionKind_Kind? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EndOfEpochTransactionKind_Kind._(super.value, super.name);
}

class ExecutionTimeObservation_ExecutionTimeObservationKind extends $pb.ProtobufEnum {
  static const ExecutionTimeObservation_ExecutionTimeObservationKind EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN = ExecutionTimeObservation_ExecutionTimeObservationKind._(0, _omitEnumNames ? '' : 'EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind MOVE_ENTRY_POINT = ExecutionTimeObservation_ExecutionTimeObservationKind._(1, _omitEnumNames ? '' : 'MOVE_ENTRY_POINT');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind TRANSFER_OBJECTS = ExecutionTimeObservation_ExecutionTimeObservationKind._(2, _omitEnumNames ? '' : 'TRANSFER_OBJECTS');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind SPLIT_COINS = ExecutionTimeObservation_ExecutionTimeObservationKind._(3, _omitEnumNames ? '' : 'SPLIT_COINS');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind MERGE_COINS = ExecutionTimeObservation_ExecutionTimeObservationKind._(4, _omitEnumNames ? '' : 'MERGE_COINS');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind PUBLISH = ExecutionTimeObservation_ExecutionTimeObservationKind._(5, _omitEnumNames ? '' : 'PUBLISH');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind MAKE_MOVE_VECTOR = ExecutionTimeObservation_ExecutionTimeObservationKind._(6, _omitEnumNames ? '' : 'MAKE_MOVE_VECTOR');
  static const ExecutionTimeObservation_ExecutionTimeObservationKind UPGRADE = ExecutionTimeObservation_ExecutionTimeObservationKind._(7, _omitEnumNames ? '' : 'UPGRADE');

  static const $core.List<ExecutionTimeObservation_ExecutionTimeObservationKind> values = <ExecutionTimeObservation_ExecutionTimeObservationKind> [
    EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN,
    MOVE_ENTRY_POINT,
    TRANSFER_OBJECTS,
    SPLIT_COINS,
    MERGE_COINS,
    PUBLISH,
    MAKE_MOVE_VECTOR,
    UPGRADE,
  ];

  static final $core.List<ExecutionTimeObservation_ExecutionTimeObservationKind?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 7);
  static ExecutionTimeObservation_ExecutionTimeObservationKind? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExecutionTimeObservation_ExecutionTimeObservationKind._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
