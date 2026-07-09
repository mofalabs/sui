// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature_scheme.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Flag use to disambiguate the signature schemes supported by Sui.
///
/// Note: the enum values defined by this proto message exactly match their
/// expected BCS serialized values when serialized as a u8. See
/// [enum.SignatureScheme](https://mystenlabs.github.io/sui-rust-sdk/sui_sdk_types/enum.SignatureScheme.html)
/// for more information about signature schemes.
class SignatureScheme extends $pb.ProtobufEnum {
  static const SignatureScheme ED25519 =
      SignatureScheme._(0, _omitEnumNames ? '' : 'ED25519');
  static const SignatureScheme SECP256K1 =
      SignatureScheme._(1, _omitEnumNames ? '' : 'SECP256K1');
  static const SignatureScheme SECP256R1 =
      SignatureScheme._(2, _omitEnumNames ? '' : 'SECP256R1');
  static const SignatureScheme MULTISIG =
      SignatureScheme._(3, _omitEnumNames ? '' : 'MULTISIG');
  static const SignatureScheme BLS12381 =
      SignatureScheme._(4, _omitEnumNames ? '' : 'BLS12381');
  static const SignatureScheme ZKLOGIN =
      SignatureScheme._(5, _omitEnumNames ? '' : 'ZKLOGIN');
  static const SignatureScheme PASSKEY =
      SignatureScheme._(6, _omitEnumNames ? '' : 'PASSKEY');

  static const $core.List<SignatureScheme> values = <SignatureScheme>[
    ED25519,
    SECP256K1,
    SECP256R1,
    MULTISIG,
    BLS12381,
    ZKLOGIN,
    PASSKEY,
  ];

  static final $core.List<SignatureScheme?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static SignatureScheme? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SignatureScheme._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
