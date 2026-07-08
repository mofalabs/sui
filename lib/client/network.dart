/// Sui networks and their public full-node gRPC-web endpoints.
enum SuiNetwork { mainnet, testnet, devnet, localnet }

/// Base URL for the gRPC-web endpoint of a given [network].
///
/// Public full nodes serve `sui.rpc.v2` over gRPC-web on port 443.
String grpcWebEndpoint(SuiNetwork network) => switch (network) {
      SuiNetwork.mainnet => 'https://fullnode.mainnet.sui.io:443',
      SuiNetwork.testnet => 'https://fullnode.testnet.sui.io:443',
      SuiNetwork.devnet => 'https://fullnode.devnet.sui.io:443',
      SuiNetwork.localnet => 'http://127.0.0.1:9000',
    };

/// Move Registry (MVR) HTTP endpoint for resolving `@org/app` names to package
/// IDs / type tags. Only mainnet and testnet are served.
String? mvrEndpoint(SuiNetwork network) => switch (network) {
      SuiNetwork.mainnet => 'https://mainnet.mvr.mystenlabs.com',
      SuiNetwork.testnet => 'https://testnet.mvr.mystenlabs.com',
      SuiNetwork.devnet || SuiNetwork.localnet => null,
    };

/// Public GraphQL RPC endpoint for a given [network].
///
/// Unlike gRPC (served by full nodes), GraphQL is served by an indexer. Mysten
/// operates public GraphQL endpoints at `graphql.<network>.sui.io`. There is no
/// public devnet GraphQL endpoint; [SuiNetwork.localnet] assumes a locally-run
/// indexer on the default port.
String graphqlEndpoint(SuiNetwork network) => switch (network) {
      SuiNetwork.mainnet => 'https://graphql.mainnet.sui.io/graphql',
      SuiNetwork.testnet => 'https://graphql.testnet.sui.io/graphql',
      SuiNetwork.devnet => 'https://graphql.devnet.sui.io/graphql',
      SuiNetwork.localnet => 'http://127.0.0.1:9125/graphql',
    };
