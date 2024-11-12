
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

    test('test query getReferenceGasPrice', () async {
      final gasPrice = await client.getReferenceGasPrice();
      expect(gasPrice, isNotNull);
    });

    test('test query epoch 100', () async {
      final data = await client.query(r'''
        query GetEpochInfo($id: Int!) {
          epoch(id: $id)
          {
            epochId
            totalStakeRewards
            referenceGasPrice
            totalCheckpoints
            totalGasFees
            totalStakeSubsidies
            storageFund {
              totalObjectStorageRebates
              nonRefundableBalance
            }
          }
        }
      ''', variables: {'id': 100});
      expect(data['epoch']['epochId'], 100);
    });

    test('test query last ten transactions that are not a system transaction', () async {
      final data = await client.query(r'''
        query {
          transactionBlocks(last: 10, filter: {kind: PROGRAMMABLE_TX}) {
            nodes {
              digest
              kind {
                __typename
              }
            }
          }
        }
      ''');
      expect(data['transactionBlocks']['nodes'].length, 10);
    });


  });

}