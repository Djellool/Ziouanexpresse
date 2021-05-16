import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  String url1 = "http://192.168.0.191:8000/api";
  // ignore: unused_local_variable
  String url2 = "http://192.168.1.38:8000/api";
  dio.options.baseUrl = url2;
  dio.options.headers['accept'] = "Application/Json";
  return dio;
}
