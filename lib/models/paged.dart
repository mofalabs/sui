
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged.freezed.dart';
part 'paged.g.dart';

@Freezed(genericArgumentFactories: true)
class Paged<T> with _$Paged<T>{
  const factory Paged({
    required T data,
    dynamic nextCursor,  // NextCursor or String
    required bool hasNextPage
  }) = _Paged;

  factory Paged.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$PagedFromJson<T>(json, fromJsonT);
}

@freezed
class NextCursor with _$NextCursor{
  const factory NextCursor({
    required String txDigest,
    required String eventSeq
  }) = _NextCursor;

  factory NextCursor.fromJson(Map<String, dynamic> json) => _$NextCursorFromJson(json);
}