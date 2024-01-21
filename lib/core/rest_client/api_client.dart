import 'package:dio/dio.dart';

import '../../shared/utils/config.dart';
import 'api_client_interceptor.dart';

class ApiClientCustom {
  final _dio = Dio();
  Dio get api => _dio;

  ApiClientCustom() {
    _dio.options.baseUrl = Config.urlBaseBack4App;
    _dio.interceptors.add(ApiClientInterceptor());
  }
}
