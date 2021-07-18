import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  // ignore: unused_local_variable
  String url1 = "http://192.168.0.109:8000/api";
  // ignore: unused_local_variable
  String url2 = "http://192.168.1.36:8000/api";
  dio.options.baseUrl = url1;
  dio.options.headers['accept'] = "Application/Json";
  return dio;
}
