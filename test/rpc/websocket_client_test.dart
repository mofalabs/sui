
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/websocket_client.dart';

void main() {
  
  const String endpoint = Constants.websocketAPI;

  test('test websocket subscribeEvent', () async {
    final client = WebsocketClient(endpoint);
    final subscription = client.subscribeEvent({"Sender": "0x3b3f93ca910c0789de02468aa90c4d6351cde714cec1c1ab1c42376abdeb3cbe"})
    .listen((event) {
      debugPrint(event);
    }, onError: (e) {
      debugPrint(e);
    });

    await Future.delayed(const Duration(seconds: 30));

    subscription.cancel();
    debugPrint("===> cancel");

    await Future.delayed(const Duration(seconds: 10));
    debugPrint("===> finished");
  });

  test('test websocket subscribeTransaction', () async {
    final client = WebsocketClient(endpoint);
    final subscription = client.subscribeTransaction({
        "FromAddress": "0x0000000000000000000000000000000000000000000000000000000000000000"
    }).listen((event) {
      debugPrint(event);
    }, onError: (err) {
      debugPrint(err);
    }, onDone: () {
      debugPrint("onDone");
    });

    await Future.delayed(const Duration(seconds: 10));

    subscription.cancel();
    debugPrint("===> cancel");

    await Future.delayed(const Duration(minutes: 5));
    debugPrint("===> finished");
  });

}