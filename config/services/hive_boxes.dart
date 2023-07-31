import 'package:hive/hive.dart';

import '../constants/tags.dart';

class Boxes {
  static Box get base => Hive.box(Tags.hiveBase);

  static String? get token => base.get(Tags.hiveToken);
  static bool? get isLogin => base.get(Tags.hiveIsLogin);
  static String? get cookie => base.get(Tags.hiveCookie);

  // static void changeMigrate(bool isMigrate) =>
  //     base.put(Tags.hiveIsMigrate, isMigrate);
}
