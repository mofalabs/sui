

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sui/sui.dart';

void showSnackBar(BuildContext context, String title, {int seconds = 3}) {
  Flushbar(
    icon: const Icon(Icons.info_outline),
    message: title,
    duration: Duration(seconds: seconds),
  ).show(context);
}

Future<SuiAccount> getLocalSuiAccount() async {
  const suiAccountKey = "sui_dart_account_key";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? priKey = prefs.getString(suiAccountKey);
  if (priKey == null) {
    SuiAccount account = SuiAccount.ed25519Account();
    String priKeyHex = account.privateKeyHex();
    await prefs.setString(suiAccountKey, priKeyHex);
    return account;
  }
  return SuiAccount.fromPrivateKey(priKey, SignatureScheme.ED25519);
}