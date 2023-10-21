
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sui/types/event_filter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient {

  WebSocketChannel? _webSocketChannel;

  final Map<int, StreamController> streams = <int, StreamController>{};
  final Map<int, int> subscriptionIdToRequestId = <int, int>{};
  final Map<int, int> requestIdToSubscriptionId = <int, int>{};

  final String endpoint;

  int _id = 0;

  WebsocketClient(this.endpoint);

  WebSocketChannel setupClient() {
    if (_webSocketChannel != null) return _webSocketChannel!;
    final channel = WebSocketChannel.connect(Uri.parse(endpoint));
    channel.stream.listen((event) {
      final data = jsonDecode(event);
      if (data["error"] != null) {
        streams[data["id"]]?.addError(data["error"]);
      } else if (data["id"] != null && data["result"] != null) {
        final reqId = data["result"];
        final subId = data["id"];
        subscriptionIdToRequestId[reqId] = subId;
        requestIdToSubscriptionId[subId] = reqId;
      } else {
        final subId = data["params"]["subscription"];
        final sm = streams[subscriptionIdToRequestId[subId]];
        if (sm != null) {
          sm.sink.add(event);
        }
      }
    }, onError: (e) {
      debugPrint(e);
    }, onDone: () {
      // for (var key in streams.keys) {
        // streams[key]?.sink.close();
      // }
    });

    _webSocketChannel = channel;
    return _webSocketChannel!;
  }

  Stream<dynamic> send(dynamic data) {
    final client = setupClient();
    final controller = StreamController(
      onCancel: () {
        final cancel = {
          "jsonrpc": "2.0",
          "method": "suix_unsubscribeEvent",
          "params": [requestIdToSubscriptionId[data["id"]]]
        };
        client.sink.add(cancel);
      }
    );
    streams[data['id']] = controller;
    final sendData = jsonEncode(data);
    client.sink.add(sendData);
    return controller.stream;
  }

  Future close() async {
    _id = 0;
    _webSocketChannel?.sink.close();
    for (var sm in streams.values) {
      await sm.close();
    }
  }

  Stream<dynamic> subscribeEvent(Map filter) {
    _id++;
    final data = {
      "jsonrpc": "2.0",
      "id": _id,
      "method": "suix_subscribeEvent",
      "params": [filter]
    };
    return send(data);
  }

  Stream<dynamic> subscribeEventFilter(EventFilter filter) {
    _id++;
    final data = {
      "jsonrpc": "2.0",
      "id": _id,
      "method": "suix_subscribeEvent",
      "params": [filter.toJson()]
    };
    return send(data);
  }

  Stream<dynamic> subscribeTransaction(Map filter) {
    _id++;
    final data = {
      "jsonrpc": "2.0",
      "id": _id,
      "method": "suix_subscribeTransaction",
      "params": [filter]
    };
    return send(data);
  }

}