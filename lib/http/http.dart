import 'package:dio/dio.dart';

import 'http_native.dart' if (dart.library.html) 'http_web.dart';

final Dio http = Http();
