import 'package:dio/dio.dart';

abstract class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.baseUrl =
        'https://laundryabchosting-production-1821.up.railway.app/api/';
  }
  Dio get dio => _dio;
}
