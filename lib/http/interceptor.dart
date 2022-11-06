
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sui/constants.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Constants.enableDebugLog) {
      debugPrint("");
      debugPrint("--------------- request ---------------");
      debugPrint(options.uri.toString());
      debugPrint(options.headers.toString());
      debugPrint(options.contentType == "application/json" ? jsonEncode(options.data) : options.data.toString());
      debugPrint("--------------- request end -------------");
      debugPrint("");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Constants.enableDebugLog) {
      debugPrint("");
      debugPrint("--------------- response ---------------");
      debugPrint(response.data.toString());
      debugPrint("------------- response end -------------");
      debugPrint("");
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Constants.enableDebugLog) {
      debugPrint("");
      debugPrint("--------------- error ---------------");
      debugPrint(err.toString());
      debugPrint(err.response.toString());
      debugPrint("------------- error end ------------");
      debugPrint("");
    }
    super.onError(err, handler);
  }
}