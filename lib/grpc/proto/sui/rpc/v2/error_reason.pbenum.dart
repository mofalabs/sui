// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/error_reason.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Error reasons in the `sui.io` error domain, used as the `reason` of a
/// `google.rpc.ErrorInfo` or of a `google.rpc.BadRequest.FieldViolation`.
class ErrorReason extends $pb.ProtobufEnum {
  static const ErrorReason ERROR_REASON_UNKNOWN =
      ErrorReason._(0, _omitEnumNames ? '' : 'ERROR_REASON_UNKNOWN');
  static const ErrorReason FIELD_INVALID =
      ErrorReason._(1, _omitEnumNames ? '' : 'FIELD_INVALID');
  static const ErrorReason FIELD_MISSING =
      ErrorReason._(2, _omitEnumNames ? '' : 'FIELD_MISSING');

  /// Gas selection could not find enough SUI to cover the gas budget.
  /// `SimulateTransaction` returns this with `INVALID_ARGUMENT`. Gas selection
  /// runs only when `do_gas_selection` is set, `checks` is not `DISABLED`, and
  /// the transaction has no gas payment objects. When the server estimates the
  /// budget and the transaction fails in that estimation, `SimulateTransaction`
  /// returns `TRANSACTION_EXECUTION_FAILED` instead of this error, so with an
  /// estimated budget this reason means the transaction executed successfully
  /// in simulation.
  ///
  /// Example of an ErrorInfo when the gas owner holds a single 2246360 MIST
  /// coin, has no address balance, and the transaction needs a budget of
  /// 8924024 MIST:
  ///
  ///     { "reason": "INSUFFICIENT_GAS_BALANCE",
  ///       "domain": "sui.io",
  ///       "metadata": {
  ///         "owner": "0x0000000000000000000000000000000000000000000000000000000000000123",
  ///         "requiredBudget": "8924024",
  ///         "coinBalance": "2246360",
  ///         "addressBalance": "0"
  ///       }
  ///     }
  ///
  /// Metadata, with amounts in MIST as decimal strings:
  /// - `owner`: the gas owner's address, as "0x" followed by 64 hex digits.
  /// - `requiredBudget`: the gas budget the transaction needs. When the
  ///   request leaves the budget unset, this is the server's estimate plus the
  ///   cost of loading every coin counted in `coinBalance` beyond the first;
  ///   otherwise it is the budget from the request. An estimated
  ///   `requiredBudget` depends on how many coins the gas owner holds: when
  ///   the owner already holds coins, sending it a new coin raises
  ///   `requiredBudget` by up to the cost of loading one more coin. A new coin
  ///   worth `requiredBudget` covers that increase unless `coinBalance` is
  ///   less than the cost of loading one coin; a new coin worth only
  ///   `requiredBudget` minus `coinBalance` can fall short.
  /// - `coinBalance`: total of the gas owner's `Coin<SUI>` objects considered
  ///   by gas selection: owned, non-consensus coins not already used as
  ///   transaction inputs, largest first, up to the protocol's maximum number
  ///   of gas payment objects.
  /// - `addressBalance`: the gas owner's SUI address balance remaining after
  ///   the transaction's own explicit SUI withdrawals from the gas owner; "0"
  ///   if there is none.
  ///
  /// The two balances are reported separately because they combine
  /// differently. When the transaction uses the gas coin (an `Argument` of kind
  /// `GAS`), coins and address balance are combined to pay for gas. Otherwise
  /// they are never combined: the address balance pays for gas only if it
  /// alone covers the budget before coin-loading costs, which is at most
  /// `requiredBudget`; if it does not, the coins alone must cover
  /// `requiredBudget`.
  static const ErrorReason INSUFFICIENT_GAS_BALANCE =
      ErrorReason._(3, _omitEnumNames ? '' : 'INSUFFICIENT_GAS_BALANCE');

  /// The transaction failed while executing in simulation. `SimulateTransaction`
  /// returns this with `INVALID_ARGUMENT` when it estimates the budget, the
  /// transaction fails in that estimation, and gas selection then cannot cover
  /// the budget. It is returned instead of the `INSUFFICIENT_GAS_BALANCE`
  /// reason in that case because the transaction fails even with its gas paid
  /// for, so the gas budget is not what stops it; `kind` says what does. Some
  /// kinds can still be fixed by adding funds: for example,
  /// `INSUFFICIENT_FUNDS_FOR_WITHDRAW` means a balance the transaction
  /// withdraws from holds too little. `INSUFFICIENT_GAS` cannot: the estimation
  /// runs with the maximum gas budget, so it means the transaction needs more
  /// gas than any budget allows. A gas owner that can cover the budget instead
  /// gets a successful response whose `effects.status.error` describes the
  /// failure.
  ///
  /// The status details also carry the `ExecutionError`, in the same form as
  /// `effects.status.error`.
  ///
  /// Example of an ErrorInfo for a Move abort in the first command:
  ///
  ///     { "reason": "TRANSACTION_EXECUTION_FAILED",
  ///       "domain": "sui.io",
  ///       "metadata": {
  ///         "kind": "MOVE_ABORT",
  ///         "command": "0"
  ///       }
  ///     }
  ///
  /// Metadata:
  /// - `kind`: the failure's `ExecutionError.ExecutionErrorKind` name.
  /// - `command`: index of the command that failed, as a decimal string, or
  ///   "" if no single command failed.
  static const ErrorReason TRANSACTION_EXECUTION_FAILED =
      ErrorReason._(4, _omitEnumNames ? '' : 'TRANSACTION_EXECUTION_FAILED');

  static const $core.List<ErrorReason> values = <ErrorReason>[
    ERROR_REASON_UNKNOWN,
    FIELD_INVALID,
    FIELD_MISSING,
    INSUFFICIENT_GAS_BALANCE,
    TRANSACTION_EXECUTION_FAILED,
  ];

  static final $core.List<ErrorReason?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ErrorReason? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ErrorReason._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
