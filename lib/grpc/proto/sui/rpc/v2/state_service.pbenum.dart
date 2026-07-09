// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/state_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Information about the state of the coin's MetadataCap
class CoinMetadata_MetadataCapState extends $pb.ProtobufEnum {
  /// Indicates the state of the MetadataCap is unknown.
  /// Set when the coin has not been migrated to the CoinRegistry.
  static const CoinMetadata_MetadataCapState METADATA_CAP_STATE_UNKNOWN =
      CoinMetadata_MetadataCapState._(
          0, _omitEnumNames ? '' : 'METADATA_CAP_STATE_UNKNOWN');

  /// Indicates the MetadataCap has been claimed.
  static const CoinMetadata_MetadataCapState CLAIMED =
      CoinMetadata_MetadataCapState._(1, _omitEnumNames ? '' : 'CLAIMED');

  /// Indicates the MetadataCap has not been claimed.
  static const CoinMetadata_MetadataCapState UNCLAIMED =
      CoinMetadata_MetadataCapState._(2, _omitEnumNames ? '' : 'UNCLAIMED');

  /// Indicates the MetadataCap has been deleted.
  static const CoinMetadata_MetadataCapState DELETED =
      CoinMetadata_MetadataCapState._(3, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<CoinMetadata_MetadataCapState> values =
      <CoinMetadata_MetadataCapState>[
    METADATA_CAP_STATE_UNKNOWN,
    CLAIMED,
    UNCLAIMED,
    DELETED,
  ];

  static final $core.List<CoinMetadata_MetadataCapState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static CoinMetadata_MetadataCapState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CoinMetadata_MetadataCapState._(super.value, super.name);
}

/// Supply state of a coin, matching the Move SupplyState enum
class CoinTreasury_SupplyState extends $pb.ProtobufEnum {
  /// Supply is unknown or TreasuryCap still exists (minting still possible)
  static const CoinTreasury_SupplyState SUPPLY_STATE_UNKNOWN =
      CoinTreasury_SupplyState._(
          0, _omitEnumNames ? '' : 'SUPPLY_STATE_UNKNOWN');

  /// Supply is fixed (TreasuryCap consumed, no more minting possible)
  static const CoinTreasury_SupplyState FIXED =
      CoinTreasury_SupplyState._(1, _omitEnumNames ? '' : 'FIXED');

  /// Supply can only decrease (burning allowed, minting not allowed)
  static const CoinTreasury_SupplyState BURN_ONLY =
      CoinTreasury_SupplyState._(2, _omitEnumNames ? '' : 'BURN_ONLY');

  static const $core.List<CoinTreasury_SupplyState> values =
      <CoinTreasury_SupplyState>[
    SUPPLY_STATE_UNKNOWN,
    FIXED,
    BURN_ONLY,
  ];

  static final $core.List<CoinTreasury_SupplyState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CoinTreasury_SupplyState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CoinTreasury_SupplyState._(super.value, super.name);
}

/// Indicates the state of the regulation of the coin.
class RegulatedCoinMetadata_CoinRegulatedState extends $pb.ProtobufEnum {
  /// Indicates the regulation state of the coin is unknown.
  /// This is set when a coin has not been migrated to the
  /// coin registry and has no `0x2::coin::RegulatedCoinMetadata`
  /// object.
  static const RegulatedCoinMetadata_CoinRegulatedState
      COIN_REGULATED_STATE_UNKNOWN = RegulatedCoinMetadata_CoinRegulatedState._(
          0, _omitEnumNames ? '' : 'COIN_REGULATED_STATE_UNKNOWN');

  /// Indicates a coin is regulated. RegulatedCoinMetadata will be populated.
  static const RegulatedCoinMetadata_CoinRegulatedState REGULATED =
      RegulatedCoinMetadata_CoinRegulatedState._(
          1, _omitEnumNames ? '' : 'REGULATED');

  /// Indicates a coin is unregulated.
  static const RegulatedCoinMetadata_CoinRegulatedState UNREGULATED =
      RegulatedCoinMetadata_CoinRegulatedState._(
          2, _omitEnumNames ? '' : 'UNREGULATED');

  static const $core.List<RegulatedCoinMetadata_CoinRegulatedState> values =
      <RegulatedCoinMetadata_CoinRegulatedState>[
    COIN_REGULATED_STATE_UNKNOWN,
    REGULATED,
    UNREGULATED,
  ];

  static final $core.List<RegulatedCoinMetadata_CoinRegulatedState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RegulatedCoinMetadata_CoinRegulatedState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RegulatedCoinMetadata_CoinRegulatedState._(super.value, super.name);
}

class DynamicField_DynamicFieldKind extends $pb.ProtobufEnum {
  static const DynamicField_DynamicFieldKind DYNAMIC_FIELD_KIND_UNKNOWN =
      DynamicField_DynamicFieldKind._(
          0, _omitEnumNames ? '' : 'DYNAMIC_FIELD_KIND_UNKNOWN');
  static const DynamicField_DynamicFieldKind FIELD =
      DynamicField_DynamicFieldKind._(1, _omitEnumNames ? '' : 'FIELD');
  static const DynamicField_DynamicFieldKind OBJECT =
      DynamicField_DynamicFieldKind._(2, _omitEnumNames ? '' : 'OBJECT');

  static const $core.List<DynamicField_DynamicFieldKind> values =
      <DynamicField_DynamicFieldKind>[
    DYNAMIC_FIELD_KIND_UNKNOWN,
    FIELD,
    OBJECT,
  ];

  static final $core.List<DynamicField_DynamicFieldKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DynamicField_DynamicFieldKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DynamicField_DynamicFieldKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
