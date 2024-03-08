import 'package:flutter/foundation.dart';

@immutable
final class SuiUrls {
  const SuiUrls._();

  static const String mainnetAPI = "https://mainnet-rpc.sui.chainbase.online/";
  static const String testnetAPI = "https://fullnode.testnet.sui.io";
  static const String devnetAPI = "https://fullnode.devnet.sui.io";

  static const String faucetDevAPI = "https://faucet.devnet.sui.io";
  static const String faucetTestAPI = "https://faucet.testnet.sui.io";

  static const String webSocketMainnet = 'wss://fullnode.mainnet.sui.io';
  static const String webSocketTestnet = 'wss://fullnode.testnet.sui.io';
  static const String webSocketDevnet = 'wss://fullnode.devnet.sui.io';
}
