import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sui/grpc/transport/grpc_web_transport.dart';

class GrpcFixtureTransport extends GrpcWebTransport {
  GrpcFixtureTransport({this.onUnary, this.onStream})
    : super('https://fixture.test');
  final FutureOr<Uint8List> Function(String, Uint8List)? onUnary;
  final Stream<Uint8List> Function(String, Uint8List)? onStream;
  CancelToken? lastCancelToken;
  @override
  Future<Uint8List> unary(
    String service,
    String method,
    Uint8List request, {
    CancelToken? cancelToken,
    Map<String, String> metadata = const {},
    Duration? timeout,
  }) async {
    lastCancelToken = cancelToken;
    if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
    return await onUnary!(method, request);
  }

  @override
  Stream<Uint8List> serverStream(
    String service,
    String method,
    Uint8List request, {
    CancelToken? cancelToken,
    Map<String, String> metadata = const {},
  }) {
    lastCancelToken = cancelToken;
    return onStream!(method, request);
  }
}
