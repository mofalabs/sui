import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sui/http/interceptor.dart';

class Http extends DioForBrowser {
  static Http? instance;

  factory Http() {
      instance ??= Http._().._init();
    return instance!;
  }

  Http._();

  _init() {
    options.connectTimeout = const Duration(seconds: 5);
    options.receiveTimeout = const Duration(seconds: 10);

    options.headers["Content-Type"] = "application/json; charset=UTF-8";

    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors.add(ApiInterceptor());
  }
}

_parseAndDecode(String response) => jsonDecode(response);

parseJson(String text) => compute(_parseAndDecode, text);