import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/mvr_client.dart';
import 'package:sui/client/network.dart';
import 'package:sui/cryptography/intent.dart';
import 'package:sui/grpc/sui_grpc_client.dart';
import 'package:sui/sui_account.dart';

/// Parity coverage for the remaining official surface: signature verification
/// (SignatureVerificationService) and Move Registry resolution (MVR).
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  group('verifySignature (gRPC-web, testnet)', () {
    test('valid personal-message signature verifies true', () async {
      final account = SuiAccount.ed25519Account();
      final message = Uint8List.fromList(utf8.encode('hello sui migration'));
      final signed = account.keyPair.signPersonalMessage(message);

      final result = await client.verifySignature(
        message,
        Uint8List.fromList(base64Decode(signed.signature)),
        intentScope: IntentScope.personalMessage,
        address: account.getAddress(),
      );
      print('isValid=${result.isValid} reason=${result.reason}');
      expect(result.isValid, isTrue);
    });

    test('tampered message verifies false', () async {
      final account = SuiAccount.ed25519Account();
      final message = Uint8List.fromList(utf8.encode('original'));
      final signed = account.keyPair.signPersonalMessage(message);

      final result = await client.verifySignature(
        Uint8List.fromList(utf8.encode('tampered')),
        Uint8List.fromList(base64Decode(signed.signature)),
        intentScope: IntentScope.personalMessage,
        address: account.getAddress(),
      );
      expect(result.isValid, isFalse);
    });
  });

  group('MVR (Move Registry, mainnet)', () {
    final mvr = MvrClient.forNetwork(SuiNetwork.mainnet)!;

    test('resolvePackage resolves a registered @org/app name', () async {
      final pkg = await mvr.resolvePackage('@mvr/core');
      print('@mvr/core -> $pkg');
      expect(pkg, startsWith('0x'));
      expect(pkg.length, greaterThan(60));
    });

    test('resolvePackage passes through a plain address', () async {
      const addr = '0x2';
      expect(await mvr.resolvePackage(addr), addr);
    });

    test('resolveType passes through a plain type unchanged', () async {
      const type = '0x2::coin::Coin<0x2::sui::SUI>';
      expect(await mvr.resolveType(type), type);
    });
  });
}
