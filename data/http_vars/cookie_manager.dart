import 'package:dio/dio.dart';

import '../../config/constants/tags.dart';
import '../../config/services/hive_boxes.dart';
import 'headers.dart';

class CookieManager extends Interceptor {
  static final CookieManager _instance = CookieManager._internal();
  static CookieManager get instance => _instance;
  CookieManager._internal();

  String? _cookie=Boxes.cookie;

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 200) {
      final cookie = response.headers.map["set-cookie"];
      if (cookie != null) {
        print("Save cookie:=$cookie");
        _saveCookie(cookie[0]);
      }
    } else {
      _clearCookie();
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print("cookie:=$_cookie");
    options.headers = Header.contentJson;
    options.headers["Cookie"] = _cookie;

    print("request.header:=${options.headers}");
    super.onRequest(options, handler);
  }

  void _saveCookie(String newCookie) {
    if (_cookie != newCookie) {
      _cookie = newCookie;
      Boxes.base.put(Tags.hiveCookie, newCookie);
    }
  }

  void _clearCookie() {
    _cookie = null;
    Boxes.base.delete(Tags.hiveCookie);
  }
}
