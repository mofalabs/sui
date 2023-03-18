

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, {int seconds = 3}) {
  Flushbar(
    icon: const Icon(Icons.info_outline),
    message: title,
    duration: Duration(seconds: seconds),
  ).show(context);
}