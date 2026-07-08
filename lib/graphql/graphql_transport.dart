import 'package:dio/dio.dart';

/// Minimal GraphQL-over-HTTP transport for Sui GraphQL RPC.
///
/// GraphQL RPC is served by an indexer, not by full nodes (so it is NOT on the
/// `fullnode.*.sui.io` hosts). Mysten operates public endpoints at
/// `graphql.<network>.sui.io/graphql`; see [graphqlEndpoint]. You can also point
/// [endpoint] at a provider (QuickNode / Ankr / BlockPi / ZAN) or a self-hosted
/// indexer.
///
/// This transport complements the gRPC-web transport, which covers the core
/// read/write path. GraphQL is intended for query patterns full nodes cannot
/// serve (filtered transaction/event queries, staking, validator APYs).
class GraphQLTransport {
  GraphQLTransport(this.endpoint, {Dio? dio, this.headers = const {}})
      : _dio = dio ??
            (Dio()..options.connectTimeout = const Duration(seconds: 15));

  final String endpoint;
  final Map<String, String> headers;
  final Dio _dio;

  /// Execute a GraphQL [query] with optional [variables]; returns the `data`
  /// object. Throws [GraphQLException] if the response carries `errors`.
  Future<Map<String, dynamic>> query(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'query': query,
        if (variables != null) 'variables': variables,
      },
      options: Options(
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: {'accept': 'application/json', ...headers},
        validateStatus: (_) => true,
      ),
    );

    final body = resp.data;
    if (body == null) {
      throw GraphQLException(
        'Empty GraphQL response (HTTP ${resp.statusCode})',
        const [],
      );
    }

    final errors = body['errors'];
    if (errors is List && errors.isNotEmpty) {
      final messages =
          errors.map((e) => (e is Map ? e['message'] : e).toString()).toList();
      throw GraphQLException(messages.join('; '), messages);
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw GraphQLException('GraphQL response missing "data"', const []);
    }
    return data;
  }
}

class GraphQLException implements Exception {
  GraphQLException(this.message, this.errors);
  final String message;
  final List<String> errors;

  @override
  String toString() => 'GraphQLException: $message';
}
