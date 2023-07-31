import 'package:dio/dio.dart';

import '../../data/http_vars/cookie_manager.dart';

Dio _dio = Dio();

class DioClient {
  static Dio get dio => _dio;
  static void initInterceptor() =>
      _dio.interceptors.add(CookieManager.instance);
}
