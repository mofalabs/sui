
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

  Future request(
    String method,
    List<dynamic> args,
    [bool skipDataValidation = true]
  ) async {
    final expectedSchema = await sendRequest(method, args);
    final errMsg =
      TYPE_MISMATCH_ERROR +
      'Result received was: ${jsonEncode(expectedSchema)}';

    if (skipDataValidation && expectedSchema != null) {
      return expectedSchema;
    } else if (expectedSchema != null) {
      // data validation
      throw ArgumentError("RPC Error: $errMsg");
    }
    return expectedSchema;
  }

  Future batchRequest(
    Iterable<Map<String, dynamic>> requests,
    [bool skipDataValidation = false]
  ) async {
    final batchResp = <dynamic>[];
    for (var item in requests) {
      final resp = await request(item['method'], item['args'], skipDataValidation);
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
        data = jsonDecode(data.trim());
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

class ValidResponse {
  String jsonrpc = '2.0';
  String id;
  String result;

  ValidResponse(this.id, this.result);
}

class Error {
  dynamic code;
  String message;
  dynamic data;

  Error(this.code, this.message, this.data);
}

class ErrorResponse {
  String jsonrpc = '2.0';
  String id;
  Error error;

  ErrorResponse(this.id, this.error);
}
