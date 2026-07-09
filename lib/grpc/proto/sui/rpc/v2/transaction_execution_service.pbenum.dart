// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction_execution_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// buf:lint:ignore ENUM_ZERO_VALUE_SUFFIX
class SimulateTransactionRequest_TransactionChecks extends $pb.ProtobufEnum {
  static const SimulateTransactionRequest_TransactionChecks ENABLED =
      SimulateTransactionRequest_TransactionChecks._(
          0, _omitEnumNames ? '' : 'ENABLED');
  static const SimulateTransactionRequest_TransactionChecks DISABLED =
      SimulateTransactionRequest_TransactionChecks._(
          1, _omitEnumNames ? '' : 'DISABLED');

  static const $core.List<SimulateTransactionRequest_TransactionChecks> values =
      <SimulateTransactionRequest_TransactionChecks>[
    ENABLED,
    DISABLED,
  ];

  static final $core.List<SimulateTransactionRequest_TransactionChecks?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SimulateTransactionRequest_TransactionChecks? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SimulateTransactionRequest_TransactionChecks._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
