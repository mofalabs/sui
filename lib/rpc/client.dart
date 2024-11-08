import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sui/http/http.dart';
import 'package:sui/utils/error.dart';

class RequestOptions {
  Map<String, dynamic>? headers;
  Duration? connectTimeout;
  Duration? sendTimeout;
  Duration? receiveTimeout;
  RequestOptions({this.headers, this.connectTimeout, this.sendTimeout, this.receiveTimeout});
}

class JsonRpcClient {
  JsonRpcClient(
    this.url, {
    this.options,
  });

  final String url;
  RequestOptions? options;

  String get rpcVersion => "2.0";

  var _id = 0;

  Future<dynamic> request(String method, [List<dynamic>? args]) async {
    final result = await sendRequest(method, args ?? []);

    return result;
  }

  Future<dynamic> batchRequest(Iterable<Map<String, dynamic>> requests) async {
    final batchResult = <dynamic>[];

    for (var item in requests) {
      final resp = await request(item['method'], item['args']);
      batchResult.add(resp);
    }

    return batchResult;
  }

  Future<dynamic> sendRequest(String method, [dynamic parameters]) async {
    if (parameters is Iterable) parameters = parameters.toList();
    if (parameters is! Map && parameters is! List && parameters != null) {
      throw ArgumentError('Only maps and lists can be used as JSON-RPC '
          'parameters, was "$parameters".');
    }

    var message = <String, dynamic>{
      "jsonrpc": rpcVersion,
      "method": method,
      "id": _id
    };
    _id++;

    if (parameters != null) {
      message["params"] = parameters;
    }

    final dioOptions = Options(
      sendTimeout: options?.sendTimeout,
      receiveTimeout: options?.receiveTimeout,
      headers: options?.headers
    );

    http.options.connectTimeout = options?.connectTimeout ?? const Duration(seconds: 60);

    var data = (await http.post(
      url,
      data: message,
      options: dioOptions,
    )).data;

    if (data is String) {
      if (data.isEmpty) return data;
      data = jsonDecode(data);
    }

    if (data.containsKey("error") && data["error"] != null) {
      final error = data["error"];

      throw RPCError(
        RPCErrorRequest(method, parameters),
        error["code"],
        error["message"],
        error["data"],
      );
    } else {
      return data["result"];
    }
  }
}
