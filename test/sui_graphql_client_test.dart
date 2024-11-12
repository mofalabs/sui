
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui_graphql_client.dart';
import 'package:sui/sui_urls.dart';

void main() {
  group('test SuiGraphQLClient', () {

    late SuiGraphQLClient client;

    setUpAll(() async {
      client = SuiGraphQLClient(SuiUrls.graphQLTestnet);
    });

    test('test getChainIdentifier', () async {
      final identifier = await client.getChainIdentifier();
      expect(identifier, '4c78adac');
    });

    test('test query chainIdentifier', () async {
      final data = await client.query('query GetChainIdentifier { chainIdentifier }');
      expect(data['chainIdentifier'], '4c78adac');
    });

  });

}