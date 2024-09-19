import 'package:dio/io.dart';
import 'package:sui/http/interceptor.dart';

class Http extends DioForNative {
  static Http? instance;

  factory Http() {
      instance ??= Http._().._init();
    return instance!;
  }

  Http._();

  _init() {
    options.connectTimeout = const Duration(seconds: 5);
    options.receiveTimeout = const Duration(seconds: 10);

    options.headers["Content-Type"] = "application/json; charset=UTF-8";

    interceptors.add(ApiInterceptor());
  }
}