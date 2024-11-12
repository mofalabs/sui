import 'package:flutter/foundation.dart';

@immutable
final class SuiUrls {
  const SuiUrls._();

  static const String mainnet = "https://mainnet-rpc.sui.chainbase.online/";
  static const String testnet = "https://fullnode.testnet.sui.io";
  static const String devnet = "https://fullnode.devnet.sui.io";

  static const String faucetDev = "https://faucet.devnet.sui.io";
  static const String faucetTest = "https://faucet.testnet.sui.io";

  static const String webSocketMainnet = 'wss://fullnode.mainnet.sui.io';
  static const String webSocketTestnet = 'wss://fullnode.testnet.sui.io';
  static const String webSocketDevnet = 'wss://fullnode.devnet.sui.io';

  static const String graphQLMainnet = 'https://sui-mainnet.mystenlabs.com/graphql';
  static const String graphQLTestnet = 'https://sui-testnet.mystenlabs.com/graphql';
  static const String graphQLDevnet = 'https://sui-devnet.mystenlabs.com/graphql';
}
