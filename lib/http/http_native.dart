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
    options.headers["Content-Type"] = "application/json; charset=UTF-8";

    interceptors.add(ApiInterceptor());
  }
}