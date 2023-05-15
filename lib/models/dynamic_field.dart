import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_field.freezed.dart';

part 'dynamic_field.g.dart';

@freezed
class DynamicFieldPage with _$DynamicFieldPage {
  const factory DynamicFieldPage({
    required List<DynamicFieldInfo> data,
    String? nextCursor,
    required bool hasNextPage,
  }) = _DynamicFieldPage;

  factory DynamicFieldPage.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldPageFromJson(json);
}

@freezed
class DynamicFieldInfo with _$DynamicFieldInfo {
  const factory DynamicFieldInfo({
    required DynamicFieldName name,
    required String bcsName,
    required String type,
    required String objectType,
    required String objectId,
    required int version,
    required String digest,
  }) = _DynamicFieldInfo;

  factory DynamicFieldInfo.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldInfoFromJson(json);
}

@freezed
class DynamicFieldName with _$DynamicFieldName {
  const factory DynamicFieldName({
    required String type,
    dynamic value,
  }) = _DynamicFieldName;

  factory DynamicFieldName.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldNameFromJson(json);
}
