import 'package:dio/dio.dart';
import 'package:vidstream/constants/string.dart';

class MUXClient {
  Dio? _dio = Dio();

  initializeDio() {
    BaseOptions options = BaseOptions(
    baseUrl: muxServerUrl,
    connectTimeout: 8000,
    receiveTimeout: 5000,
    headers: {
      "Content-Type": contentType, // application/json
    },
  );
  _dio = Dio(options);
  }
}