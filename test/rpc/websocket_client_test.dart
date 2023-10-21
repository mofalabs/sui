
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

void main() {
  
  const String endpoint = Constants.websocketAPI;

  test('test websocket subscribeEvent', () async {
    final client = WebsocketClient(endpoint);

    // final subscription = client.subscribeEvent({"Sender": "0x02a212de6a9dfa3a69e22387acfbafbb1a9e591bd9d636e7895dcfc8de05f331"})
    // .listen((event) {
    //   debugPrint(event);
    // }, onError: (e) {
    //   debugPrint(e.toString());
    // });

    final subscription = client.subscribeEventFilter(EventFilter(sender: "0x02a212de6a9dfa3a69e22387acfbafbb1a9e591bd9d636e7895dcfc8de05f331"))
    .listen((event) {
      debugPrint(event);
    }, onError: (e) {
      debugPrint(e.toString());
    });

    await Future.delayed(const Duration(seconds: 10));

    subscription.cancel();
    debugPrint("===> cancel");

    await Future.delayed(const Duration(seconds: 5));
    debugPrint("===> finished");
  });

  test('test websocket subscribeTransaction', () async {
    final client = WebsocketClient(endpoint);
    final subscription = client.subscribeTransaction({
        "FromAddress": "0x0000000000000000000000000000000000000000000000000000000000000000"
    }).listen((event) {
      debugPrint(event);
    }, onError: (e) {
      debugPrint(e.toString());
    });

    await Future.delayed(const Duration(seconds: 10));

    subscription.cancel();
    debugPrint("===> cancel");

    await Future.delayed(const Duration(seconds: 5));
    debugPrint("===> finished");
  });

}