import '/config/services/dio_manager.dart';

import '../http_vars/uris.dart';
import '../models/basic/response_model.dart';
import '../models/basic/user_model.dart';

class RegisterData {
  Future<ResponseModel> login(UserModel user) async {
    print("response login:=${user.toJson()}");
    return await DioClient.dio
        .post(Urls.login, data: user.toJson())
        .then((response) {
      final res = response.data;
      print("response login:=$res");
      if (response.statusCode == 200) {
        if (res["status"]) {
          final String token = res["data"]["token"];
          print("token:=$token");
          return ResponseModel.fromMap(res);
        } else {
          throw "Error in login";
        }
      } else {
        print("Error in Login!!! statusCode:${response.statusCode}");
        print("Error in Login!!! :$res");
        print("Error in Login!!! :${user.toJson()}");
        return ResponseModel.fromMap(res);
      }
    });
  }
}
