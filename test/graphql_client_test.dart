import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/graphql/graphql_transport.dart';
import 'package:sui/graphql/sui_graphql_client.dart';

/// Offline unit tests using a mock HTTP adapter to verify the transport's
/// request shaping and response/error handling without hitting the network.
/// Live coverage against the public endpoint lives in `graphql_live_test.dart`.
class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this.handler);
  final Map<String, dynamic> Function(Map<String, dynamic> body) handler;
  Map<String, dynamic>? lastRequestBody;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    // Capture the JSON request body.
    lastRequestBody = options.data as Map<String, dynamic>;
    final responseJson = handler(lastRequestBody!);
    return ResponseBody.fromString(
      jsonEncode(responseJson),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dioWith(_MockAdapter adapter) => Dio()..httpClientAdapter = adapter;

void main() {
  test('getChainIdentifier parses data', () async {
    final adapter = _MockAdapter((_) => {
          'data': {
            'chainIdentifier': '4btiuiMPvEENsttpZC7CZ53DruC3MAgfznDbASZ7DR6S'
          }
        });
    final client =
        SuiGraphQLClient(endpoint: 'https://x/graphql', dio: _dioWith(adapter));
    final id = await client.getChainIdentifier();
    expect(id, '4btiuiMPvEENsttpZC7CZ53DruC3MAgfznDbASZ7DR6S');
    expect(adapter.lastRequestBody!['query'], contains('chainIdentifier'));
  });

  test('queryTransactionsByAddress sends filter + parses page', () async {
    final adapter = _MockAdapter((body) {
      expect(body['variables']['addr'], '0xabc');
      expect(body['variables']['first'], 2);
      return {
        'data': {
          'transactions': {
            'pageInfo': {'hasNextPage': true, 'endCursor': 'cursor1'},
            'nodes': [
              {'digest': 'D1'},
              {'digest': 'D2'},
            ],
          }
        }
      };
    });
    final client =
        SuiGraphQLClient(endpoint: 'https://x/graphql', dio: _dioWith(adapter));
    final page = await client.queryTransactionsByAddress('0xabc', first: 2);
    expect(page.digests, ['D1', 'D2']);
    expect(page.hasNextPage, isTrue);
    expect(page.endCursor, 'cursor1');
    expect(adapter.lastRequestBody!['query'], contains('affectedAddress'));
  });

  test('queryTransactionsBySender uses the sentAddress filter', () async {
    final adapter = _MockAdapter((body) {
      expect(body['variables']['addr'], '0xabc');
      return {
        'data': {
          'transactions': {
            'pageInfo': {'hasNextPage': false, 'endCursor': null},
            'nodes': [
              {'digest': 'S1'},
            ],
          }
        }
      };
    });
    final client =
        SuiGraphQLClient(endpoint: 'https://x/graphql', dio: _dioWith(adapter));
    final page = await client.queryTransactionsBySender('0xabc');
    expect(page.digests, ['S1']);
    expect(adapter.lastRequestBody!['query'], contains('sentAddress'));
  });

  test('GraphQL errors are surfaced as GraphQLException', () async {
    final adapter = _MockAdapter((_) => {
          'errors': [
            {'message': 'bad filter'},
            {'message': 'unauthorized'},
          ]
        });
    final client =
        SuiGraphQLClient(endpoint: 'https://x/graphql', dio: _dioWith(adapter));
    await expectLater(
      client.getChainIdentifier(),
      throwsA(isA<GraphQLException>()
          .having((e) => e.errors, 'errors', hasLength(2))
          .having((e) => e.message, 'message', contains('bad filter'))),
    );
  });
}
