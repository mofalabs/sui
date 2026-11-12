import 'package:dio/dio.dart';

/// Native/custom adapters already provide response streams.
Dio configureStreamingDio(Dio dio) => dio;
