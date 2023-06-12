
import 'dart:math';
import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:pointycastle/export.dart';

/// Parse and validate a path that is compliant to SLIP-0010 in form m/44'/784'/{account_index}'/{change_index}'/{address_index}'.
///
/// [path] string (e.g. `m/44'/784'/0'/0'/0'`).
bool isValidHardenedPath(String path) {
  if (!RegExp(r"^m/44'/784'/[0-9]+'/[0-9]+'/[0-9]+'+$").hasMatch(path)) {
    return false;
  }
  return true;
}

/// Parse and validate a path that is compliant to BIP-32 in form m/54'/784'/{account_index}'/{change_index}/{address_index}
/// for Secp256k1 and m/74'/784'/{account_index}'/{change_index}/{address_index} for Secp256r1.
///
/// Note that the purpose for Secp256k1 is registered as 54, to differentiate from Ed25519 with purpose 44.
/// @param path path string (e.g. `m/54'/784'/0'/0/0`).
bool isValidBIP32Path(String path) {
  if (!RegExp(r"^m/(54|74)'/784'/[0-9]+'/[0-9]+/[0-9]+$").hasMatch(path)) {
    return false;
  }
  return true;
}

/// Uses KDF to derive 64 bytes of key data from mnemonic with empty password.
Uint8List mnemonicToSeed(String mnemonics) {
  if (!isValidMnemonics(mnemonics)) {
    throw ArgumentError("Invalid mnemonics");
  }
  
  return bip39.mnemonicToSeed(mnemonics, passphrase: "");
}

/// Derive the seed in hex format from mnemonic with empty password.
String mnemonicToSeedHex(String mnemonics) {
  if (!isValidMnemonics(mnemonics)) {
    throw ArgumentError("Invalid mnemonics");
  }

  return bip39.mnemonicToSeedHex(mnemonics, passphrase: "");
}

String generateMnemonic({int strength = 128 }) {
  return bip39.generateMnemonic(strength: strength, randomBytes: _getRandom().nextBytes);
}

bool isValidMnemonics(String mnemonics) {
  return bip39.validateMnemonic(mnemonics);
}

SecureRandom _getRandom() {
  final secureRandom = FortunaRandom();
  final seedSource = Random.secure();
  final seeds = <int>[];
  for (int i = 0; i < 32; i++) {
    seeds.add(seedSource.nextInt(255));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
  return secureRandom;
}