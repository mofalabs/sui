// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/move_package_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'move_package.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetPackageRequest extends $pb.GeneratedMessage {
  factory GetPackageRequest({
    $core.String? packageId,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    return result;
  }

  GetPackageRequest._();

  factory GetPackageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPackageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPackageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPackageRequest clone() => GetPackageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPackageRequest copyWith(void Function(GetPackageRequest) updates) =>
      super.copyWith((message) => updates(message as GetPackageRequest))
          as GetPackageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPackageRequest create() => GetPackageRequest._();
  @$core.override
  GetPackageRequest createEmptyInstance() => create();
  static $pb.PbList<GetPackageRequest> createRepeated() =>
      $pb.PbList<GetPackageRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPackageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPackageRequest>(create);
  static GetPackageRequest? _defaultInstance;

  /// Required. The `storage_id` of the requested package.
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);
}

class GetPackageResponse extends $pb.GeneratedMessage {
  factory GetPackageResponse({
    $0.Package? package,
  }) {
    final result = create();
    if (package != null) result.package = package;
    return result;
  }

  GetPackageResponse._();

  factory GetPackageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPackageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPackageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.Package>(1, _omitFieldNames ? '' : 'package',
        subBuilder: $0.Package.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPackageResponse clone() => GetPackageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPackageResponse copyWith(void Function(GetPackageResponse) updates) =>
      super.copyWith((message) => updates(message as GetPackageResponse))
          as GetPackageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPackageResponse create() => GetPackageResponse._();
  @$core.override
  GetPackageResponse createEmptyInstance() => create();
  static $pb.PbList<GetPackageResponse> createRepeated() =>
      $pb.PbList<GetPackageResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPackageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPackageResponse>(create);
  static GetPackageResponse? _defaultInstance;

  /// The package.
  @$pb.TagNumber(1)
  $0.Package get package => $_getN(0);
  @$pb.TagNumber(1)
  set package($0.Package value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackage() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Package ensurePackage() => $_ensure(0);
}

class GetDatatypeRequest extends $pb.GeneratedMessage {
  factory GetDatatypeRequest({
    $core.String? packageId,
    $core.String? moduleName,
    $core.String? name,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (moduleName != null) result.moduleName = moduleName;
    if (name != null) result.name = name;
    return result;
  }

  GetDatatypeRequest._();

  factory GetDatatypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDatatypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDatatypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..aOS(2, _omitFieldNames ? '' : 'moduleName')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDatatypeRequest clone() => GetDatatypeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDatatypeRequest copyWith(void Function(GetDatatypeRequest) updates) =>
      super.copyWith((message) => updates(message as GetDatatypeRequest))
          as GetDatatypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDatatypeRequest create() => GetDatatypeRequest._();
  @$core.override
  GetDatatypeRequest createEmptyInstance() => create();
  static $pb.PbList<GetDatatypeRequest> createRepeated() =>
      $pb.PbList<GetDatatypeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDatatypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDatatypeRequest>(create);
  static GetDatatypeRequest? _defaultInstance;

  /// Required. The `storage_id` of the requested package.
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  /// Required. The name of the requested module.
  @$pb.TagNumber(2)
  $core.String get moduleName => $_getSZ(1);
  @$pb.TagNumber(2)
  set moduleName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModuleName() => $_has(1);
  @$pb.TagNumber(2)
  void clearModuleName() => $_clearField(2);

  /// Required. The name of the requested datatype.
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
}

class GetDatatypeResponse extends $pb.GeneratedMessage {
  factory GetDatatypeResponse({
    $0.DatatypeDescriptor? datatype,
  }) {
    final result = create();
    if (datatype != null) result.datatype = datatype;
    return result;
  }

  GetDatatypeResponse._();

  factory GetDatatypeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDatatypeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDatatypeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.DatatypeDescriptor>(1, _omitFieldNames ? '' : 'datatype',
        subBuilder: $0.DatatypeDescriptor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDatatypeResponse clone() => GetDatatypeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDatatypeResponse copyWith(void Function(GetDatatypeResponse) updates) =>
      super.copyWith((message) => updates(message as GetDatatypeResponse))
          as GetDatatypeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDatatypeResponse create() => GetDatatypeResponse._();
  @$core.override
  GetDatatypeResponse createEmptyInstance() => create();
  static $pb.PbList<GetDatatypeResponse> createRepeated() =>
      $pb.PbList<GetDatatypeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDatatypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDatatypeResponse>(create);
  static GetDatatypeResponse? _defaultInstance;

  /// The datatype.
  @$pb.TagNumber(1)
  $0.DatatypeDescriptor get datatype => $_getN(0);
  @$pb.TagNumber(1)
  set datatype($0.DatatypeDescriptor value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDatatype() => $_has(0);
  @$pb.TagNumber(1)
  void clearDatatype() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.DatatypeDescriptor ensureDatatype() => $_ensure(0);
}

class GetFunctionRequest extends $pb.GeneratedMessage {
  factory GetFunctionRequest({
    $core.String? packageId,
    $core.String? moduleName,
    $core.String? name,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (moduleName != null) result.moduleName = moduleName;
    if (name != null) result.name = name;
    return result;
  }

  GetFunctionRequest._();

  factory GetFunctionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFunctionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFunctionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..aOS(2, _omitFieldNames ? '' : 'moduleName')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFunctionRequest clone() => GetFunctionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFunctionRequest copyWith(void Function(GetFunctionRequest) updates) =>
      super.copyWith((message) => updates(message as GetFunctionRequest))
          as GetFunctionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFunctionRequest create() => GetFunctionRequest._();
  @$core.override
  GetFunctionRequest createEmptyInstance() => create();
  static $pb.PbList<GetFunctionRequest> createRepeated() =>
      $pb.PbList<GetFunctionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFunctionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFunctionRequest>(create);
  static GetFunctionRequest? _defaultInstance;

  /// Required. The `storage_id` of the requested package.
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  /// Required. The name of the requested module.
  @$pb.TagNumber(2)
  $core.String get moduleName => $_getSZ(1);
  @$pb.TagNumber(2)
  set moduleName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModuleName() => $_has(1);
  @$pb.TagNumber(2)
  void clearModuleName() => $_clearField(2);

  /// Required. The name of the requested function.
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
}

class GetFunctionResponse extends $pb.GeneratedMessage {
  factory GetFunctionResponse({
    $0.FunctionDescriptor? function,
  }) {
    final result = create();
    if (function != null) result.function = function;
    return result;
  }

  GetFunctionResponse._();

  factory GetFunctionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFunctionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFunctionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.FunctionDescriptor>(1, _omitFieldNames ? '' : 'function',
        subBuilder: $0.FunctionDescriptor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFunctionResponse clone() => GetFunctionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFunctionResponse copyWith(void Function(GetFunctionResponse) updates) =>
      super.copyWith((message) => updates(message as GetFunctionResponse))
          as GetFunctionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFunctionResponse create() => GetFunctionResponse._();
  @$core.override
  GetFunctionResponse createEmptyInstance() => create();
  static $pb.PbList<GetFunctionResponse> createRepeated() =>
      $pb.PbList<GetFunctionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFunctionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFunctionResponse>(create);
  static GetFunctionResponse? _defaultInstance;

  /// The function.
  @$pb.TagNumber(1)
  $0.FunctionDescriptor get function => $_getN(0);
  @$pb.TagNumber(1)
  set function($0.FunctionDescriptor value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFunction() => $_has(0);
  @$pb.TagNumber(1)
  void clearFunction() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.FunctionDescriptor ensureFunction() => $_ensure(0);
}

class ListPackageVersionsRequest extends $pb.GeneratedMessage {
  factory ListPackageVersionsRequest({
    $core.String? packageId,
    $core.int? pageSize,
    $core.List<$core.int>? pageToken,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  ListPackageVersionsRequest._();

  factory ListPackageVersionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPackageVersionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPackageVersionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'pageToken', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPackageVersionsRequest clone() =>
      ListPackageVersionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPackageVersionsRequest copyWith(
          void Function(ListPackageVersionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListPackageVersionsRequest))
          as ListPackageVersionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPackageVersionsRequest create() => ListPackageVersionsRequest._();
  @$core.override
  ListPackageVersionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPackageVersionsRequest> createRepeated() =>
      $pb.PbList<ListPackageVersionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPackageVersionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPackageVersionsRequest>(create);
  static ListPackageVersionsRequest? _defaultInstance;

  /// Required. The `storage_id` of any version of the package.
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  /// The maximum number of versions to return. The service may return fewer than this value.
  /// If unspecified, at most `1000` entries will be returned.
  /// The maximum value is `10000`; values above `10000` will be coerced to `10000`.
  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  /// A page token, received from a previous `ListPackageVersions` call.
  /// Provide this to retrieve the subsequent page.
  ///
  /// When paginating, all other parameters provided to `ListPackageVersions` must
  /// match the call that provided the page token.
  @$pb.TagNumber(3)
  $core.List<$core.int> get pageToken => $_getN(2);
  @$pb.TagNumber(3)
  set pageToken($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => $_clearField(3);
}

class ListPackageVersionsResponse extends $pb.GeneratedMessage {
  factory ListPackageVersionsResponse({
    $core.Iterable<PackageVersion>? versions,
    $core.List<$core.int>? nextPageToken,
  }) {
    final result = create();
    if (versions != null) result.versions.addAll(versions);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListPackageVersionsResponse._();

  factory ListPackageVersionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPackageVersionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPackageVersionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<PackageVersion>(
        1, _omitFieldNames ? '' : 'versions', $pb.PbFieldType.PM,
        subBuilder: PackageVersion.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'nextPageToken', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPackageVersionsResponse clone() =>
      ListPackageVersionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPackageVersionsResponse copyWith(
          void Function(ListPackageVersionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListPackageVersionsResponse))
          as ListPackageVersionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPackageVersionsResponse create() =>
      ListPackageVersionsResponse._();
  @$core.override
  ListPackageVersionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPackageVersionsResponse> createRepeated() =>
      $pb.PbList<ListPackageVersionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPackageVersionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPackageVersionsResponse>(create);
  static ListPackageVersionsResponse? _defaultInstance;

  /// List of all package versions, ordered by version.
  @$pb.TagNumber(1)
  $pb.PbList<PackageVersion> get versions => $_getList(0);

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
  @$pb.TagNumber(2)
  $core.List<$core.int> get nextPageToken => $_getN(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

/// A simplified representation of a package version
class PackageVersion extends $pb.GeneratedMessage {
  factory PackageVersion({
    $core.String? packageId,
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (version != null) result.version = version;
    return result;
  }

  PackageVersion._();

  factory PackageVersion.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PackageVersion.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PackageVersion',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageVersion clone() => PackageVersion()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageVersion copyWith(void Function(PackageVersion) updates) =>
      super.copyWith((message) => updates(message as PackageVersion))
          as PackageVersion;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PackageVersion create() => PackageVersion._();
  @$core.override
  PackageVersion createEmptyInstance() => create();
  static $pb.PbList<PackageVersion> createRepeated() =>
      $pb.PbList<PackageVersion>();
  @$core.pragma('dart2js:noInline')
  static PackageVersion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PackageVersion>(create);
  static PackageVersion? _defaultInstance;

  /// The storage ID of this package version
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  /// The version number
  @$pb.TagNumber(2)
  $fixnum.Int64 get version => $_getI64(1);
  @$pb.TagNumber(2)
  set version($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);
}

class MovePackageServiceApi {
  final $pb.RpcClient _client;

  MovePackageServiceApi(this._client);

  $async.Future<GetPackageResponse> getPackage(
          $pb.ClientContext? ctx, GetPackageRequest request) =>
      _client.invoke<GetPackageResponse>(ctx, 'MovePackageService',
          'GetPackage', request, GetPackageResponse());
  $async.Future<GetDatatypeResponse> getDatatype(
          $pb.ClientContext? ctx, GetDatatypeRequest request) =>
      _client.invoke<GetDatatypeResponse>(ctx, 'MovePackageService',
          'GetDatatype', request, GetDatatypeResponse());
  $async.Future<GetFunctionResponse> getFunction(
          $pb.ClientContext? ctx, GetFunctionRequest request) =>
      _client.invoke<GetFunctionResponse>(ctx, 'MovePackageService',
          'GetFunction', request, GetFunctionResponse());
  $async.Future<ListPackageVersionsResponse> listPackageVersions(
          $pb.ClientContext? ctx, ListPackageVersionsRequest request) =>
      _client.invoke<ListPackageVersionsResponse>(ctx, 'MovePackageService',
          'ListPackageVersions', request, ListPackageVersionsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
