import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:sui/http/interceptor.dart';

final Http http = Http();

class Http extends DioForNative {
  static Http? instance;

  factory Http() {
      instance ??= Http._().._init();
    return instance!;
  }

  Http._();

  _init() {
    options.connectTimeout = 5000;
    options.receiveTimeout = 10000;

    options.headers["Content-Type"] = "application/json; charset=UTF-8";

    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors.add(ApiInterceptor());
  }
}

_parseAndDecode(String response) => jsonDecode(response);

parseJson(String text) => compute(_parseAndDecode, text);