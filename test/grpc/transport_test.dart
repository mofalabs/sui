import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/grpc/transport/grpc_web_transport.dart';
import 'package:sui/grpc/protocol_version.dart';

class _Adapter implements HttpClientAdapter {
  _Adapter(this.respond);
  final FutureOr<ResponseBody> Function(RequestOptions) respond;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? stream,
    Future<void>? cancelFuture,
  ) async => respond(options);
  @override
  void close({bool force = false}) {}
}

Uint8List _frame(List<int> payload, [int flag = 0]) {
  final result = Uint8List(5 + payload.length);
  result[0] = flag;
  ByteData.sublistView(result, 1, 5).setUint32(0, payload.length, Endian.big);
  result.setAll(5, payload);
  return result;
}

void main() {
  test(
    'protocol/header overrides and configured Dio timeouts reach requests',
    () async {
      final dio =
          Dio(
              BaseOptions(
                receiveTimeout: const Duration(seconds: 2),
                sendTimeout: const Duration(seconds: 3),
              ),
            )
            ..httpClientAdapter = _Adapter((options) {
              expect(options.headers[clientProtocolVersionHeader], '137');
              expect(options.headers['authorization'], 'Bearer fixture');
              expect(options.receiveTimeout, const Duration(seconds: 2));
              expect(options.sendTimeout, const Duration(seconds: 3));
              return ResponseBody.fromBytes(_frame([1, 2]), 200);
            });
      final transport = GrpcWebTransport(
        'https://fixture.test/',
        dio: dio,
        headers: {
          clientProtocolVersionHeader: '137',
          'authorization': 'Bearer fixture',
        },
      );
      expect(await transport.unary('service', 'method', Uint8List(0)), [1, 2]);
    },
  );

  test(
    'HTTP proxy errors preserve useful diagnostics and canonical status',
    () async {
      final dio = Dio()
        ..httpClientAdapter = _Adapter(
          (_) => ResponseBody.fromString('<html>upstream offline</html>', 503),
        );
      final transport = GrpcWebTransport('https://fixture.test', dio: dio);
      await expectLater(
        transport.unary('service', 'method', Uint8List(0)),
        throwsA(
          isA<GrpcWebException>()
              .having((e) => e.status, 'status', GrpcStatus.unavailable)
              .having(
                (e) => e.message,
                'message',
                contains('upstream offline'),
              ),
        ),
      );
    },
  );

  test('percent-encoded trailers decode reserved characters too', () async {
    final dio = Dio()
      ..httpClientAdapter = _Adapter(
        (_) => ResponseBody.fromBytes(
          _frame(
            ascii.encode(
              'grpc-status: 3\r\ngrpc-message: bad%3A%20%2Fcoin%3F\r\n',
            ),
            0x80,
          ),
          200,
        ),
      );
    await expectLater(
      GrpcWebTransport(
        'https://fixture.test',
        dio: dio,
      ).unary('service', 'method', Uint8List(0)),
      throwsA(
        isA<GrpcWebException>().having(
          (e) => e.message,
          'message',
          'bad: /coin?',
        ),
      ),
    );
  });

  test(
    'cancelled unary and streaming calls preserve cancellation status',
    () async {
      final token = CancelToken()..cancel('stopped');
      final transport = GrpcWebTransport('https://fixture.test');
      final cancelled = throwsA(
        isA<GrpcWebException>().having(
          (e) => e.status,
          'status',
          GrpcStatus.cancelled,
        ),
      );
      await expectLater(
        transport.unary('service', 'method', Uint8List(0), cancelToken: token),
        cancelled,
      );
      await expectLater(
        transport
            .serverStream('service', 'method', Uint8List(0), cancelToken: token)
            .toList(),
        cancelled,
      );
    },
  );

  test('fragmented server frames decode and truncated streams fail', () async {
    var truncated = false;
    final response = _frame([1, 2, 3]);
    final dio = Dio()
      ..httpClientAdapter = _Adapter((options) {
        expect(
          options.headers[clientProtocolVersionHeader],
          '$maxProtocolVersion',
        );
        return ResponseBody(
          Stream.fromIterable([
            response.sublist(0, 2),
            response.sublist(
              2,
              truncated ? response.length - 1 : response.length,
            ),
          ]),
          200,
        );
      });
    final transport = GrpcWebTransport('https://fixture.test', dio: dio);
    expect(
      await transport.serverStream('service', 'method', Uint8List(0)).toList(),
      [
        [1, 2, 3],
      ],
    );
    truncated = true;
    await expectLater(
      transport.serverStream('service', 'method', Uint8List(0)).toList(),
      throwsA(
        isA<GrpcWebException>().having(
          (e) => e.status,
          'status',
          GrpcStatus.internal,
        ),
      ),
    );
  });
}
