import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:web/web.dart' as web;

/// Dio's default browser adapter buffers XHR responses until EOF, even for
/// ResponseType.stream. Keep its configuration and unary requests, but use
/// Fetch's ReadableStream for streamed responses. Explicit custom adapters are
/// left untouched, including subclasses overriding the browser adapter.
Dio configureStreamingDio(Dio dio) {
  final adapter = dio.httpClientAdapter;
  if (adapter.runtimeType == BrowserHttpClientAdapter) {
    dio.httpClientAdapter = _StreamingBrowserAdapter(
      adapter as BrowserHttpClientAdapter,
    );
  }
  return dio;
}

class _StreamingBrowserAdapter implements HttpClientAdapter {
  _StreamingBrowserAdapter(this.fallback);

  final BrowserHttpClientAdapter fallback;
  final Set<_FetchOperation> _active = {};
  bool _closed = false;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_closed) throw StateError('HTTP adapter is closed');
    if (options.responseType != ResponseType.stream) {
      return fallback.fetch(options, requestStream, cancelFuture);
    }
    final operation = _FetchOperation(options, _active.remove);
    _active.add(operation);
    cancelFuture?.then((_) {
      operation.abort(
        options.cancelToken?.cancelError ??
            DioException.requestCancelled(
              requestOptions: options,
              reason: 'Request cancelled',
            ),
      );
    });
    try {
      // gRPC requests have a finite protobuf body. Fetch does not expose real
      // upload progress; preparation is bounded by sendTimeout and progress
      // reports bytes handed to Fetch. Connection timeout covers response
      // headers only. Dio handles receiveTimeout between body chunks.
      Future<Uint8List>? prepared = requestStream
          ?.fold<BytesBuilder>(
            BytesBuilder(copy: false),
            (builder, chunk) => builder..add(chunk),
          )
          .then((builder) => builder.takeBytes());
      final sendTimeout = options.sendTimeout;
      if (prepared != null &&
          sendTimeout != null &&
          sendTimeout > Duration.zero) {
        prepared = prepared.timeout(
          sendTimeout,
          onTimeout: () {
            final error = DioException.sendTimeout(
              timeout: sendTimeout,
              requestOptions: options,
            );
            operation.abort(error);
            throw error;
          },
        );
      }
      final body = await prepared;
      operation.throwIfAborted();
      final headers = web.Headers();
      options.headers.forEach((name, value) {
        if (name.toLowerCase() == Headers.contentLengthHeader ||
            value == null) {
          return;
        }
        headers.set(
          name,
          value is Iterable ? value.join(', ') : value.toString(),
        );
      });
      final credentials = options.extra['withCredentials'];
      var response = web.window
          .fetch(
            options.uri.toString().toJS,
            web.RequestInit(
              method: options.method,
              headers: headers,
              body: body?.toJS,
              credentials:
                  (credentials == null
                      ? fallback.withCredentials
                      : credentials == true)
                  ? 'include'
                  : 'same-origin',
              redirect: options.followRedirects ? 'follow' : 'manual',
              signal: operation.controller.signal,
            ),
          )
          .toDart;
      if (body != null) options.onSendProgress?.call(body.length, body.length);
      final connectTimeout = options.connectTimeout;
      if (connectTimeout != null && connectTimeout > Duration.zero) {
        response = response.timeout(
          connectTimeout,
          onTimeout: () {
            final error = DioException.connectionTimeout(
              timeout: connectTimeout,
              requestOptions: options,
            );
            operation.abort(error);
            throw error;
          },
        );
      }
      final received = await response;
      operation.throwIfAborted();
      final responseHeaders = <String, List<String>>{};
      _IterableHeaders(received.headers).forEach(
        ((JSString value, JSString key) {
          responseHeaders[key.toDart.toLowerCase()] = [value.toDart];
        }).toJS,
      );
      return ResponseBody(
        operation.read(received.body),
        received.status,
        headers: responseHeaders,
        statusMessage: received.statusText,
        isRedirect: received.redirected,
        onClose: operation.close,
      );
    } catch (error, stack) {
      final mapped =
          operation.failure ??
          (error is DioException
              ? error
              : DioException.connectionError(
                  requestOptions: options,
                  reason: 'Fetch failed: $error',
                  error: error,
                  stackTrace: stack,
                ));
      operation.close();
      Error.throwWithStackTrace(mapped, stack);
    }
  }

  @override
  void close({bool force = false}) {
    _closed = true;
    fallback.close(force: force);
    if (force) {
      for (final operation in _active.toList()) {
        operation.abort(
          DioException.requestCancelled(
            requestOptions: operation.options,
            reason: 'HTTP adapter closed',
          ),
        );
      }
    }
  }
}

class _FetchOperation {
  _FetchOperation(this.options, this._onClose);
  final RequestOptions options;
  final void Function(_FetchOperation) _onClose;
  final controller = web.AbortController();
  DioException? failure;
  bool _closed = false;

  void abort(DioException reason) {
    if (_closed) return;
    failure ??= reason;
    close();
  }

  void throwIfAborted() {
    if (failure != null) throw failure!;
  }

  void close() {
    if (_closed) return;
    _closed = true;
    controller.abort();
    _onClose(this);
  }

  Stream<Uint8List> read(web.ReadableStream? body) async* {
    web.ReadableStreamDefaultReader? reader;
    try {
      throwIfAborted();
      if (body == null) return;
      reader = body.getReader() as web.ReadableStreamDefaultReader;
      while (true) {
        final chunk = await reader.read().toDart;
        throwIfAborted();
        if (chunk.done) break;
        yield (chunk.value as JSUint8Array).toDart;
      }
    } catch (error, stack) {
      // Dio reports token cancellation/timeouts itself and cancels this source.
      // Its cancellation Future must not fail again when abort rejects read().
      if (_closed &&
          (failure == null || options.cancelToken?.isCancelled == true)) {
        return;
      }
      Error.throwWithStackTrace(
        failure ??
            DioException.connectionError(
              requestOptions: options,
              reason: 'Fetch stream failed: $error',
              error: error,
              stackTrace: stack,
            ),
        stack,
      );
    } finally {
      reader?.releaseLock();
      close();
    }
  }
}

// package:web 1.x omits the Headers iterable methods from generated bindings.
extension type _IterableHeaders(JSObject _) implements JSObject {
  external void forEach(JSFunction callback);
}
