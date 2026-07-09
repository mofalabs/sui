// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/owner.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Owner_OwnerKind extends $pb.ProtobufEnum {
  static const Owner_OwnerKind OWNER_KIND_UNKNOWN =
      Owner_OwnerKind._(0, _omitEnumNames ? '' : 'OWNER_KIND_UNKNOWN');
  static const Owner_OwnerKind ADDRESS =
      Owner_OwnerKind._(1, _omitEnumNames ? '' : 'ADDRESS');
  static const Owner_OwnerKind OBJECT =
      Owner_OwnerKind._(2, _omitEnumNames ? '' : 'OBJECT');
  static const Owner_OwnerKind SHARED =
      Owner_OwnerKind._(3, _omitEnumNames ? '' : 'SHARED');
  static const Owner_OwnerKind IMMUTABLE =
      Owner_OwnerKind._(4, _omitEnumNames ? '' : 'IMMUTABLE');
  static const Owner_OwnerKind CONSENSUS_ADDRESS =
      Owner_OwnerKind._(5, _omitEnumNames ? '' : 'CONSENSUS_ADDRESS');

  static const $core.List<Owner_OwnerKind> values = <Owner_OwnerKind>[
    OWNER_KIND_UNKNOWN,
    ADDRESS,
    OBJECT,
    SHARED,
    IMMUTABLE,
    CONSENSUS_ADDRESS,
  ];

  static final $core.List<Owner_OwnerKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static Owner_OwnerKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Owner_OwnerKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
