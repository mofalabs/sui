@TestOn('browser')
library;

import 'dart:typed_data';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/grpc/transport/grpc_web_transport.dart';

// Start the fixture and this suite with `dart run tool/test_grpc_web_streaming.dart`.
const endpoint = String.fromEnvironment('SUI_GRPC_STREAM_FIXTURE_URL');

void main() {
  if (endpoint.isEmpty) {
    test(
      'real browser streaming fixture',
      () {},
      skip: 'Use dart run tool/test_grpc_web_streaming.dart',
    );
    return;
  }
  Dio client({Duration? connectTimeout, Duration? receiveTimeout}) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {'authorization': 'Bearer fixture'},
      ),
    );
    // Keep browser cookie configuration as well as Dio options/interceptors.
    (dio.httpClientAdapter as BrowserHttpClientAdapter).withCredentials = true;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['x-interceptor'] = 'present';
          handler.next(options);
        },
      ),
    );
    addTearDown(() => dio.close(force: true));
    return dio;
  }

  test('first frame arrives while the HTTP connection is still open', () async {
    final dio = client();
    final transport = GrpcWebTransport(endpoint, dio: dio);
    final clock = Stopwatch()..start();
    final first = await transport
        .serverStream('fixture', 'continuous', Uint8List(0))
        .first
        .timeout(const Duration(seconds: 2));
    expect(first, [42]);
    debugPrint(
      'First streaming frame: ${clock.elapsedMilliseconds}ms; server EOF after 4000ms',
    );
    expect(clock.elapsed, lessThan(const Duration(seconds: 2)));
  });

  test('connectTimeout stops watching once response headers arrive', () async {
    final transport = GrpcWebTransport(
      endpoint,
      dio: client(
        connectTimeout: const Duration(milliseconds: 150),
        receiveTimeout: const Duration(milliseconds: 500),
      ),
    );
    final frames = await transport
        .serverStream('fixture', 'continuous', Uint8List(0))
        .take(5)
        .toList()
        .timeout(const Duration(seconds: 2));
    expect(frames.length, 5);
  });

  test(
    'receiveTimeout aborts an idle response body after its first frame',
    () async {
      final transport = GrpcWebTransport(
        endpoint,
        dio: client(receiveTimeout: const Duration(milliseconds: 150)),
      );
      final seen = <List<int>>[];
      await expectLater(
        transport
            .serverStream('fixture', 'idle', Uint8List(0))
            .forEach(seen.add),
        throwsA(
          isA<GrpcWebException>().having(
            (error) => error.status,
            'status',
            GrpcStatus.deadlineExceeded,
          ),
        ),
      );
      expect(seen, [
        [42],
      ]);
    },
  );

  test('connectTimeout aborts a request still waiting for headers', () async {
    final transport = GrpcWebTransport(
      endpoint,
      dio: client(connectTimeout: const Duration(milliseconds: 150)),
    );
    await expectLater(
      transport.serverStream('fixture', 'headers', Uint8List(0)).toList(),
      throwsA(
        isA<GrpcWebException>().having(
          (error) => error.status,
          'status',
          GrpcStatus.deadlineExceeded,
        ),
      ),
    );
  });

  test(
    'subscription cancellation interrupts a pending response header',
    () async {
      final transport = GrpcWebTransport(endpoint, dio: client());
      final subscription = transport
          .serverStream('fixture', 'slowHeaders', Uint8List(0))
          .listen((_) {});
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final clock = Stopwatch()..start();
      await subscription.cancel().timeout(const Duration(milliseconds: 500));
      expect(clock.elapsed, lessThan(const Duration(milliseconds: 500)));
    },
  );

  test(
    'caller cancellation aborts the live fetch and preserves its status',
    () async {
      final token = CancelToken();
      final transport = GrpcWebTransport(endpoint, dio: client());
      await expectLater(
        transport
            .serverStream(
              'fixture',
              'continuous',
              Uint8List(0),
              cancelToken: token,
            )
            .forEach((_) => token.cancel('stop')),
        throwsA(
          isA<GrpcWebException>().having(
            (error) => error.status,
            'status',
            GrpcStatus.cancelled,
          ),
        ),
      );
    },
  );

  test('Dio.close(force: true) aborts an active response', () async {
    final dio = client();
    final transport = GrpcWebTransport(endpoint, dio: dio);
    await expectLater(
      transport
          .serverStream('fixture', 'continuous', Uint8List(0))
          .forEach((_) => dio.close(force: true)),
      throwsA(
        isA<GrpcWebException>().having(
          (error) => error.status,
          'status',
          GrpcStatus.cancelled,
        ),
      ),
    );
  });

  test(
    'subscription cancellation releases HTTP without cancelling a shared token',
    () async {
      final dio = client();
      final transport = GrpcWebTransport(endpoint, dio: dio);
      final sharedToken = CancelToken();
      expect(
        await transport
            .serverStream(
              'fixture',
              'cancelledSubscription',
              Uint8List(0),
              cancelToken: sharedToken,
            )
            .first,
        [42],
      );
      expect(sharedToken.isCancelled, isFalse);
      for (var attempt = 0; attempt < 20; attempt++) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        final response = await dio.get<Map<String, dynamic>>(
          '$endpoint/active?method=cancelledSubscription',
        );
        if (response.data!['active'] == 0) return;
      }
      fail(
        'HTTP connection remained active after StreamSubscription cancellation',
      );
    },
  );
}
