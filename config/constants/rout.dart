import 'package:flutter/material.dart';
import '../../presentation/page/home_page.dart';
import '../../presentation/page/login_page.dart';

import '../../presentation/page/logo_page.dart';

class Rout {
  static const logo = "/";
  static const home = "/HomePage";
  static const login = "/LoginPage";

  static Map<String, Widget Function(dynamic)> pages = {
    logo: (context) => const LogoPage(),
    home: (context) => const HomePage(),
    login: (context) => LoginPage(),
  };
}
