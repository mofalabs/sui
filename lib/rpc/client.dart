
import 'dart:convert';

import 'package:sui/constants.dart';
import 'package:sui/http/http.dart';

/// An object defining headers to be passed to the RPC server
typedef HttpHeaders = Map<String, String>;


class RpcParams {
  String method;
  List<dynamic> args;

  RpcParams(this.method, this.args);
}

const TYPE_MISMATCH_ERROR =
  "The response returned from RPC server does not match " +
  "the TypeScript definition. This is likely because the SDK version is not " +
  "compatible with the RPC server. Please update your SDK version to the latest. ";

class JsonRpcClient {
  var _id = 0;
  final String url;

  JsonRpcClient(this.url);

  String get rpcVersion => "2.0";
  Map<String, dynamic> get headers => {};

  Future<dynamic> request(
    String method,
    List<dynamic> args
  ) async {
    final resp = await sendRequest(method, args);
    return resp;
  }

  Future batchRequest(
    Iterable<Map<String, dynamic>> requests
  ) async {
    final batchResp = <dynamic>[];
    for (var item in requests) {
      final resp = await request(item['method'], item['args']);
      batchResp.add(resp);
    }
    return batchResp;
  }

  Future<dynamic> sendRequest(String method, [dynamic parameters]) async {
    if (parameters is Iterable) parameters = parameters.toList();
    if (parameters is! Map && parameters is! List && parameters != null) {
      throw ArgumentError('Only maps and lists can be used as JSON-RPC '
          'parameters, was "$parameters".');
    }

    var message = <String, dynamic>{"jsonrpc": rpcVersion, "method": method, "id": _id};
    _id++;
    if (parameters != null) {
      message["params"] = parameters;
    }

    try {
      var data = (await http.post(url, data: message)).data;
      if (data is String) {
        if (data.isEmpty) return data;
        data = jsonDecode(data);
      }
      if (data.containsKey("error") && data["error"] != null) {
        throw Exception(data["error"]);
      } else {
        return data["result"];
      }
    } catch (e) {
      // TODO: process exception
      rethrow;
    }
  }

}