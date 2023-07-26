import 'dart:convert';

import 'package:http/http.dart' as http;
import '/data/models/post_detal_model.dart';

import '../models/post_model.dart';

class Headers {
  static Map<String, String> contentJson = {
    'Content-Type': 'application/json',
    'Cookie': '',
  };
  static Map<String, String> bearer(String token) => {
        'Content-Type': 'multipart/form-data',
        "Accept": 'application/json',
        'Cookie': '',
        'Authorization': "Bearer $token",
      };

  static Map<String, String> tokenHeader(String token) => {
        'Content-Type': 'application/json',
        'Cookie': '',
        'Authorization': "Bearer $token",
      };
}

class Uris {
  static String domain = "beta2.arzan.info";
  static String api = "https://$domain/api/v1";

  static Uri discounts(int limit, int offset,
          {int? categoryId, int? subCategoryId}) =>
      Uri.parse(
          '''$api/post${limit > 0 ? "?limit=$limit" : ""}${offset > 0 ? "&offset=$offset" : ""}${categoryId != null ? "&category_id=$categoryId" : ""}${subCategoryId != null ? "&sub_category_id=$subCategoryId" : ""}&publication_type_id=1&status=approved''');

  static Uri disDetal(int id) => Uri.parse("$api/post/$id");
}

class PostData {
  Future<List<PostModel>> getPosts(int limit, int offset) async {
    print("Discounts:=${Uris.discounts(limit, offset)}");
    // final myBase = Hive.box(Tags.hiveBase);
    // final String? token = myBase.get(Tags.hiveToken);
    final response = await http.get(
      Uris.discounts(limit, offset),
      headers: Headers.contentJson,
    );
    // token != null ? Headers.tokenHeader(token) : Headers.contentJson);
    final res = json.decode(response.body)["data"] as List;
    print("response discount:=$res");
    if (response.statusCode == 200) {
      return PostModel.fromList(res);
    } else {
      return [];
    }
  }

  @override
  Future<PostDetalModel> getDetal(int id) async {
    print("Discount detal:=${Uris.disDetal(id)}");
    final response = await http.get(
      Uris.disDetal(id),
      headers: Headers.contentJson,
    );
    final res = json.decode(response.body)["data"] as Map<String, dynamic>;
    print("response detal($id):=$res");
    if (response.statusCode == 200) {
      return PostDetalModel.fromMap(res);
    } else {
      throw "Error from get Detal($id):!!:!(";
      // return [];
    }
    // final myBase = Hive.box(Tags.hiveBase);
    // final String? token = myBase.get(Tags.hiveToken);
    // final response = await httpClient.get(Uris.disDetal(id),
    //     headers:
    //         token != null ? Headers.tokenHeader(token) : Headers.contentJson);
    // final res = json.decode(response.body)["data"];
    // print("response discount detal:=$res");
    // if (response.statusCode == 200) {
    //   return DiscountDetalModel.frowJson(res);
    // } else {
    //   return DiscountDetalModel.empty();
    // }
    // return HttpsFuncs.responseChecker(
    //   response,
    //   DiscountModel.fromJsonList(json.decode(response.body)),
    // );
    // print("asdasdas BAnner:=${BanerModel.fromJsonList(apiBanner)}");
  }
}
