import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injector.dart';

import 'config/constants/rout.dart';
import 'config/constants/tags.dart';
import 'config/services/my_orientation.dart';
import 'data/http_vars/cookie_manager.dart';
// import 'presentation/page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive========================
  await Hive.initFlutter();
  await Hive.openBox(Tags.hiveBase);
  //CookieManager===============
  CookieManager.instance.initCookie();
  //============================
  MyOrientation.systemUiOverlayStyle();
  runApp(const Injector(router: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // de: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Rout.pages,
      initialRoute: Rout.logo,
    );
  }
}
