// Runs browser regressions against a real, local, chunked HTTP server.
// Usage: dart run tool/test_grpc_web_streaming.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Uint8List frame(List<int> payload, [int flag = 0]) {
  final bytes = Uint8List(5 + payload.length)..[0] = flag;
  ByteData.sublistView(bytes, 1, 5).setUint32(0, payload.length, Endian.big);
  bytes.setAll(5, payload);
  return bytes;
}

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final active = <String, int>{};
  final sockets = <Socket>{};
  server.listen((request) async {
    final response = request.response;
    response.headers
      ..set(
        'Access-Control-Allow-Origin',
        request.headers.value('origin') ?? '*',
      )
      ..set('Access-Control-Allow-Credentials', 'true')
      ..set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')
      ..set(
        'Access-Control-Allow-Headers',
        request.headers.value('access-control-request-headers') ?? '*',
      )
      ..set('Access-Control-Expose-Headers', 'grpc-status, grpc-message');
    if (request.method == 'OPTIONS') {
      response.statusCode = HttpStatus.noContent;
      await response.close();
      return;
    }
    if (request.uri.path == '/active') {
      response.headers.contentType = ContentType.json;
      response.write(
        jsonEncode({
          'active': active[request.uri.queryParameters['method']] ?? 0,
        }),
      );
      await response.close();
      return;
    }
    await request.drain<void>();
    final method = request.uri.pathSegments.last;
    if (request.headers.value('authorization') != 'Bearer fixture' ||
        request.headers.value('x-interceptor') != 'present' ||
        request.headers.value('x-sui-client-protocol-version') != '138') {
      response.statusCode = HttpStatus.badRequest;
      response.write('Dio configuration/header was not preserved');
      await response.close();
      return;
    }
    // Observe the actual TCP read side: HttpResponse.done can remain pending
    // after a peer abort until the producer finishes writing the response.
    response.headers.contentType = ContentType('application', 'grpc-web+proto');
    final headerText = StringBuffer('HTTP/1.1 200 OK\r\n');
    response.headers.forEach((name, values) {
      for (final value in values) {
        headerText.write('$name: $value\r\n');
      }
    });
    headerText.write('transfer-encoding: chunked\r\n\r\n');
    final socket = await response.detachSocket(writeHeaders: false);
    sockets.add(socket);
    socket.setOption(SocketOption.tcpNoDelay, true);
    active[method] = (active[method] ?? 0) + 1;
    var completed = false;
    void finish() {
      if (completed) return;
      completed = true;
      active[method] = active[method]! - 1;
    }

    socket.listen((_) {}, onDone: finish, onError: (Object _) => finish());
    unawaited(socket.done.then((_) {}, onError: (Object _) {}));
    Future<void> send(Uint8List chunk) async {
      socket.write('${chunk.length.toRadixString(16)}\r\n');
      socket.add(chunk);
      socket.write('\r\n');
      await socket.flush();
    }

    try {
      if (method == 'headers' || method == 'slowHeaders') {
        await Future<void>.delayed(
          Duration(milliseconds: method == 'headers' ? 600 : 2000),
        );
      }
      if (completed) return;
      socket.write(headerText.toString());
      await send(frame([42]));
      if (method == 'idle') {
        await Future<void>.delayed(const Duration(seconds: 2));
      } else {
        for (var index = 0; index < 40 && !completed; index++) {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          if (completed) break;
          await send(frame([43]));
        }
      }
      if (!completed) {
        await send(frame(ascii.encode('grpc-status: 0\r\n'), 0x80));
        socket.write('0\r\n\r\n');
        await socket.flush();
      }
    } on SocketException {
      // Expected when the browser aborts an in-flight response body.
    } finally {
      finish();
      socket.destroy();
      sockets.remove(socket);
    }
  });
  Process? test;
  try {
    test = await Process.start('flutter', [
      'test',
      '--no-pub',
      '--platform',
      'chrome',
      '--dart-define=SUI_GRPC_STREAM_FIXTURE_URL=http://127.0.0.1:${server.port}',
      'test/grpc/grpc_web_streaming_integration_test.dart',
    ]);
    final output = Future.wait([
      stdout.addStream(test.stdout),
      stderr.addStream(test.stderr),
    ]);
    exitCode = await test.exitCode;
    await output;
  } finally {
    test?.kill();
    for (final socket in sockets.toList()) {
      socket.destroy();
    }
    await server.close(force: true);
  }
}
