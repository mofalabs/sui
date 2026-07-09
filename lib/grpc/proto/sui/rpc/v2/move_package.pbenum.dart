// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/move_package.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// An `Ability` classifies what operations are permitted for a given type
class Ability extends $pb.ProtobufEnum {
  static const Ability ABILITY_UNKNOWN =
      Ability._(0, _omitEnumNames ? '' : 'ABILITY_UNKNOWN');

  /// Allows values of types with this ability to be copied
  static const Ability COPY = Ability._(1, _omitEnumNames ? '' : 'COPY');

  /// Allows values of types with this ability to be dropped.
  static const Ability DROP = Ability._(2, _omitEnumNames ? '' : 'DROP');

  /// Allows values of types with this ability to exist inside a struct in global storage
  static const Ability STORE = Ability._(3, _omitEnumNames ? '' : 'STORE');

  /// Allows the type to serve as a key for global storage operations
  static const Ability KEY = Ability._(4, _omitEnumNames ? '' : 'KEY');

  static const $core.List<Ability> values = <Ability>[
    ABILITY_UNKNOWN,
    COPY,
    DROP,
    STORE,
    KEY,
  ];

  static final $core.List<Ability?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static Ability? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Ability._(super.value, super.name);
}

class DatatypeDescriptor_DatatypeKind extends $pb.ProtobufEnum {
  static const DatatypeDescriptor_DatatypeKind DATATYPE_KIND_UNKNOWN =
      DatatypeDescriptor_DatatypeKind._(
          0, _omitEnumNames ? '' : 'DATATYPE_KIND_UNKNOWN');
  static const DatatypeDescriptor_DatatypeKind STRUCT =
      DatatypeDescriptor_DatatypeKind._(1, _omitEnumNames ? '' : 'STRUCT');
  static const DatatypeDescriptor_DatatypeKind ENUM =
      DatatypeDescriptor_DatatypeKind._(2, _omitEnumNames ? '' : 'ENUM');

  static const $core.List<DatatypeDescriptor_DatatypeKind> values =
      <DatatypeDescriptor_DatatypeKind>[
    DATATYPE_KIND_UNKNOWN,
    STRUCT,
    ENUM,
  ];

  static final $core.List<DatatypeDescriptor_DatatypeKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DatatypeDescriptor_DatatypeKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DatatypeDescriptor_DatatypeKind._(super.value, super.name);
}

class OpenSignatureBody_Type extends $pb.ProtobufEnum {
  static const OpenSignatureBody_Type TYPE_UNKNOWN =
      OpenSignatureBody_Type._(0, _omitEnumNames ? '' : 'TYPE_UNKNOWN');
  static const OpenSignatureBody_Type ADDRESS =
      OpenSignatureBody_Type._(1, _omitEnumNames ? '' : 'ADDRESS');
  static const OpenSignatureBody_Type BOOL =
      OpenSignatureBody_Type._(2, _omitEnumNames ? '' : 'BOOL');
  static const OpenSignatureBody_Type U8 =
      OpenSignatureBody_Type._(3, _omitEnumNames ? '' : 'U8');
  static const OpenSignatureBody_Type U16 =
      OpenSignatureBody_Type._(4, _omitEnumNames ? '' : 'U16');
  static const OpenSignatureBody_Type U32 =
      OpenSignatureBody_Type._(5, _omitEnumNames ? '' : 'U32');
  static const OpenSignatureBody_Type U64 =
      OpenSignatureBody_Type._(6, _omitEnumNames ? '' : 'U64');
  static const OpenSignatureBody_Type U128 =
      OpenSignatureBody_Type._(7, _omitEnumNames ? '' : 'U128');
  static const OpenSignatureBody_Type U256 =
      OpenSignatureBody_Type._(8, _omitEnumNames ? '' : 'U256');
  static const OpenSignatureBody_Type VECTOR =
      OpenSignatureBody_Type._(9, _omitEnumNames ? '' : 'VECTOR');
  static const OpenSignatureBody_Type DATATYPE =
      OpenSignatureBody_Type._(10, _omitEnumNames ? '' : 'DATATYPE');
  static const OpenSignatureBody_Type TYPE_PARAMETER =
      OpenSignatureBody_Type._(11, _omitEnumNames ? '' : 'TYPE_PARAMETER');

  static const $core.List<OpenSignatureBody_Type> values =
      <OpenSignatureBody_Type>[
    TYPE_UNKNOWN,
    ADDRESS,
    BOOL,
    U8,
    U16,
    U32,
    U64,
    U128,
    U256,
    VECTOR,
    DATATYPE,
    TYPE_PARAMETER,
  ];

  static final $core.List<OpenSignatureBody_Type?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static OpenSignatureBody_Type? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OpenSignatureBody_Type._(super.value, super.name);
}

class FunctionDescriptor_Visibility extends $pb.ProtobufEnum {
  static const FunctionDescriptor_Visibility VISIBILITY_UNKNOWN =
      FunctionDescriptor_Visibility._(
          0, _omitEnumNames ? '' : 'VISIBILITY_UNKNOWN');
  static const FunctionDescriptor_Visibility PRIVATE =
      FunctionDescriptor_Visibility._(1, _omitEnumNames ? '' : 'PRIVATE');
  static const FunctionDescriptor_Visibility PUBLIC =
      FunctionDescriptor_Visibility._(2, _omitEnumNames ? '' : 'PUBLIC');
  static const FunctionDescriptor_Visibility FRIEND =
      FunctionDescriptor_Visibility._(3, _omitEnumNames ? '' : 'FRIEND');

  static const $core.List<FunctionDescriptor_Visibility> values =
      <FunctionDescriptor_Visibility>[
    VISIBILITY_UNKNOWN,
    PRIVATE,
    PUBLIC,
    FRIEND,
  ];

  static final $core.List<FunctionDescriptor_Visibility?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static FunctionDescriptor_Visibility? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FunctionDescriptor_Visibility._(super.value, super.name);
}

class OpenSignature_Reference extends $pb.ProtobufEnum {
  static const OpenSignature_Reference REFERENCE_UNKNOWN =
      OpenSignature_Reference._(0, _omitEnumNames ? '' : 'REFERENCE_UNKNOWN');
  static const OpenSignature_Reference IMMUTABLE =
      OpenSignature_Reference._(1, _omitEnumNames ? '' : 'IMMUTABLE');
  static const OpenSignature_Reference MUTABLE =
      OpenSignature_Reference._(2, _omitEnumNames ? '' : 'MUTABLE');

  static const $core.List<OpenSignature_Reference> values =
      <OpenSignature_Reference>[
    REFERENCE_UNKNOWN,
    IMMUTABLE,
    MUTABLE,
  ];

  static final $core.List<OpenSignature_Reference?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OpenSignature_Reference? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OpenSignature_Reference._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
