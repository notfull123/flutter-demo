import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  late final Dio dio;
  late final ApiClient apiClient;

  ApiUtil._privateConstructor() {
    dio = Dio();
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(ApiInterceptors());
    apiClient = ApiClient(dio, baseUrl: "https://622a245fbe12fc4538b36a4f.mockapi.io");
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}
