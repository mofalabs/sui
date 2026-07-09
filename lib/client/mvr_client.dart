import 'package:dio/dio.dart';

import 'network.dart';

/// Move Registry (MVR) resolver: turns `@org/app` package names and MVR-named
/// types (e.g. `@org/app::module::Type`) into on-chain package IDs / fully
/// qualified type tags.
///
/// Backed by Mysten's public `<network>.mvr.mystenlabs.com` HTTP service.
/// Inputs without an `@` are returned unchanged.
class MvrClient {
  MvrClient({required this.endpoint, Dio? dio})
      : _dio = dio ??
            (Dio()..options.connectTimeout = const Duration(seconds: 15));

  /// Construct for a network's public MVR endpoint (null for devnet/localnet).
  static MvrClient? forNetwork(SuiNetwork network, {Dio? dio}) {
    final url = mvrEndpoint(network);
    return url == null ? null : MvrClient(endpoint: url, dio: dio);
  }

  final String endpoint;
  final Dio _dio;

  static final RegExp _mvrTypeRef =
      RegExp(r'@[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+::[a-zA-Z0-9_]+::[a-zA-Z0-9_]+');

  static bool _hasMvrName(String s) => s.contains('@');

  /// Resolve an MVR package name (`@org/app`) to its package ID. Returns the
  /// input unchanged if it is not an MVR name.
  Future<String> resolvePackage(String package) async {
    if (!_hasMvrName(package)) return package;
    final resolution = await _bulk('/v1/resolution/bulk', 'names', [package]);
    final id = (resolution[package] as Map?)?['package_id'] as String?;
    if (id == null) {
      throw StateError('MVR could not resolve package "$package"');
    }
    return id;
  }

  /// Resolve MVR-named types inside [type] to their fully qualified type tags.
  /// Returns [type] unchanged if it contains no MVR names.
  Future<String> resolveType(String type) async {
    if (!_hasMvrName(type)) return type;
    final names =
        _mvrTypeRef.allMatches(type).map((m) => m.group(0)!).toSet().toList();
    if (names.isEmpty) return type;

    final resolution =
        await _bulk('/v1/struct-definition/bulk', 'types', names);
    // Replace longest names first so a name that is a prefix of another
    // (e.g. `@a/b::m::T` vs `@a/b::m::T2`) doesn't corrupt the longer one.
    names.sort((a, b) => b.length.compareTo(a.length));
    var result = type;
    for (final name in names) {
      final tag = (resolution[name] as Map?)?['type_tag'] as String?;
      if (tag == null) {
        throw StateError('MVR could not resolve type "$name"');
      }
      result = result.replaceAll(name, tag);
    }
    return result;
  }

  Future<Map<String, dynamic>> _bulk(
    String path,
    String field,
    List<String> values,
  ) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '$endpoint$path',
      data: {field: values},
      options: Options(
        contentType: 'application/json',
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ),
    );
    if (resp.statusCode != 200 || resp.data == null) {
      throw StateError('MVR request failed (HTTP ${resp.statusCode})');
    }
    return (resp.data!['resolution'] as Map?)?.cast<String, dynamic>() ??
        <String, dynamic>{};
  }
}
