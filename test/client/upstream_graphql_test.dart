import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/graphql/sui_graphql_client.dart';
import 'package:sui/graphql/graphql_transport.dart';

class _Transport extends GraphQLTransport {
  _Transport(this.result) : super('https://fixture.test');
  final Map<String, dynamic> result;
  Map<String, dynamic>? variables;
  CancelToken? token;
  @override
  Future<Map<String, dynamic>> query(
    String query, {
    Map<String, dynamic>? variables,
    CancelToken? cancelToken,
  }) async {
    this.variables = variables;
    token = cancelToken;
    return result;
  }
}

void main() {
  test(
    'descending GraphQL history returns newest first with a cursor to older items',
    () async {
      final transport = _Transport({
        'transactions': {
          'pageInfo': {
            'hasNextPage': false,
            'hasPreviousPage': true,
            'startCursor': 'older',
            'endCursor': 'newer',
          },
          'nodes': [
            {
              'digest': 'older',
              'effects': {
                'status': 'SUCCESS',
                'timestamp': '2026-10-23T00:00:00Z',
                'checkpoint': {'sequenceNumber': 100},
              },
            },
            {
              'digest': 'newer',
              'effects': {
                'status': 'SUCCESS',
                'timestamp': '2026-10-24T00:00:00Z',
                'checkpoint': {'sequenceNumber': 101},
              },
            },
          ],
        },
      });
      final token = CancelToken();
      final client = SuiGraphQLClient(
        endpoint: 'https://ignored.test',
        transport: transport,
      );
      final page = await client.listTransactions(
        filter: const GraphQLTransactionFilter(affectedAddress: '0x1'),
        limit: 2,
        before: 'previous',
        cancelToken: token,
      );
      expect(page.items.map((item) => item.digest), ['newer', 'older']);
      expect(page.items.first.checkpoint, BigInt.from(101));
      expect(page.hasNextPage, isTrue);
      expect(page.cursor, 'older');
      expect(transport.variables, {
        'filter': {'affectedAddress': '0x1'},
        'last': 2,
        'before': 'previous',
      });
      expect(transport.token, same(token));
    },
  );

  test(
    'GraphQL events retain pagination and reject unsupported combined filters',
    () async {
      final transport = _Transport({
        'events': {
          'pageInfo': {
            'hasNextPage': true,
            'hasPreviousPage': false,
            'startCursor': 'a',
            'endCursor': 'b',
          },
          'nodes': [
            {'sequenceNumber': 0},
            {'sequenceNumber': 1},
          ],
        },
      });
      final client = SuiGraphQLClient(endpoint: '', transport: transport);
      final page = await client.listEvents(
        filter: const GraphQLEventFilter(type: '0x2::coin::Event'),
        descending: false,
      );
      expect(page.items.map((event) => event['sequenceNumber']), [0, 1]);
      expect(page.cursor, 'b');
      expect(page.hasNextPage, isTrue);
      await expectLater(
        client.listEvents(
          filter: const GraphQLEventFilter(
            module: '0x2',
            type: '0x2::coin::Event',
          ),
        ),
        throwsArgumentError,
      );
    },
  );

  test('missing default name and name target resolve to null', () async {
    final client = SuiGraphQLClient(
      endpoint: '',
      transport: _Transport({'address': null}),
    );
    expect(await client.defaultNameServiceName('0x1'), isNull);
    expect(await client.resolveNameServiceAddress('@missing'), isNull);
  });
}
