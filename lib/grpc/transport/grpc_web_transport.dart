import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// gRPC-web (unary) transport implemented over `dio`.
///
/// Sui public full nodes expose the `sui.rpc.v2` services as gRPC-web, which is
/// HTTP/1.1-friendly and works uniformly on Mobile, Web and Desktop (no HTTP/2
/// trailers, no Envoy proxy required). This mirrors what the official TypeScript
/// SDK does with `@protobuf-ts/grpcweb-transport` over `fetch`.
///
/// Wire format (unary):
///   request  body: one length-prefixed message frame
///   response body: one or more data frames followed by a trailer frame
///   frame = [1-byte flag][4-byte big-endian length][payload]
///     flag 0x00 -> data frame (protobuf-encoded message)
///     flag 0x80 -> trailer frame (HTTP-header-style `grpc-status`/`grpc-message`)
class GrpcWebTransport {
  GrpcWebTransport(
    this.baseUrl, {
    Dio? dio,
    this.headers = const {},
    this.maxRetries = 2,
  }) : _dio = dio ??
            (Dio()..options.connectTimeout = const Duration(seconds: 15));

  /// e.g. `https://fullnode.testnet.sui.io:443`
  final String baseUrl;
  final Map<String, String> headers;

  /// Number of extra attempts on transient connection failures.
  final int maxRetries;
  final Dio _dio;

  static const _contentType = 'application/grpc-web+proto';

  static bool _isTransient(DioException e) => switch (e.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        // TLS handshake drops / socket resets surface as `unknown`.
        DioExceptionType.unknown =>
          true,
        _ => false,
      };

  /// Invoke a unary RPC.
  ///
  /// [service] is the fully-qualified proto service name
  /// (e.g. `sui.rpc.v2.StateService`), [method] the RPC name (e.g. `GetBalance`),
  /// [request] the serialized request message bytes. Returns the serialized
  /// response message bytes.
  Future<Uint8List> unary(
    String service,
    String method,
    Uint8List request,
  ) async {
    final path = '${_trimTrailingSlash(baseUrl)}/$service/$method';
    final body = _encodeFrame(request);

    late final Response<List<int>> resp;
    DioException? lastError;
    // Retry transient connection failures (TLS handshake drops, resets, timeouts).
    for (var attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        resp = await _dio.post<List<int>>(
          path,
          // Send raw bytes (not a Stream) so dio sets Content-Length and avoids
          // chunked transfer encoding, which some fronting proxies reject.
          data: body,
          options: Options(
            responseType: ResponseType.bytes,
            contentType: _contentType,
            headers: {
              'accept': _contentType,
              'x-grpc-web': '1',
              'x-user-agent': 'grpc-web-dart/0.1',
              ...headers,
            },
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            // grpc-web signals errors via trailers, not HTTP status; accept all.
            validateStatus: (_) => true,
          ),
        );
        lastError = null;
        break;
      } on DioException catch (e) {
        lastError = e;
        if (attempt < maxRetries && _isTransient(e)) {
          await Future.delayed(Duration(milliseconds: 200 * (attempt + 1)));
          continue;
        }
        break;
      }
    }
    if (lastError != null) {
      throw GrpcWebException(
        GrpcStatus.unavailable,
        'HTTP transport error: ${lastError.type.name} '
        '${lastError.message ?? lastError.error ?? ''}',
      );
    }

    // Trailers-only responses put grpc-status in HTTP headers.
    final headerStatus = resp.headers.value('grpc-status');
    if (headerStatus != null && (resp.data == null || resp.data!.isEmpty)) {
      final code = int.tryParse(headerStatus) ?? GrpcStatus.unknown;
      if (code != GrpcStatus.ok) {
        throw GrpcWebException(
          code,
          resp.headers.value('grpc-message') ?? 'gRPC error',
        );
      }
    }

    if (resp.statusCode != null &&
        resp.statusCode! >= 400 &&
        (resp.data == null || resp.data!.isEmpty)) {
      throw GrpcWebException(
        GrpcStatus.unknown,
        'HTTP ${resp.statusCode} with empty body',
      );
    }

    return _decode(Uint8List.fromList(resp.data ?? const []));
  }

  /// Invoke a server-streaming RPC, yielding each response message's bytes as
  /// they arrive. Parses gRPC-web frames incrementally from the HTTP stream and
  /// throws [GrpcWebException] if a trailer reports a non-OK status.
  Stream<Uint8List> serverStream(
    String service,
    String method,
    Uint8List request,
  ) async* {
    final path = '${_trimTrailingSlash(baseUrl)}/$service/$method';
    final body = _encodeFrame(request);

    final Response<ResponseBody> resp;
    try {
      resp = await _dio.post<ResponseBody>(
        path,
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          contentType: _contentType,
          headers: {
            'accept': _contentType,
            'x-grpc-web': '1',
            'x-user-agent': 'grpc-web-dart/0.1',
            ...headers,
          },
          validateStatus: (_) => true,
        ),
      );
    } on DioException catch (e) {
      throw GrpcWebException(
        GrpcStatus.unavailable,
        'HTTP transport error: ${e.type.name} ${e.message ?? e.error ?? ''}',
      );
    }

    final pending = <int>[];
    var offset = 0;
    await for (final chunk in resp.data!.stream) {
      pending.addAll(chunk);
      while (pending.length - offset >= 5) {
        final flag = pending[offset];
        final len = (pending[offset + 1] << 24) |
            (pending[offset + 2] << 16) |
            (pending[offset + 3] << 8) |
            pending[offset + 4];
        if (pending.length - offset < 5 + len) break;
        final start = offset + 5;
        final payload = Uint8List.fromList(pending.sublist(start, start + len));
        offset = start + len;
        if ((flag & 0x80) != 0) {
          _checkTrailer(payload);
        } else {
          yield payload;
        }
      }
      // Compact the buffer once consumed to bound memory.
      if (offset > 0) {
        pending.removeRange(0, offset);
        offset = 0;
      }
    }
  }

  Uint8List _decode(Uint8List bytes) {
    Uint8List? message;
    int offset = 0;
    while (offset + 5 <= bytes.length) {
      final flag = bytes[offset];
      final length = ByteData.sublistView(bytes, offset + 1, offset + 5)
          .getUint32(0, Endian.big);
      final start = offset + 5;
      final end = start + length;
      if (end > bytes.length) break;
      final payload = bytes.sublist(start, end);
      offset = end;

      if ((flag & 0x80) != 0) {
        _checkTrailer(payload);
      } else {
        message = payload;
      }
    }

    if (message == null) {
      throw GrpcWebException(
        GrpcStatus.internal,
        'No data frame in gRPC-web response',
      );
    }
    return message;
  }

  void _checkTrailer(Uint8List payload) {
    final text = ascii.decode(payload, allowInvalid: true);
    int status = GrpcStatus.ok;
    String? message;
    for (final line in text.split(RegExp(r'\r\n|\n'))) {
      final idx = line.indexOf(':');
      if (idx <= 0) continue;
      final key = line.substring(0, idx).trim().toLowerCase();
      final value = line.substring(idx + 1).trim();
      if (key == 'grpc-status') {
        status = int.tryParse(value) ?? GrpcStatus.unknown;
      }
      if (key == 'grpc-message') message = Uri.decodeFull(value);
    }
    if (status != GrpcStatus.ok) {
      throw GrpcWebException(status, message ?? 'gRPC error');
    }
  }

  Uint8List _encodeFrame(Uint8List payload) {
    final frame = Uint8List(5 + payload.length);
    frame[0] = 0x00; // data frame, not compressed
    ByteData.sublistView(frame, 1, 5).setUint32(0, payload.length, Endian.big);
    frame.setRange(5, frame.length, payload);
    return frame;
  }

  static String _trimTrailingSlash(String s) =>
      s.endsWith('/') ? s.substring(0, s.length - 1) : s;
}

/// Standard gRPC status codes (subset used for mapping).
abstract class GrpcStatus {
  static const ok = 0;
  static const cancelled = 1;
  static const unknown = 2;
  static const invalidArgument = 3;
  static const deadlineExceeded = 4;
  static const notFound = 5;
  static const permissionDenied = 7;
  static const unavailable = 14;
  static const internal = 13;
}

class GrpcWebException implements Exception {
  GrpcWebException(this.status, this.message);
  final int status;
  final String message;

  @override
  String toString() => 'GrpcWebException(status: $status, message: $message)';
}
