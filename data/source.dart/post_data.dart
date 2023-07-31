import '/data/models/post_detal_model.dart';
import '../../config/services/dio_manager.dart';
import '../http_vars/uris.dart';
import '../models/post_model.dart';

class PostData {

  Future<List<PostModel>> getPosts(int limit, int offset) async {
    print("Discounts:=${Urls.discounts(limit, offset)}");
    final response = await DioClient.dio.get(
      Urls.discounts(limit, offset),
      // options: Options(headers: Header.contentJson),
    );
    final res = response.data["data"] as List;
    print("response discount:=$res");
    if (response.statusCode == 200) {
      return PostModel.fromList(res);
    } else {
      return [];
    }
  }

  Future<PostDetalModel> getDetal(int id) async {
    print("Discount detal:=${Urls.disDetal(id)}");
    final response = await DioClient.dio.get(
      Urls.disDetal(id),
      // options: Options(headers: Header.contentJson),
    );
    final res = response.data["data"] as Map<String, dynamic>;
    print("response detal($id):=$res");
    if (response.statusCode == 200) {
      return PostDetalModel.fromMap(res);
    } else {
      throw "Error from get Detal($id):!!:!(";
    }
  }

  Future<int> badgePost() async {
    print("Post Badge = ${Urls.badgePost}");
    final response = await DioClient.dio.get(
      Urls.badgePost,
      // options: Options(headers: Header.contentJson),
    );
    final badge = response.data["data"]["count"] as int;
    if (response.statusCode == 200) {
      print("Response cookie:=${response.headers}");
      print("GalleryDataSourceImpl badgePost*** $badge");
      return badge;
    } else {
      print("Error in badgePost!!! statusCode:${response.statusCode}");
      print("Error in badgePost!!!:${response.data}");
      print("Error in badgePost!!! :$badge");
      return 0;
    }
  }
}
