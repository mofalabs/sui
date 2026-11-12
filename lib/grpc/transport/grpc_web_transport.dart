import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../protocol_version.dart';
import 'streaming_dio.dart'
    if (dart.library.js_interop) 'streaming_dio_web.dart';

/// gRPC-web unary and server-streaming transport implemented over `dio`.
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
  }) : _dio = configureStreamingDio(
         dio ?? (Dio()..options.connectTimeout = const Duration(seconds: 15)),
       );

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
    DioExceptionType.unknown => true,
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
    Uint8List request, {
    CancelToken? cancelToken,
    Map<String, String> metadata = const {},
    Duration? timeout,
  }) async {
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
          cancelToken: cancelToken,
          options: Options(
            responseType: ResponseType.bytes,
            contentType: _contentType,
            headers: {
              'accept': _contentType,
              'x-grpc-web': '1',
              'x-user-agent': 'grpc-web-dart/0.1',
              // Lets the server avoid sending types this SDK cannot decode.
              // Caller-supplied headers win.
              clientProtocolVersionHeader: '$maxProtocolVersion',
              ...headers,
              ...metadata,
            },
            sendTimeout: timeout,
            receiveTimeout: timeout,
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
        lastError.type == DioExceptionType.cancel
            ? GrpcStatus.cancelled
            : (lastError.type == DioExceptionType.connectionTimeout ||
                  lastError.type == DioExceptionType.sendTimeout ||
                  lastError.type == DioExceptionType.receiveTimeout)
            ? GrpcStatus.deadlineExceeded
            : GrpcStatus.unavailable,
        'HTTP transport error: ${lastError.type.name} '
        '${lastError.message ?? lastError.error ?? ''}',
      );
    }

    // Trailers-only responses (a legal gRPC error shape) put grpc-status in
    // the HTTP headers; honour it whether or not a body came along.
    _checkHeaderStatus(resp);

    return _decode(Uint8List.fromList(resp.data ?? const []), resp);
  }

  static int _dioStatus(DioException error) => switch (error.type) {
    DioExceptionType.cancel => GrpcStatus.cancelled,
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => GrpcStatus.deadlineExceeded,
    _ => GrpcStatus.unavailable,
  };

  /// Throws when the HTTP headers carry a non-OK `grpc-status`
  /// (a trailers-only response).
  void _checkHeaderStatus(Response resp) {
    final headerStatus = resp.headers.value('grpc-status');
    if (headerStatus == null) return;
    final code = int.tryParse(headerStatus) ?? GrpcStatus.unknown;
    if (code != GrpcStatus.ok) {
      throw GrpcWebException(
        code,
        _decodeGrpcMessage(resp.headers.value('grpc-message') ?? 'gRPC error'),
      );
    }
  }

  /// Maps an HTTP status to the canonical gRPC code (gRPC-web spec) for
  /// responses that carry no gRPC framing at all (LB/proxy error pages).
  static int _httpToGrpcStatus(int httpStatus) => switch (httpStatus) {
    400 => GrpcStatus.internal,
    401 => GrpcStatus.unauthenticated,
    403 => GrpcStatus.permissionDenied,
    404 => GrpcStatus.unimplemented,
    429 || 502 || 503 || 504 => GrpcStatus.unavailable,
    _ => GrpcStatus.unknown,
  };

  /// A short printable preview of a non-gRPC body (an HTML error page, JSON
  /// error, …) so transport failures stay diagnosable.
  static String _bodyPreview(Uint8List bytes) {
    if (bytes.isEmpty) return 'empty body';
    final text = utf8
        .decode(bytes, allowMalformed: true)
        .replaceAll(RegExp(r'[\x00-\x1f]+'), ' ')
        .trim();
    final preview = text.length > 160 ? '${text.substring(0, 160)}…' : text;
    return '${bytes.length}-byte body: "$preview"';
  }

  /// Invoke a server-streaming RPC, yielding each response message's bytes as
  /// they arrive. Parses gRPC-web frames incrementally from the HTTP stream and
  /// throws [GrpcWebException] if a trailer reports a non-OK status.
  Stream<Uint8List> serverStream(
    String service,
    String method,
    Uint8List request, {
    CancelToken? cancelToken,
    Map<String, String> metadata = const {},
  }) {
    // onCancel must abort even before response headers arrive: an async*
    // generator alone cannot run its finally block while awaiting HTTP.
    late StreamController<Uint8List> controller;
    StreamSubscription<Uint8List>? subscription;
    StreamSubscription<DioException>? cancellationRelay;
    final requestToken = CancelToken();
    controller = StreamController<Uint8List>(
      onListen: () {
        if (cancelToken != null) {
          if (cancelToken.isCancelled) {
            requestToken.cancel(cancelToken.cancelError);
          } else {
            cancellationRelay = cancelToken.whenCancel.asStream().listen(
              requestToken.cancel,
            );
          }
        }
        subscription =
            _serverStream(
              service,
              method,
              request,
              requestToken: requestToken,
              metadata: metadata,
            ).listen(
              controller.add,
              onError: controller.addError,
              onDone: controller.close,
            );
      },
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
      onCancel: () async {
        requestToken.cancel('gRPC stream closed');
        await cancellationRelay?.cancel();
        try {
          await subscription?.cancel();
        } on GrpcWebException {
          // Aborting an HTTP await can reject the generator's cancellation
          // Future; cancellation must still complete successfully for .first.
        }
      },
    );
    return controller.stream;
  }

  Stream<Uint8List> _serverStream(
    String service,
    String method,
    Uint8List request, {
    required CancelToken requestToken,
    required Map<String, String> metadata,
  }) async* {
    final path = '${_trimTrailingSlash(baseUrl)}/$service/$method';
    final body = _encodeFrame(request);
    try {
      final Response<ResponseBody> resp;
      try {
        resp = await _dio.post<ResponseBody>(
          path,
          data: body,
          cancelToken: requestToken,
          options: Options(
            responseType: ResponseType.stream,
            contentType: _contentType,
            headers: {
              'accept': _contentType,
              'x-grpc-web': '1',
              'x-user-agent': 'grpc-web-dart/0.1',
              clientProtocolVersionHeader: '$maxProtocolVersion',
              ...headers,
              ...metadata,
            },
            validateStatus: (_) => true,
          ),
        );
      } on DioException catch (e) {
        throw GrpcWebException(
          _dioStatus(e),
          'HTTP transport error: ${e.type.name} ${e.message ?? e.error ?? ''}',
        );
      }

      _checkHeaderStatus(resp);
      if ((resp.statusCode ?? 200) >= 400) {
        throw GrpcWebException(
          _httpToGrpcStatus(resp.statusCode!),
          'HTTP ${resp.statusCode}',
        );
      }
      final pending = <int>[];
      var offset = 0;
      try {
        await for (final chunk in resp.data!.stream) {
          pending.addAll(chunk);
          while (pending.length - offset >= 5) {
            final flag = pending[offset];
            if (flag != 0 && flag != 0x80) {
              throw GrpcWebException(
                GrpcStatus.unimplemented,
                'Unsupported gRPC-web frame flag $flag',
              );
            }
            final len =
                (pending[offset + 1] << 24) |
                (pending[offset + 2] << 16) |
                (pending[offset + 3] << 8) |
                pending[offset + 4];
            if (pending.length - offset < 5 + len) break;
            final start = offset + 5;
            final payload = Uint8List.fromList(
              pending.sublist(start, start + len),
            );
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
      } on DioException catch (error) {
        throw GrpcWebException(
          _dioStatus(error),
          error.message ?? 'Stream transport error',
        );
      }

      if (pending.isNotEmpty) {
        throw GrpcWebException(
          GrpcStatus.internal,
          'Truncated gRPC-web response frame',
        );
      }
    } finally {
      requestToken.cancel('gRPC stream closed');
    }
  }

  Uint8List _decode(Uint8List bytes, Response response) {
    if (bytes.isNotEmpty && bytes.first != 0 && bytes.first != 0x80) {
      throw GrpcWebException(
        _httpToGrpcStatus(response.statusCode ?? 200),
        'HTTP ${response.statusCode}: ${_bodyPreview(bytes)}',
      );
    }
    Uint8List? message;
    int offset = 0;
    while (offset + 5 <= bytes.length) {
      final flag = bytes[offset];
      final length = ByteData.sublistView(
        bytes,
        offset + 1,
        offset + 5,
      ).getUint32(0, Endian.big);
      final start = offset + 5;
      final end = start + length;
      if (end > bytes.length) {
        throw GrpcWebException(
          GrpcStatus.internal,
          'Truncated gRPC-web response frame',
        );
      }
      final payload = bytes.sublist(start, end);
      offset = end;

      if ((flag & 0x80) != 0) {
        _checkTrailer(payload);
      } else {
        message = payload;
      }
    }

    if (offset != bytes.length) {
      throw GrpcWebException(
        GrpcStatus.internal,
        'Truncated gRPC-web response frame',
      );
    }
    if (message == null) {
      throw GrpcWebException(
        (response.statusCode ?? 200) >= 400
            ? _httpToGrpcStatus(response.statusCode!)
            : GrpcStatus.internal,
        'HTTP ${response.statusCode}: no data frame in gRPC-web response (${_bodyPreview(bytes)})',
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
      if (key == 'grpc-message') message = _decodeGrpcMessage(value);
    }
    if (status != GrpcStatus.ok) {
      throw GrpcWebException(status, message ?? 'gRPC error');
    }
  }

  /// `grpc-message` values are percent-encoded (gRPC-web spec); decode them
  /// for human-readable errors, keeping the raw value on malformed escapes.
  static String _decodeGrpcMessage(String value) {
    try {
      return Uri.decodeComponent(value);
    } catch (_) {
      return value;
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
  static const resourceExhausted = 8;
  static const failedPrecondition = 9;
  static const aborted = 10;
  static const outOfRange = 11;
  static const unimplemented = 12;
  static const unavailable = 14;
  static const internal = 13;
  static const dataLoss = 15;
  static const unauthenticated = 16;
}

class GrpcWebException implements Exception {
  GrpcWebException(this.status, this.message);
  final int status;
  final String message;

  @override
  String toString() => 'GrpcWebException(status: $status, message: $message)';
}
