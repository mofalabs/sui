// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/execution_status.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExecutionError_ExecutionErrorKind extends $pb.ProtobufEnum {
  static const ExecutionError_ExecutionErrorKind EXECUTION_ERROR_KIND_UNKNOWN =
      ExecutionError_ExecutionErrorKind._(
          0, _omitEnumNames ? '' : 'EXECUTION_ERROR_KIND_UNKNOWN');

  /// Insufficient gas.
  static const ExecutionError_ExecutionErrorKind INSUFFICIENT_GAS =
      ExecutionError_ExecutionErrorKind._(
          1, _omitEnumNames ? '' : 'INSUFFICIENT_GAS');

  /// Invalid `Gas` object.
  static const ExecutionError_ExecutionErrorKind INVALID_GAS_OBJECT =
      ExecutionError_ExecutionErrorKind._(
          2, _omitEnumNames ? '' : 'INVALID_GAS_OBJECT');

  /// Invariant violation.
  static const ExecutionError_ExecutionErrorKind INVARIANT_VIOLATION =
      ExecutionError_ExecutionErrorKind._(
          3, _omitEnumNames ? '' : 'INVARIANT_VIOLATION');

  /// Attempted to use feature that is not supported yet.
  static const ExecutionError_ExecutionErrorKind FEATURE_NOT_YET_SUPPORTED =
      ExecutionError_ExecutionErrorKind._(
          4, _omitEnumNames ? '' : 'FEATURE_NOT_YET_SUPPORTED');

  /// Move object is larger than the maximum allowed size.
  static const ExecutionError_ExecutionErrorKind OBJECT_TOO_BIG =
      ExecutionError_ExecutionErrorKind._(
          5, _omitEnumNames ? '' : 'OBJECT_TOO_BIG');

  /// Package is larger than the maximum allowed size.
  static const ExecutionError_ExecutionErrorKind PACKAGE_TOO_BIG =
      ExecutionError_ExecutionErrorKind._(
          6, _omitEnumNames ? '' : 'PACKAGE_TOO_BIG');

  /// Circular object ownership.
  static const ExecutionError_ExecutionErrorKind CIRCULAR_OBJECT_OWNERSHIP =
      ExecutionError_ExecutionErrorKind._(
          7, _omitEnumNames ? '' : 'CIRCULAR_OBJECT_OWNERSHIP');

  /// Insufficient coin balance for requested operation.
  static const ExecutionError_ExecutionErrorKind INSUFFICIENT_COIN_BALANCE =
      ExecutionError_ExecutionErrorKind._(
          8, _omitEnumNames ? '' : 'INSUFFICIENT_COIN_BALANCE');

  /// Coin balance overflowed an u64.
  static const ExecutionError_ExecutionErrorKind COIN_BALANCE_OVERFLOW =
      ExecutionError_ExecutionErrorKind._(
          9, _omitEnumNames ? '' : 'COIN_BALANCE_OVERFLOW');

  /// Publish error, non-zero address.
  /// The modules in the package must have their self-addresses set to zero.
  static const ExecutionError_ExecutionErrorKind
      PUBLISH_ERROR_NON_ZERO_ADDRESS = ExecutionError_ExecutionErrorKind._(
          10, _omitEnumNames ? '' : 'PUBLISH_ERROR_NON_ZERO_ADDRESS');

  /// Sui Move bytecode verification error.
  static const ExecutionError_ExecutionErrorKind SUI_MOVE_VERIFICATION_ERROR =
      ExecutionError_ExecutionErrorKind._(
          11, _omitEnumNames ? '' : 'SUI_MOVE_VERIFICATION_ERROR');

  /// Error from a non-abort instruction.
  /// Possible causes:
  ///     Arithmetic error, stack overflow, max value depth, or similar.
  static const ExecutionError_ExecutionErrorKind MOVE_PRIMITIVE_RUNTIME_ERROR =
      ExecutionError_ExecutionErrorKind._(
          12, _omitEnumNames ? '' : 'MOVE_PRIMITIVE_RUNTIME_ERROR');

  /// Move runtime abort.
  static const ExecutionError_ExecutionErrorKind MOVE_ABORT =
      ExecutionError_ExecutionErrorKind._(
          13, _omitEnumNames ? '' : 'MOVE_ABORT');

  /// Bytecode verification error.
  static const ExecutionError_ExecutionErrorKind
      VM_VERIFICATION_OR_DESERIALIZATION_ERROR =
      ExecutionError_ExecutionErrorKind._(
          14, _omitEnumNames ? '' : 'VM_VERIFICATION_OR_DESERIALIZATION_ERROR');

  /// MoveVm invariant violation.
  static const ExecutionError_ExecutionErrorKind VM_INVARIANT_VIOLATION =
      ExecutionError_ExecutionErrorKind._(
          15, _omitEnumNames ? '' : 'VM_INVARIANT_VIOLATION');

  /// Function not found.
  static const ExecutionError_ExecutionErrorKind FUNCTION_NOT_FOUND =
      ExecutionError_ExecutionErrorKind._(
          16, _omitEnumNames ? '' : 'FUNCTION_NOT_FOUND');

  /// Parity mismatch for Move function.
  /// The number of arguments does not match the number of parameters.
  static const ExecutionError_ExecutionErrorKind ARITY_MISMATCH =
      ExecutionError_ExecutionErrorKind._(
          17, _omitEnumNames ? '' : 'ARITY_MISMATCH');

  /// Type parity mismatch for Move function.
  /// Mismatch between the number of actual versus expected type arguments.
  static const ExecutionError_ExecutionErrorKind TYPE_ARITY_MISMATCH =
      ExecutionError_ExecutionErrorKind._(
          18, _omitEnumNames ? '' : 'TYPE_ARITY_MISMATCH');

  /// Non-entry function invoked. Move Call must start with an entry function.
  static const ExecutionError_ExecutionErrorKind NON_ENTRY_FUNCTION_INVOKED =
      ExecutionError_ExecutionErrorKind._(
          19, _omitEnumNames ? '' : 'NON_ENTRY_FUNCTION_INVOKED');

  /// Invalid command argument.
  static const ExecutionError_ExecutionErrorKind COMMAND_ARGUMENT_ERROR =
      ExecutionError_ExecutionErrorKind._(
          20, _omitEnumNames ? '' : 'COMMAND_ARGUMENT_ERROR');

  /// Type argument error.
  static const ExecutionError_ExecutionErrorKind TYPE_ARGUMENT_ERROR =
      ExecutionError_ExecutionErrorKind._(
          21, _omitEnumNames ? '' : 'TYPE_ARGUMENT_ERROR');

  /// Unused result without the drop ability.
  static const ExecutionError_ExecutionErrorKind UNUSED_VALUE_WITHOUT_DROP =
      ExecutionError_ExecutionErrorKind._(
          22, _omitEnumNames ? '' : 'UNUSED_VALUE_WITHOUT_DROP');

  /// Invalid public Move function signature.
  /// Unsupported return type for return value.
  static const ExecutionError_ExecutionErrorKind
      INVALID_PUBLIC_FUNCTION_RETURN_TYPE = ExecutionError_ExecutionErrorKind._(
          23, _omitEnumNames ? '' : 'INVALID_PUBLIC_FUNCTION_RETURN_TYPE');

  /// Invalid transfer object, object does not have public transfer.
  static const ExecutionError_ExecutionErrorKind INVALID_TRANSFER_OBJECT =
      ExecutionError_ExecutionErrorKind._(
          24, _omitEnumNames ? '' : 'INVALID_TRANSFER_OBJECT');

  /// Effects from the transaction are too large.
  static const ExecutionError_ExecutionErrorKind EFFECTS_TOO_LARGE =
      ExecutionError_ExecutionErrorKind._(
          25, _omitEnumNames ? '' : 'EFFECTS_TOO_LARGE');

  /// Publish or Upgrade is missing dependency.
  static const ExecutionError_ExecutionErrorKind
      PUBLISH_UPGRADE_MISSING_DEPENDENCY = ExecutionError_ExecutionErrorKind._(
          26, _omitEnumNames ? '' : 'PUBLISH_UPGRADE_MISSING_DEPENDENCY');

  /// Publish or upgrade dependency downgrade.
  ///
  /// Indirect (transitive) dependency of published or upgraded package has been assigned an
  /// on-chain version that is less than the version required by one of the package's
  /// transitive dependencies.
  static const ExecutionError_ExecutionErrorKind
      PUBLISH_UPGRADE_DEPENDENCY_DOWNGRADE =
      ExecutionError_ExecutionErrorKind._(
          27, _omitEnumNames ? '' : 'PUBLISH_UPGRADE_DEPENDENCY_DOWNGRADE');

  /// Invalid package upgrade.
  static const ExecutionError_ExecutionErrorKind PACKAGE_UPGRADE_ERROR =
      ExecutionError_ExecutionErrorKind._(
          28, _omitEnumNames ? '' : 'PACKAGE_UPGRADE_ERROR');

  /// Indicates the transaction tried to write objects too large to storage.
  static const ExecutionError_ExecutionErrorKind WRITTEN_OBJECTS_TOO_LARGE =
      ExecutionError_ExecutionErrorKind._(
          29, _omitEnumNames ? '' : 'WRITTEN_OBJECTS_TOO_LARGE');

  /// Certificate is on the deny list.
  static const ExecutionError_ExecutionErrorKind CERTIFICATE_DENIED =
      ExecutionError_ExecutionErrorKind._(
          30, _omitEnumNames ? '' : 'CERTIFICATE_DENIED');

  /// Sui Move bytecode verification timed out.
  static const ExecutionError_ExecutionErrorKind
      SUI_MOVE_VERIFICATION_TIMEDOUT = ExecutionError_ExecutionErrorKind._(
          31, _omitEnumNames ? '' : 'SUI_MOVE_VERIFICATION_TIMEDOUT');

  /// The requested consensus object operation is not allowed.
  static const ExecutionError_ExecutionErrorKind
      CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED =
      ExecutionError_ExecutionErrorKind._(
          32, _omitEnumNames ? '' : 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED');

  /// Requested consensus object has been deleted.
  static const ExecutionError_ExecutionErrorKind INPUT_OBJECT_DELETED =
      ExecutionError_ExecutionErrorKind._(
          33, _omitEnumNames ? '' : 'INPUT_OBJECT_DELETED');

  /// Certificate is canceled due to congestion on consensus objects.
  static const ExecutionError_ExecutionErrorKind
      EXECUTION_CANCELED_DUE_TO_CONSENSUS_OBJECT_CONGESTION =
      ExecutionError_ExecutionErrorKind._(
          34,
          _omitEnumNames
              ? ''
              : 'EXECUTION_CANCELED_DUE_TO_CONSENSUS_OBJECT_CONGESTION');

  /// Address is denied for this coin type.
  static const ExecutionError_ExecutionErrorKind ADDRESS_DENIED_FOR_COIN =
      ExecutionError_ExecutionErrorKind._(
          35, _omitEnumNames ? '' : 'ADDRESS_DENIED_FOR_COIN');

  /// Coin type is globally paused for use.
  static const ExecutionError_ExecutionErrorKind COIN_TYPE_GLOBAL_PAUSE =
      ExecutionError_ExecutionErrorKind._(
          36, _omitEnumNames ? '' : 'COIN_TYPE_GLOBAL_PAUSE');

  /// Certificate is canceled because randomness could not be generated this epoch.
  static const ExecutionError_ExecutionErrorKind
      EXECUTION_CANCELED_DUE_TO_RANDOMNESS_UNAVAILABLE =
      ExecutionError_ExecutionErrorKind._(
          37,
          _omitEnumNames
              ? ''
              : 'EXECUTION_CANCELED_DUE_TO_RANDOMNESS_UNAVAILABLE');

  /// Move vector element (passed to MakeMoveVec) with size {value_size} is larger \
  /// than the maximum size {max_scaled_size}. Note that this maximum is scaled based on the \
  /// type of the vector element.
  static const ExecutionError_ExecutionErrorKind MOVE_VECTOR_ELEM_TOO_BIG =
      ExecutionError_ExecutionErrorKind._(
          38, _omitEnumNames ? '' : 'MOVE_VECTOR_ELEM_TOO_BIG');

  /// Move value (possibly an upgrade ticket or a dev-inspect value) with size {value_size} \
  /// is larger than the maximum size  {max_scaled_size}. Note that this maximum is scaled based \
  /// on the type of the value.
  static const ExecutionError_ExecutionErrorKind MOVE_RAW_VALUE_TOO_BIG =
      ExecutionError_ExecutionErrorKind._(
          39, _omitEnumNames ? '' : 'MOVE_RAW_VALUE_TOO_BIG');

  /// A valid linkage was unable to be determined for the transaction or one of its commands.
  static const ExecutionError_ExecutionErrorKind INVALID_LINKAGE =
      ExecutionError_ExecutionErrorKind._(
          40, _omitEnumNames ? '' : 'INVALID_LINKAGE');

  /// Insufficient funds for transaction withdrawal
  static const ExecutionError_ExecutionErrorKind
      INSUFFICIENT_FUNDS_FOR_WITHDRAW = ExecutionError_ExecutionErrorKind._(
          41, _omitEnumNames ? '' : 'INSUFFICIENT_FUNDS_FOR_WITHDRAW');

  /// An input object with non-exclusive write mutability was modified
  static const ExecutionError_ExecutionErrorKind
      NON_EXCLUSIVE_WRITE_INPUT_OBJECT_MODIFIED =
      ExecutionError_ExecutionErrorKind._(42,
          _omitEnumNames ? '' : 'NON_EXCLUSIVE_WRITE_INPUT_OBJECT_MODIFIED');

  static const $core.List<ExecutionError_ExecutionErrorKind> values =
      <ExecutionError_ExecutionErrorKind>[
    EXECUTION_ERROR_KIND_UNKNOWN,
    INSUFFICIENT_GAS,
    INVALID_GAS_OBJECT,
    INVARIANT_VIOLATION,
    FEATURE_NOT_YET_SUPPORTED,
    OBJECT_TOO_BIG,
    PACKAGE_TOO_BIG,
    CIRCULAR_OBJECT_OWNERSHIP,
    INSUFFICIENT_COIN_BALANCE,
    COIN_BALANCE_OVERFLOW,
    PUBLISH_ERROR_NON_ZERO_ADDRESS,
    SUI_MOVE_VERIFICATION_ERROR,
    MOVE_PRIMITIVE_RUNTIME_ERROR,
    MOVE_ABORT,
    VM_VERIFICATION_OR_DESERIALIZATION_ERROR,
    VM_INVARIANT_VIOLATION,
    FUNCTION_NOT_FOUND,
    ARITY_MISMATCH,
    TYPE_ARITY_MISMATCH,
    NON_ENTRY_FUNCTION_INVOKED,
    COMMAND_ARGUMENT_ERROR,
    TYPE_ARGUMENT_ERROR,
    UNUSED_VALUE_WITHOUT_DROP,
    INVALID_PUBLIC_FUNCTION_RETURN_TYPE,
    INVALID_TRANSFER_OBJECT,
    EFFECTS_TOO_LARGE,
    PUBLISH_UPGRADE_MISSING_DEPENDENCY,
    PUBLISH_UPGRADE_DEPENDENCY_DOWNGRADE,
    PACKAGE_UPGRADE_ERROR,
    WRITTEN_OBJECTS_TOO_LARGE,
    CERTIFICATE_DENIED,
    SUI_MOVE_VERIFICATION_TIMEDOUT,
    CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED,
    INPUT_OBJECT_DELETED,
    EXECUTION_CANCELED_DUE_TO_CONSENSUS_OBJECT_CONGESTION,
    ADDRESS_DENIED_FOR_COIN,
    COIN_TYPE_GLOBAL_PAUSE,
    EXECUTION_CANCELED_DUE_TO_RANDOMNESS_UNAVAILABLE,
    MOVE_VECTOR_ELEM_TOO_BIG,
    MOVE_RAW_VALUE_TOO_BIG,
    INVALID_LINKAGE,
    INSUFFICIENT_FUNDS_FOR_WITHDRAW,
    NON_EXCLUSIVE_WRITE_INPUT_OBJECT_MODIFIED,
  ];

  static final $core.List<ExecutionError_ExecutionErrorKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 42);
  static ExecutionError_ExecutionErrorKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExecutionError_ExecutionErrorKind._(super.value, super.name);
}

class CommandArgumentError_CommandArgumentErrorKind extends $pb.ProtobufEnum {
  static const CommandArgumentError_CommandArgumentErrorKind
      COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN =
      CommandArgumentError_CommandArgumentErrorKind._(
          0, _omitEnumNames ? '' : 'COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN');

  /// The type of the value does not match the expected type.
  static const CommandArgumentError_CommandArgumentErrorKind TYPE_MISMATCH =
      CommandArgumentError_CommandArgumentErrorKind._(
          1, _omitEnumNames ? '' : 'TYPE_MISMATCH');

  /// The argument cannot be deserialized into a value of the specified type.
  static const CommandArgumentError_CommandArgumentErrorKind INVALID_BCS_BYTES =
      CommandArgumentError_CommandArgumentErrorKind._(
          2, _omitEnumNames ? '' : 'INVALID_BCS_BYTES');

  /// The argument cannot be instantiated from raw bytes.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_USAGE_OF_PURE_ARGUMENT =
      CommandArgumentError_CommandArgumentErrorKind._(
          3, _omitEnumNames ? '' : 'INVALID_USAGE_OF_PURE_ARGUMENT');

  /// Invalid argument to private entry function.
  /// Private entry functions cannot take arguments from other Move functions.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_ARGUMENT_TO_PRIVATE_ENTRY_FUNCTION =
      CommandArgumentError_CommandArgumentErrorKind._(4,
          _omitEnumNames ? '' : 'INVALID_ARGUMENT_TO_PRIVATE_ENTRY_FUNCTION');

  /// Out of bounds access to input or results.
  ///
  /// `index` field will be set indicating the invalid index value.
  static const CommandArgumentError_CommandArgumentErrorKind
      INDEX_OUT_OF_BOUNDS = CommandArgumentError_CommandArgumentErrorKind._(
          5, _omitEnumNames ? '' : 'INDEX_OUT_OF_BOUNDS');

  /// Out of bounds access to subresult.
  ///
  /// `index` and `subresult` fields will be set indicating the invalid index value.
  static const CommandArgumentError_CommandArgumentErrorKind
      SECONDARY_INDEX_OUT_OF_BOUNDS =
      CommandArgumentError_CommandArgumentErrorKind._(
          6, _omitEnumNames ? '' : 'SECONDARY_INDEX_OUT_OF_BOUNDS');

  /// Invalid usage of result.
  /// Expected a single result but found either no return value or multiple.
  /// `index` field will be set indicating the invalid index value.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_RESULT_ARITY = CommandArgumentError_CommandArgumentErrorKind._(
          7, _omitEnumNames ? '' : 'INVALID_RESULT_ARITY');

  /// Invalid usage of gas coin.
  /// The gas coin can only be used by-value with a `TransferObject` command.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_GAS_COIN_USAGE = CommandArgumentError_CommandArgumentErrorKind._(
          8, _omitEnumNames ? '' : 'INVALID_GAS_COIN_USAGE');

  /// Invalid usage of Move value.
  ///    - Mutably borrowed values require unique usage.
  ///    - Immutably borrowed values cannot be taken or borrowed mutably.
  ///    - Taken values cannot be used again.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_VALUE_USAGE = CommandArgumentError_CommandArgumentErrorKind._(
          9, _omitEnumNames ? '' : 'INVALID_VALUE_USAGE');

  /// Immutable objects cannot be passed by-value.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_OBJECT_BY_VALUE = CommandArgumentError_CommandArgumentErrorKind._(
          10, _omitEnumNames ? '' : 'INVALID_OBJECT_BY_VALUE');

  /// Immutable objects cannot be passed by mutable reference, `&mut`.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_OBJECT_BY_MUT_REF =
      CommandArgumentError_CommandArgumentErrorKind._(
          11, _omitEnumNames ? '' : 'INVALID_OBJECT_BY_MUT_REF');

  /// Consensus object operations such as wrapping, freezing, or converting to owned are not
  /// allowed.
  static const CommandArgumentError_CommandArgumentErrorKind
      CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED =
      CommandArgumentError_CommandArgumentErrorKind._(
          12, _omitEnumNames ? '' : 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED');

  /// Invalid argument arity. Expected a single argument but found a result that expanded to
  /// multiple arguments.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_ARGUMENT_ARITY = CommandArgumentError_CommandArgumentErrorKind._(
          13, _omitEnumNames ? '' : 'INVALID_ARGUMENT_ARITY');

  /// Object passed to TransferObject does not have public transfer, i.e. the `store` ability
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_TRANSFER_OBJECT = CommandArgumentError_CommandArgumentErrorKind._(
          14, _omitEnumNames ? '' : 'INVALID_TRANSFER_OBJECT');

  /// First argument to MakeMoveVec is not an object. If no type is specified for MakeMoveVec,
  /// all arguments must be the same object type.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_MAKE_MOVE_VEC_NON_OBJECT_ARGUMENT =
      CommandArgumentError_CommandArgumentErrorKind._(15,
          _omitEnumNames ? '' : 'INVALID_MAKE_MOVE_VEC_NON_OBJECT_ARGUMENT');

  /// Specified argument location does not have a value and cannot be used
  static const CommandArgumentError_CommandArgumentErrorKind
      ARGUMENT_WITHOUT_VALUE = CommandArgumentError_CommandArgumentErrorKind._(
          16, _omitEnumNames ? '' : 'ARGUMENT_WITHOUT_VALUE');

  /// Cannot move a borrowed value. The value's type does resulted in this argument usage being
  /// inferred as a move. This is likely due to the type not having the `copy` ability; although
  /// in rare cases, it could also be this is the last usage of a value without the `drop`
  /// ability.
  static const CommandArgumentError_CommandArgumentErrorKind
      CANNOT_MOVE_BORROWED_VALUE =
      CommandArgumentError_CommandArgumentErrorKind._(
          17, _omitEnumNames ? '' : 'CANNOT_MOVE_BORROWED_VALUE');

  /// Cannot write to an argument location that is still borrowed, and where that borrow is an
  /// extension of that reference. This is likely due to this argument being used in a Move call
  /// that returns a reference, and that reference is used in a later command.
  static const CommandArgumentError_CommandArgumentErrorKind
      CANNOT_WRITE_TO_EXTENDED_REFERENCE =
      CommandArgumentError_CommandArgumentErrorKind._(
          18, _omitEnumNames ? '' : 'CANNOT_WRITE_TO_EXTENDED_REFERENCE');

  /// The argument specified cannot be used as a reference argument in the Move call. Either the
  /// argument is a mutable reference and it conflicts with another argument to the call, or the
  /// argument is mutable and another reference extends it and will be used in a later command.
  static const CommandArgumentError_CommandArgumentErrorKind
      INVALID_REFERENCE_ARGUMENT =
      CommandArgumentError_CommandArgumentErrorKind._(
          19, _omitEnumNames ? '' : 'INVALID_REFERENCE_ARGUMENT');

  static const $core.List<CommandArgumentError_CommandArgumentErrorKind>
      values = <CommandArgumentError_CommandArgumentErrorKind>[
    COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN,
    TYPE_MISMATCH,
    INVALID_BCS_BYTES,
    INVALID_USAGE_OF_PURE_ARGUMENT,
    INVALID_ARGUMENT_TO_PRIVATE_ENTRY_FUNCTION,
    INDEX_OUT_OF_BOUNDS,
    SECONDARY_INDEX_OUT_OF_BOUNDS,
    INVALID_RESULT_ARITY,
    INVALID_GAS_COIN_USAGE,
    INVALID_VALUE_USAGE,
    INVALID_OBJECT_BY_VALUE,
    INVALID_OBJECT_BY_MUT_REF,
    CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED,
    INVALID_ARGUMENT_ARITY,
    INVALID_TRANSFER_OBJECT,
    INVALID_MAKE_MOVE_VEC_NON_OBJECT_ARGUMENT,
    ARGUMENT_WITHOUT_VALUE,
    CANNOT_MOVE_BORROWED_VALUE,
    CANNOT_WRITE_TO_EXTENDED_REFERENCE,
    INVALID_REFERENCE_ARGUMENT,
  ];

  static final $core.List<CommandArgumentError_CommandArgumentErrorKind?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 19);
  static CommandArgumentError_CommandArgumentErrorKind? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CommandArgumentError_CommandArgumentErrorKind._(
      super.value, super.name);
}

class PackageUpgradeError_PackageUpgradeErrorKind extends $pb.ProtobufEnum {
  static const PackageUpgradeError_PackageUpgradeErrorKind
      PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN =
      PackageUpgradeError_PackageUpgradeErrorKind._(
          0, _omitEnumNames ? '' : 'PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN');

  /// Unable to fetch package.
  static const PackageUpgradeError_PackageUpgradeErrorKind
      UNABLE_TO_FETCH_PACKAGE = PackageUpgradeError_PackageUpgradeErrorKind._(
          1, _omitEnumNames ? '' : 'UNABLE_TO_FETCH_PACKAGE');

  /// Object is not a package.
  static const PackageUpgradeError_PackageUpgradeErrorKind NOT_A_PACKAGE =
      PackageUpgradeError_PackageUpgradeErrorKind._(
          2, _omitEnumNames ? '' : 'NOT_A_PACKAGE');

  /// Package upgrade is incompatible with previous version.
  static const PackageUpgradeError_PackageUpgradeErrorKind
      INCOMPATIBLE_UPGRADE = PackageUpgradeError_PackageUpgradeErrorKind._(
          3, _omitEnumNames ? '' : 'INCOMPATIBLE_UPGRADE');

  /// Digest in upgrade ticket and computed digest differ.
  static const PackageUpgradeError_PackageUpgradeErrorKind
      DIGEST_DOES_NOT_MATCH = PackageUpgradeError_PackageUpgradeErrorKind._(
          4, _omitEnumNames ? '' : 'DIGEST_DOES_NOT_MATCH');

  /// Upgrade policy is not valid.
  static const PackageUpgradeError_PackageUpgradeErrorKind
      UNKNOWN_UPGRADE_POLICY = PackageUpgradeError_PackageUpgradeErrorKind._(
          5, _omitEnumNames ? '' : 'UNKNOWN_UPGRADE_POLICY');

  /// Package ID does not match `PackageId` in upgrade ticket.
  static const PackageUpgradeError_PackageUpgradeErrorKind
      PACKAGE_ID_DOES_NOT_MATCH = PackageUpgradeError_PackageUpgradeErrorKind._(
          6, _omitEnumNames ? '' : 'PACKAGE_ID_DOES_NOT_MATCH');

  static const $core.List<PackageUpgradeError_PackageUpgradeErrorKind> values =
      <PackageUpgradeError_PackageUpgradeErrorKind>[
    PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN,
    UNABLE_TO_FETCH_PACKAGE,
    NOT_A_PACKAGE,
    INCOMPATIBLE_UPGRADE,
    DIGEST_DOES_NOT_MATCH,
    UNKNOWN_UPGRADE_POLICY,
    PACKAGE_ID_DOES_NOT_MATCH,
  ];

  static final $core.List<PackageUpgradeError_PackageUpgradeErrorKind?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 6);
  static PackageUpgradeError_PackageUpgradeErrorKind? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PackageUpgradeError_PackageUpgradeErrorKind._(super.value, super.name);
}

class TypeArgumentError_TypeArgumentErrorKind extends $pb.ProtobufEnum {
  static const TypeArgumentError_TypeArgumentErrorKind
      TYPE_ARGUMENT_ERROR_KIND_UNKNOWN =
      TypeArgumentError_TypeArgumentErrorKind._(
          0, _omitEnumNames ? '' : 'TYPE_ARGUMENT_ERROR_KIND_UNKNOWN');

  /// A type was not found in the module specified.
  static const TypeArgumentError_TypeArgumentErrorKind TYPE_NOT_FOUND =
      TypeArgumentError_TypeArgumentErrorKind._(
          1, _omitEnumNames ? '' : 'TYPE_NOT_FOUND');

  /// A type provided did not match the specified constraint.
  static const TypeArgumentError_TypeArgumentErrorKind
      CONSTRAINT_NOT_SATISFIED = TypeArgumentError_TypeArgumentErrorKind._(
          2, _omitEnumNames ? '' : 'CONSTRAINT_NOT_SATISFIED');

  static const $core.List<TypeArgumentError_TypeArgumentErrorKind> values =
      <TypeArgumentError_TypeArgumentErrorKind>[
    TYPE_ARGUMENT_ERROR_KIND_UNKNOWN,
    TYPE_NOT_FOUND,
    CONSTRAINT_NOT_SATISFIED,
  ];

  static final $core.List<TypeArgumentError_TypeArgumentErrorKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TypeArgumentError_TypeArgumentErrorKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TypeArgumentError_TypeArgumentErrorKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
