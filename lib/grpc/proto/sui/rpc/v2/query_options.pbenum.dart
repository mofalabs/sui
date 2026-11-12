// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/query_options.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Ordering for the returned result set.
class Ordering extends $pb.ProtobufEnum {
  /// Return results in increasing cursor order.
  static const Ordering ORDERING_ASCENDING =
      Ordering._(0, _omitEnumNames ? '' : 'ORDERING_ASCENDING');

  /// Return results in decreasing cursor order.
  static const Ordering ORDERING_DESCENDING =
      Ordering._(1, _omitEnumNames ? '' : 'ORDERING_DESCENDING');

  static const $core.List<Ordering> values = <Ordering>[
    ORDERING_ASCENDING,
    ORDERING_DESCENDING,
  ];

  static final $core.List<Ordering?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static Ordering? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Ordering._(super.value, super.name);
}

/// Reason the server stopped this query response.
class QueryEndReason extends $pb.ProtobufEnum {
  /// The stop reason was not specified.
  static const QueryEndReason QUERY_END_REASON_UNKNOWN =
      QueryEndReason._(0, _omitEnumNames ? '' : 'QUERY_END_REASON_UNKNOWN');

  /// The response reached the requested item limit. The final matching item's
  /// frame carries `QueryEnd` and the final watermark. Resume from that frame's
  /// `Watermark.cursor` to continue reading the same effective interval.
  static const QueryEndReason QUERY_END_REASON_ITEM_LIMIT =
      QueryEndReason._(1, _omitEnumNames ? '' : 'QUERY_END_REASON_ITEM_LIMIT');

  /// The response reached the server's per-request bucket-fetch budget for
  /// filtered scans before reaching the effective interval bound. The terminal
  /// frame carries no item. Its watermark cursor is the authoritative scan
  /// frontier from which to resume.
  static const QueryEndReason QUERY_END_REASON_SCAN_LIMIT =
      QueryEndReason._(2, _omitEnumNames ? '' : 'QUERY_END_REASON_SCAN_LIMIT');

  /// The scan reached a requested checkpoint range bound. The terminal frame
  /// carries no item.
  static const QueryEndReason QUERY_END_REASON_CHECKPOINT_BOUND =
      QueryEndReason._(
          3, _omitEnumNames ? '' : 'QUERY_END_REASON_CHECKPOINT_BOUND');

  /// The scan reached an exclusive cursor bound. The terminal frame carries no
  /// item. Its watermark cursor represents that resolved bound without claiming
  /// that its containing checkpoint was fully covered.
  static const QueryEndReason QUERY_END_REASON_CURSOR_BOUND = QueryEndReason._(
      4, _omitEnumNames ? '' : 'QUERY_END_REASON_CURSOR_BOUND');

  /// The scan reached the currently indexed ledger tip. The terminal frame
  /// carries no item.
  static const QueryEndReason QUERY_END_REASON_LEDGER_TIP =
      QueryEndReason._(5, _omitEnumNames ? '' : 'QUERY_END_REASON_LEDGER_TIP');

  static const $core.List<QueryEndReason> values = <QueryEndReason>[
    QUERY_END_REASON_UNKNOWN,
    QUERY_END_REASON_ITEM_LIMIT,
    QUERY_END_REASON_SCAN_LIMIT,
    QUERY_END_REASON_CHECKPOINT_BOUND,
    QUERY_END_REASON_CURSOR_BOUND,
    QUERY_END_REASON_LEDGER_TIP,
  ];

  static final $core.List<QueryEndReason?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static QueryEndReason? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const QueryEndReason._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
