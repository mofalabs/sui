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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'move_package.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'move_package.pbenum.dart';

/// A Move Package
class Package extends $pb.GeneratedMessage {
  factory Package({
    $core.String? storageId,
    $core.String? originalId,
    $fixnum.Int64? version,
    $core.Iterable<Module>? modules,
    $core.Iterable<TypeOrigin>? typeOrigins,
    $core.Iterable<Linkage>? linkage,
  }) {
    final result = create();
    if (storageId != null) result.storageId = storageId;
    if (originalId != null) result.originalId = originalId;
    if (version != null) result.version = version;
    if (modules != null) result.modules.addAll(modules);
    if (typeOrigins != null) result.typeOrigins.addAll(typeOrigins);
    if (linkage != null) result.linkage.addAll(linkage);
    return result;
  }

  Package._();

  factory Package.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Package.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Package', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storageId')
    ..aOS(2, _omitFieldNames ? '' : 'originalId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<Module>(4, _omitFieldNames ? '' : 'modules', $pb.PbFieldType.PM, subBuilder: Module.create)
    ..pc<TypeOrigin>(5, _omitFieldNames ? '' : 'typeOrigins', $pb.PbFieldType.PM, subBuilder: TypeOrigin.create)
    ..pc<Linkage>(6, _omitFieldNames ? '' : 'linkage', $pb.PbFieldType.PM, subBuilder: Linkage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Package clone() => Package()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Package copyWith(void Function(Package) updates) => super.copyWith((message) => updates(message as Package)) as Package;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Package create() => Package._();
  @$core.override
  Package createEmptyInstance() => create();
  static $pb.PbList<Package> createRepeated() => $pb.PbList<Package>();
  @$core.pragma('dart2js:noInline')
  static Package getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Package>(create);
  static Package? _defaultInstance;

  /// The PackageId of this package
  ///
  /// A package's `storage_id` is the Sui ObjectId of the package on-chain.
  /// Outside of system packages the `storage_id` for every package version is
  /// different.
  @$pb.TagNumber(1)
  $core.String get storageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set storageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStorageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageId() => $_clearField(1);

  /// The PackageId of the first published version of this package.
  ///
  /// A package's `original_id` (sometimes also called its `runtime_id`) is the
  /// `storage_id` of the first version of this package that has been published.
  /// The `original_id`/`runtime_id` is stable across all versions of the
  /// package and does not ever change.
  @$pb.TagNumber(2)
  $core.String get originalId => $_getSZ(1);
  @$pb.TagNumber(2)
  set originalId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOriginalId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginalId() => $_clearField(2);

  /// The version of this package
  @$pb.TagNumber(3)
  $fixnum.Int64 get version => $_getI64(2);
  @$pb.TagNumber(3)
  set version($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// The modules defined by this package
  @$pb.TagNumber(4)
  $pb.PbList<Module> get modules => $_getList(3);

  /// List of datatype origins for mapping datatypes to a package version where
  /// it was first defined
  @$pb.TagNumber(5)
  $pb.PbList<TypeOrigin> get typeOrigins => $_getList(4);

  /// The package's transitive dependencies as a mapping from the package's
  /// runtime Id (the Id it is referred to by in other packages) to its
  /// storage Id (the Id it is loaded from on chain).
  @$pb.TagNumber(6)
  $pb.PbList<Linkage> get linkage => $_getList(5);
}

/// A Move Module.
class Module extends $pb.GeneratedMessage {
  factory Module({
    $core.String? name,
    $core.List<$core.int>? contents,
    $core.Iterable<DatatypeDescriptor>? datatypes,
    $core.Iterable<FunctionDescriptor>? functions,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (contents != null) result.contents = contents;
    if (datatypes != null) result.datatypes.addAll(datatypes);
    if (functions != null) result.functions.addAll(functions);
    return result;
  }

  Module._();

  factory Module.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Module.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Module', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'contents', $pb.PbFieldType.OY)
    ..pc<DatatypeDescriptor>(3, _omitFieldNames ? '' : 'datatypes', $pb.PbFieldType.PM, subBuilder: DatatypeDescriptor.create)
    ..pc<FunctionDescriptor>(4, _omitFieldNames ? '' : 'functions', $pb.PbFieldType.PM, subBuilder: FunctionDescriptor.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Module clone() => Module()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Module copyWith(void Function(Module) updates) => super.copyWith((message) => updates(message as Module)) as Module;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Module create() => Module._();
  @$core.override
  Module createEmptyInstance() => create();
  static $pb.PbList<Module> createRepeated() => $pb.PbList<Module>();
  @$core.pragma('dart2js:noInline')
  static Module getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Module>(create);
  static Module? _defaultInstance;

  /// Name of this module.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Serialized bytecode of the module.
  @$pb.TagNumber(2)
  $core.List<$core.int> get contents => $_getN(1);
  @$pb.TagNumber(2)
  set contents($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContents() => $_has(1);
  @$pb.TagNumber(2)
  void clearContents() => $_clearField(2);

  /// List of DataTypes defined by this module.
  @$pb.TagNumber(3)
  $pb.PbList<DatatypeDescriptor> get datatypes => $_getList(2);

  /// List of Functions defined by this module.
  @$pb.TagNumber(4)
  $pb.PbList<FunctionDescriptor> get functions => $_getList(3);
}

/// Describes a Move Datatype.
class DatatypeDescriptor extends $pb.GeneratedMessage {
  factory DatatypeDescriptor({
    $core.String? typeName,
    $core.String? definingId,
    $core.String? module,
    $core.String? name,
    $core.Iterable<Ability>? abilities,
    $core.Iterable<TypeParameter>? typeParameters,
    DatatypeDescriptor_DatatypeKind? kind,
    $core.Iterable<FieldDescriptor>? fields,
    $core.Iterable<VariantDescriptor>? variants,
  }) {
    final result = create();
    if (typeName != null) result.typeName = typeName;
    if (definingId != null) result.definingId = definingId;
    if (module != null) result.module = module;
    if (name != null) result.name = name;
    if (abilities != null) result.abilities.addAll(abilities);
    if (typeParameters != null) result.typeParameters.addAll(typeParameters);
    if (kind != null) result.kind = kind;
    if (fields != null) result.fields.addAll(fields);
    if (variants != null) result.variants.addAll(variants);
    return result;
  }

  DatatypeDescriptor._();

  factory DatatypeDescriptor.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DatatypeDescriptor.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DatatypeDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'typeName')
    ..aOS(2, _omitFieldNames ? '' : 'definingId')
    ..aOS(3, _omitFieldNames ? '' : 'module')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..pc<Ability>(5, _omitFieldNames ? '' : 'abilities', $pb.PbFieldType.KE, valueOf: Ability.valueOf, enumValues: Ability.values, defaultEnumValue: Ability.ABILITY_UNKNOWN)
    ..pc<TypeParameter>(6, _omitFieldNames ? '' : 'typeParameters', $pb.PbFieldType.PM, subBuilder: TypeParameter.create)
    ..e<DatatypeDescriptor_DatatypeKind>(7, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE, defaultOrMaker: DatatypeDescriptor_DatatypeKind.DATATYPE_KIND_UNKNOWN, valueOf: DatatypeDescriptor_DatatypeKind.valueOf, enumValues: DatatypeDescriptor_DatatypeKind.values)
    ..pc<FieldDescriptor>(8, _omitFieldNames ? '' : 'fields', $pb.PbFieldType.PM, subBuilder: FieldDescriptor.create)
    ..pc<VariantDescriptor>(9, _omitFieldNames ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: VariantDescriptor.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DatatypeDescriptor clone() => DatatypeDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DatatypeDescriptor copyWith(void Function(DatatypeDescriptor) updates) => super.copyWith((message) => updates(message as DatatypeDescriptor)) as DatatypeDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DatatypeDescriptor create() => DatatypeDescriptor._();
  @$core.override
  DatatypeDescriptor createEmptyInstance() => create();
  static $pb.PbList<DatatypeDescriptor> createRepeated() => $pb.PbList<DatatypeDescriptor>();
  @$core.pragma('dart2js:noInline')
  static DatatypeDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DatatypeDescriptor>(create);
  static DatatypeDescriptor? _defaultInstance;

  /// Fully qualified name of this Datatype.
  ///
  /// This is `<defining_id>::<module>::<name>`
  @$pb.TagNumber(1)
  $core.String get typeName => $_getSZ(0);
  @$pb.TagNumber(1)
  set typeName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTypeName() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeName() => $_clearField(1);

  /// PackageId of the package where this Datatype is defined.
  ///
  /// A type's `defining_id` is the `storage_id` of the package version that first introduced or added that type.
  @$pb.TagNumber(2)
  $core.String get definingId => $_getSZ(1);
  @$pb.TagNumber(2)
  set definingId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDefiningId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDefiningId() => $_clearField(2);

  /// Name of the module where this Datatype is defined
  @$pb.TagNumber(3)
  $core.String get module => $_getSZ(2);
  @$pb.TagNumber(3)
  set module($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasModule() => $_has(2);
  @$pb.TagNumber(3)
  void clearModule() => $_clearField(3);

  /// Name of this Datatype
  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  /// This type's abilities
  @$pb.TagNumber(5)
  $pb.PbList<Ability> get abilities => $_getList(4);

  /// Ability constraints and phantom status for this type's generic type parameters
  @$pb.TagNumber(6)
  $pb.PbList<TypeParameter> get typeParameters => $_getList(5);

  /// Indicates whether this datatype is a 'STRUCT' or an 'ENUM'
  @$pb.TagNumber(7)
  DatatypeDescriptor_DatatypeKind get kind => $_getN(6);
  @$pb.TagNumber(7)
  set kind(DatatypeDescriptor_DatatypeKind value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasKind() => $_has(6);
  @$pb.TagNumber(7)
  void clearKind() => $_clearField(7);

  /// Set of fields if this Datatype is a struct.
  ///
  /// The order of the entries is the order of how the fields are defined.
  @$pb.TagNumber(8)
  $pb.PbList<FieldDescriptor> get fields => $_getList(7);

  /// Set of variants if this Datatype is an enum.
  ///
  /// The order of the entries is the order of how the variants are defined.
  @$pb.TagNumber(9)
  $pb.PbList<VariantDescriptor> get variants => $_getList(8);
}

/// A generic type parameter used in the declaration of a struct or enum.
class TypeParameter extends $pb.GeneratedMessage {
  factory TypeParameter({
    $core.Iterable<Ability>? constraints,
    $core.bool? isPhantom,
  }) {
    final result = create();
    if (constraints != null) result.constraints.addAll(constraints);
    if (isPhantom != null) result.isPhantom = isPhantom;
    return result;
  }

  TypeParameter._();

  factory TypeParameter.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TypeParameter.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TypeParameter', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..pc<Ability>(1, _omitFieldNames ? '' : 'constraints', $pb.PbFieldType.KE, valueOf: Ability.valueOf, enumValues: Ability.values, defaultEnumValue: Ability.ABILITY_UNKNOWN)
    ..aOB(2, _omitFieldNames ? '' : 'isPhantom')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeParameter clone() => TypeParameter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeParameter copyWith(void Function(TypeParameter) updates) => super.copyWith((message) => updates(message as TypeParameter)) as TypeParameter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TypeParameter create() => TypeParameter._();
  @$core.override
  TypeParameter createEmptyInstance() => create();
  static $pb.PbList<TypeParameter> createRepeated() => $pb.PbList<TypeParameter>();
  @$core.pragma('dart2js:noInline')
  static TypeParameter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TypeParameter>(create);
  static TypeParameter? _defaultInstance;

  /// The type parameter constraints
  @$pb.TagNumber(1)
  $pb.PbList<Ability> get constraints => $_getList(0);

  /// Whether the parameter is declared as phantom
  @$pb.TagNumber(2)
  $core.bool get isPhantom => $_getBF(1);
  @$pb.TagNumber(2)
  set isPhantom($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsPhantom() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsPhantom() => $_clearField(2);
}

/// Descriptor of a field that belongs to a struct or enum variant
class FieldDescriptor extends $pb.GeneratedMessage {
  factory FieldDescriptor({
    $core.String? name,
    $core.int? position,
    OpenSignatureBody? type,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (position != null) result.position = position;
    if (type != null) result.type = type;
    return result;
  }

  FieldDescriptor._();

  factory FieldDescriptor.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FieldDescriptor.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FieldDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'position', $pb.PbFieldType.OU3)
    ..aOM<OpenSignatureBody>(3, _omitFieldNames ? '' : 'type', subBuilder: OpenSignatureBody.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FieldDescriptor clone() => FieldDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FieldDescriptor copyWith(void Function(FieldDescriptor) updates) => super.copyWith((message) => updates(message as FieldDescriptor)) as FieldDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldDescriptor create() => FieldDescriptor._();
  @$core.override
  FieldDescriptor createEmptyInstance() => create();
  static $pb.PbList<FieldDescriptor> createRepeated() => $pb.PbList<FieldDescriptor>();
  @$core.pragma('dart2js:noInline')
  static FieldDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FieldDescriptor>(create);
  static FieldDescriptor? _defaultInstance;

  /// Name of the field
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Order or position of the field in the struct or enum variant definition.
  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(1);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  /// The type of the field
  @$pb.TagNumber(3)
  OpenSignatureBody get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(OpenSignatureBody value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);
  @$pb.TagNumber(3)
  OpenSignatureBody ensureType() => $_ensure(2);
}

/// Descriptor of an enum variant
class VariantDescriptor extends $pb.GeneratedMessage {
  factory VariantDescriptor({
    $core.String? name,
    $core.int? position,
    $core.Iterable<FieldDescriptor>? fields,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (position != null) result.position = position;
    if (fields != null) result.fields.addAll(fields);
    return result;
  }

  VariantDescriptor._();

  factory VariantDescriptor.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory VariantDescriptor.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VariantDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'position', $pb.PbFieldType.OU3)
    ..pc<FieldDescriptor>(3, _omitFieldNames ? '' : 'fields', $pb.PbFieldType.PM, subBuilder: FieldDescriptor.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VariantDescriptor clone() => VariantDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VariantDescriptor copyWith(void Function(VariantDescriptor) updates) => super.copyWith((message) => updates(message as VariantDescriptor)) as VariantDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VariantDescriptor create() => VariantDescriptor._();
  @$core.override
  VariantDescriptor createEmptyInstance() => create();
  static $pb.PbList<VariantDescriptor> createRepeated() => $pb.PbList<VariantDescriptor>();
  @$core.pragma('dart2js:noInline')
  static VariantDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VariantDescriptor>(create);
  static VariantDescriptor? _defaultInstance;

  /// Name of the variant
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Order or position of the variant in the enum definition.
  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(1);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  /// Set of fields defined by this variant.
  @$pb.TagNumber(3)
  $pb.PbList<FieldDescriptor> get fields => $_getList(2);
}

/// Representation of a type signature that could appear as a field type for a struct or enum
class OpenSignatureBody extends $pb.GeneratedMessage {
  factory OpenSignatureBody({
    OpenSignatureBody_Type? type,
    $core.String? typeName,
    $core.Iterable<OpenSignatureBody>? typeParameterInstantiation,
    $core.int? typeParameter,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (typeName != null) result.typeName = typeName;
    if (typeParameterInstantiation != null) result.typeParameterInstantiation.addAll(typeParameterInstantiation);
    if (typeParameter != null) result.typeParameter = typeParameter;
    return result;
  }

  OpenSignatureBody._();

  factory OpenSignatureBody.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OpenSignatureBody.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenSignatureBody', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..e<OpenSignatureBody_Type>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: OpenSignatureBody_Type.TYPE_UNKNOWN, valueOf: OpenSignatureBody_Type.valueOf, enumValues: OpenSignatureBody_Type.values)
    ..aOS(2, _omitFieldNames ? '' : 'typeName')
    ..pc<OpenSignatureBody>(3, _omitFieldNames ? '' : 'typeParameterInstantiation', $pb.PbFieldType.PM, subBuilder: OpenSignatureBody.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'typeParameter', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenSignatureBody clone() => OpenSignatureBody()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenSignatureBody copyWith(void Function(OpenSignatureBody) updates) => super.copyWith((message) => updates(message as OpenSignatureBody)) as OpenSignatureBody;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenSignatureBody create() => OpenSignatureBody._();
  @$core.override
  OpenSignatureBody createEmptyInstance() => create();
  static $pb.PbList<OpenSignatureBody> createRepeated() => $pb.PbList<OpenSignatureBody>();
  @$core.pragma('dart2js:noInline')
  static OpenSignatureBody getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenSignatureBody>(create);
  static OpenSignatureBody? _defaultInstance;

  /// Type of this signature
  @$pb.TagNumber(1)
  OpenSignatureBody_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(OpenSignatureBody_Type value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// Fully qualified name of the datatype when `type` is `DATATYPE`
  @$pb.TagNumber(2)
  $core.String get typeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set typeName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTypeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTypeName() => $_clearField(2);

  /// Set when `type` is `VECTOR` or `DATATYPE`
  @$pb.TagNumber(3)
  $pb.PbList<OpenSignatureBody> get typeParameterInstantiation => $_getList(2);

  /// Position of the type parameter as defined in the containing data type descriptor when `type` is `TYPE_PARAMETER`
  @$pb.TagNumber(4)
  $core.int get typeParameter => $_getIZ(3);
  @$pb.TagNumber(4)
  set typeParameter($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTypeParameter() => $_has(3);
  @$pb.TagNumber(4)
  void clearTypeParameter() => $_clearField(4);
}

/// Descriptor of a Move function
class FunctionDescriptor extends $pb.GeneratedMessage {
  factory FunctionDescriptor({
    $core.String? name,
    FunctionDescriptor_Visibility? visibility,
    $core.bool? isEntry,
    $core.Iterable<TypeParameter>? typeParameters,
    $core.Iterable<OpenSignature>? parameters,
    $core.Iterable<OpenSignature>? returns,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (visibility != null) result.visibility = visibility;
    if (isEntry != null) result.isEntry = isEntry;
    if (typeParameters != null) result.typeParameters.addAll(typeParameters);
    if (parameters != null) result.parameters.addAll(parameters);
    if (returns != null) result.returns.addAll(returns);
    return result;
  }

  FunctionDescriptor._();

  factory FunctionDescriptor.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FunctionDescriptor.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FunctionDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<FunctionDescriptor_Visibility>(5, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: FunctionDescriptor_Visibility.VISIBILITY_UNKNOWN, valueOf: FunctionDescriptor_Visibility.valueOf, enumValues: FunctionDescriptor_Visibility.values)
    ..aOB(6, _omitFieldNames ? '' : 'isEntry')
    ..pc<TypeParameter>(7, _omitFieldNames ? '' : 'typeParameters', $pb.PbFieldType.PM, subBuilder: TypeParameter.create)
    ..pc<OpenSignature>(8, _omitFieldNames ? '' : 'parameters', $pb.PbFieldType.PM, subBuilder: OpenSignature.create)
    ..pc<OpenSignature>(9, _omitFieldNames ? '' : 'returns', $pb.PbFieldType.PM, subBuilder: OpenSignature.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunctionDescriptor clone() => FunctionDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunctionDescriptor copyWith(void Function(FunctionDescriptor) updates) => super.copyWith((message) => updates(message as FunctionDescriptor)) as FunctionDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FunctionDescriptor create() => FunctionDescriptor._();
  @$core.override
  FunctionDescriptor createEmptyInstance() => create();
  static $pb.PbList<FunctionDescriptor> createRepeated() => $pb.PbList<FunctionDescriptor>();
  @$core.pragma('dart2js:noInline')
  static FunctionDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FunctionDescriptor>(create);
  static FunctionDescriptor? _defaultInstance;

  /// Name of the function
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Whether the function is `public`, `private` or `public(friend)`
  @$pb.TagNumber(5)
  FunctionDescriptor_Visibility get visibility => $_getN(1);
  @$pb.TagNumber(5)
  set visibility(FunctionDescriptor_Visibility value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(1);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  /// Whether the function is marked `entry` or not.
  @$pb.TagNumber(6)
  $core.bool get isEntry => $_getBF(2);
  @$pb.TagNumber(6)
  set isEntry($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(6)
  $core.bool hasIsEntry() => $_has(2);
  @$pb.TagNumber(6)
  void clearIsEntry() => $_clearField(6);

  /// Ability constraints for type parameters
  @$pb.TagNumber(7)
  $pb.PbList<TypeParameter> get typeParameters => $_getList(3);

  /// Formal parameter types.
  @$pb.TagNumber(8)
  $pb.PbList<OpenSignature> get parameters => $_getList(4);

  /// Return types.
  @$pb.TagNumber(9)
  $pb.PbList<OpenSignature> get returns => $_getList(5);
}

/// Representation of a type signature that could appear as a function parameter or return value.
class OpenSignature extends $pb.GeneratedMessage {
  factory OpenSignature({
    OpenSignature_Reference? reference,
    OpenSignatureBody? body,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    if (body != null) result.body = body;
    return result;
  }

  OpenSignature._();

  factory OpenSignature.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OpenSignature.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenSignature', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..e<OpenSignature_Reference>(1, _omitFieldNames ? '' : 'reference', $pb.PbFieldType.OE, defaultOrMaker: OpenSignature_Reference.REFERENCE_UNKNOWN, valueOf: OpenSignature_Reference.valueOf, enumValues: OpenSignature_Reference.values)
    ..aOM<OpenSignatureBody>(2, _omitFieldNames ? '' : 'body', subBuilder: OpenSignatureBody.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenSignature clone() => OpenSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpenSignature copyWith(void Function(OpenSignature) updates) => super.copyWith((message) => updates(message as OpenSignature)) as OpenSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenSignature create() => OpenSignature._();
  @$core.override
  OpenSignature createEmptyInstance() => create();
  static $pb.PbList<OpenSignature> createRepeated() => $pb.PbList<OpenSignature>();
  @$core.pragma('dart2js:noInline')
  static OpenSignature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenSignature>(create);
  static OpenSignature? _defaultInstance;

  @$pb.TagNumber(1)
  OpenSignature_Reference get reference => $_getN(0);
  @$pb.TagNumber(1)
  set reference(OpenSignature_Reference value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);

  @$pb.TagNumber(2)
  OpenSignatureBody get body => $_getN(1);
  @$pb.TagNumber(2)
  set body(OpenSignatureBody value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);
  @$pb.TagNumber(2)
  OpenSignatureBody ensureBody() => $_ensure(1);
}

/// Identifies a struct and the module it was defined in.
class TypeOrigin extends $pb.GeneratedMessage {
  factory TypeOrigin({
    $core.String? moduleName,
    $core.String? datatypeName,
    $core.String? packageId,
  }) {
    final result = create();
    if (moduleName != null) result.moduleName = moduleName;
    if (datatypeName != null) result.datatypeName = datatypeName;
    if (packageId != null) result.packageId = packageId;
    return result;
  }

  TypeOrigin._();

  factory TypeOrigin.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TypeOrigin.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TypeOrigin', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'moduleName')
    ..aOS(2, _omitFieldNames ? '' : 'datatypeName')
    ..aOS(3, _omitFieldNames ? '' : 'packageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeOrigin clone() => TypeOrigin()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeOrigin copyWith(void Function(TypeOrigin) updates) => super.copyWith((message) => updates(message as TypeOrigin)) as TypeOrigin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TypeOrigin create() => TypeOrigin._();
  @$core.override
  TypeOrigin createEmptyInstance() => create();
  static $pb.PbList<TypeOrigin> createRepeated() => $pb.PbList<TypeOrigin>();
  @$core.pragma('dart2js:noInline')
  static TypeOrigin getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TypeOrigin>(create);
  static TypeOrigin? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get moduleName => $_getSZ(0);
  @$pb.TagNumber(1)
  set moduleName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasModuleName() => $_has(0);
  @$pb.TagNumber(1)
  void clearModuleName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get datatypeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set datatypeName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDatatypeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatatypeName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get packageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set packageId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPackageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPackageId() => $_clearField(3);
}

/// Upgraded package info for the linkage table.
class Linkage extends $pb.GeneratedMessage {
  factory Linkage({
    $core.String? originalId,
    $core.String? upgradedId,
    $fixnum.Int64? upgradedVersion,
  }) {
    final result = create();
    if (originalId != null) result.originalId = originalId;
    if (upgradedId != null) result.upgradedId = upgradedId;
    if (upgradedVersion != null) result.upgradedVersion = upgradedVersion;
    return result;
  }

  Linkage._();

  factory Linkage.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Linkage.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Linkage', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'originalId')
    ..aOS(2, _omitFieldNames ? '' : 'upgradedId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'upgradedVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Linkage clone() => Linkage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Linkage copyWith(void Function(Linkage) updates) => super.copyWith((message) => updates(message as Linkage)) as Linkage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Linkage create() => Linkage._();
  @$core.override
  Linkage createEmptyInstance() => create();
  static $pb.PbList<Linkage> createRepeated() => $pb.PbList<Linkage>();
  @$core.pragma('dart2js:noInline')
  static Linkage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Linkage>(create);
  static Linkage? _defaultInstance;

  /// Id of the original package.
  @$pb.TagNumber(1)
  $core.String get originalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set originalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOriginalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOriginalId() => $_clearField(1);

  /// Id of the upgraded package.
  @$pb.TagNumber(2)
  $core.String get upgradedId => $_getSZ(1);
  @$pb.TagNumber(2)
  set upgradedId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUpgradedId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpgradedId() => $_clearField(2);

  /// Version of the upgraded package.
  @$pb.TagNumber(3)
  $fixnum.Int64 get upgradedVersion => $_getI64(2);
  @$pb.TagNumber(3)
  set upgradedVersion($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUpgradedVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpgradedVersion() => $_clearField(3);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
