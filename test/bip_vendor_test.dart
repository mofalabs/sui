import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hex/hex.dart';
import 'package:sui/cryptography/bip39/bip39.dart' as bip39;
import 'package:sui/cryptography/bip32/bip32.dart';

/// Byte-for-byte correctness of the vendored bip32/bip39 (inlined into
/// lib/cryptography) against the official BIP-0039 / BIP-0032 test vectors.
/// This guards the wallet key derivation independently of any network.
void main() {
  group('bip39 (vendored)', () {
    // Official BIP-0039 English vector (passphrase "TREZOR").
    const mnemonic =
        'abandon abandon abandon abandon abandon abandon abandon abandon '
        'abandon abandon abandon about';
    const expectedSeed =
        'c55257c360c07c72029aebc1b53c05ed0362ada38ead3e3e9efa3708e5349553'
        '1f09a6987599d18264c1e1c92f2cf141630c7a3c4ab7c81b2f001698e7463b04';

    test('mnemonicToSeed matches BIP-0039 vector', () {
      final seed = bip39.mnemonicToSeed(mnemonic, passphrase: 'TREZOR');
      expect(HEX.encode(seed), expectedSeed);
    });

    test('validateMnemonic accepts valid, rejects invalid', () {
      expect(bip39.validateMnemonic(mnemonic), isTrue);
      expect(bip39.validateMnemonic('$mnemonic wrong'), isFalse);
      expect(bip39.validateMnemonic('not a real mnemonic phrase at all'),
          isFalse);
    });

    test('generateMnemonic produces a valid 12-word phrase', () {
      final m = bip39.generateMnemonic();
      expect(m.split(' ').length, 12);
      expect(bip39.validateMnemonic(m), isTrue);
    });
  });

  group('bip32 (vendored)', () {
    // Official BIP-0032 Test Vector 1: seed 000102...0f.
    final seed = Uint8ListFromHex('000102030405060708090a0b0c0d0e0f');
    const masterPriv =
        'e8f32e723decf4051aefac8e2c93c9c5b214313817cdb01a1494b917c8436b35';
    const masterChain =
        '873dff81c02f525623fd1fe5167eac3a55a049de3d314bb42ee227ffed37d508';

    test('fromSeed master key matches BIP-0032 vector', () {
      final node = BIP32.fromSeed(seed);
      expect(HEX.encode(node.privateKey!), masterPriv);
      expect(HEX.encode(node.chainCode), masterChain);
    });

    test("derivePath m/0' matches BIP-0032 vector", () {
      // m/0' hardened child private key from Test Vector 1.
      const child0hPriv =
          'edb2e14f9ee77d26dd93b4ecede8d16ed408ce149b6cd80b0715a2d911a0afea';
      final node = BIP32.fromSeed(seed).derivePath("m/0'");
      expect(HEX.encode(node.privateKey!), child0hPriv);
    });

    test('round-trips through base58 (kept for completeness)', () {
      final node = BIP32.fromSeed(seed);
      final restored = BIP32.fromBase58(node.toBase58());
      expect(HEX.encode(restored.privateKey!), masterPriv);
    });
  });
}

Uint8List Uint8ListFromHex(String hex) => Uint8List.fromList(HEX.decode(hex));
