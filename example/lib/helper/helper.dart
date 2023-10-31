

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sui/sui.dart';

var suiClient = SuiClient(Constants.devnetAPI);

void showSnackBar(BuildContext context, String title, {int seconds = 3}) {
  Flushbar(
    icon: const Icon(Icons.info_outline),
    message: title,
    duration: Duration(seconds: seconds),
  ).show(context);
}

void showToast(BuildContext context, String title, {int seconds = 3, bool success = true}) {
  Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: success ? Colors.greenAccent : Colors.redAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(success ? Icons.check : Icons.close),
            SizedBox(width: 12.0),
            Text(title),
        ],
        ),
    );
  FToast().init(context).showToast(
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 3),
    child: toast
  );
}

void showErrorToast(BuildContext context, String title, {int seconds = 3}) {
  showToast(context, title, seconds: seconds, success: false);
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