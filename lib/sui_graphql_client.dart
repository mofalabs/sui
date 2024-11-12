import 'package:graphql/client.dart';

class SuiGraphQLClient {
  final String endpoint;
  late final GraphQLClient client;

  SuiGraphQLClient(this.endpoint, { GraphQLCache? cache }) {
    final httpLink = HttpLink(endpoint);
    client = GraphQLClient(link: httpLink, cache: cache ?? GraphQLCache());
  }

  Future<dynamic> query(
    String document,
    [Map<String, dynamic> variables = const {}]
  ) async {
    final options = QueryOptions(document: gql(document), variables: variables);
    final resp = await client.query(options);
    if(resp.hasException) {
      throw Exception("GraphQL query exception ${resp.exception}");
    }
    return resp.data;
  }

  Future<dynamic> mutate(
    String document,
    [Map<String, dynamic> variables = const {}]
  ) async {
    final options = MutationOptions(document: gql(document), variables: variables);
    final resp = await client.mutate(options);
    if(resp.hasException) {
      throw Exception("GraphQL mutate exception ${resp.exception}");
    }
    return resp.data;
  }

  Future<String> getChainIdentifier() async {
    const doc = '''
      query GetChainIdentifier {
        chainIdentifier
      }
    ''';
    final data = await query(doc);
    return data['chainIdentifier'];
  }


}