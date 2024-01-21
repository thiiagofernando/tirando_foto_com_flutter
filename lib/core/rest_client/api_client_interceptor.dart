import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../shared/utils/config.dart';

class ApiClientInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Parse-Application-Id'] = Config.applicationIdBack4App;
    options.headers['X-Parse-REST-API-Key'] = Config.aPIKeyBack4App;
    options.headers['Content-Type'] = Config.contentTypeBack4App;
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
