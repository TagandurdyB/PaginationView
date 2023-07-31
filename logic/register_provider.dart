import 'package:flutter/material.dart';
import '../data/models/basic/user_model.dart';
import 'package:provider/provider.dart';

import '../config/constants/tags.dart';
import '../config/services/hive_boxes.dart';
import '../data/models/basic/response_model.dart';
import '../data/source.dart/register_data.dart';

class RegisterP extends ChangeNotifier {
  final RegisterData reposotiry;
  RegisterP(this.reposotiry);


  Future<ResponseModel> login(UserModel user) async {
    final ResponseModel response = await reposotiry.login(user);
    if (response.status) {
      Boxes.base.put(Tags.hiveToken, response.token);
      Boxes.base.put(Tags.hiveIsLogin, true);
    }
    return response;
  }

  static RegisterP of(BuildContext context, {bool listen = true}) =>
      Provider.of<RegisterP>(context, listen: listen);
}
