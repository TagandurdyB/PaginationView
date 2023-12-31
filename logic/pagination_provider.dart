import 'package:flutter/material.dart';
import '../data/models/post_detal_model.dart';
import '../data/source.dart/post_data.dart';
import 'package:provider/provider.dart';

import '../data/models/post_model.dart';

class PaginationP extends ChangeNotifier {
  final PostData reposotiry;
  PaginationP(this.reposotiry);

  final int limit = 10;

  List<PostModel>? posts;
  Future<void> fillPosts() async {
    try {
      posts = null;
      notifyListeners();
      posts = await reposotiry.getPosts(limit, 0);
      // likeList = List.generate(chowsen.length, (index) => false);
      notifyListeners();
    } catch (err) {
      throw ("Error PaginationP>fillPosts: $err");
    }
  }

  bool isPostLast = false;
  Future fetchPosts() async {
    try {
      final List<PostModel> objs =
          await reposotiry.getPosts(limit, posts!.length);
      if (objs.length < limit) isPostLast = true;
      print("fatchPost=$objs");
      posts!.addAll(objs);
      // likeList.addAll(List.generate(objs.length, (index) => false));
      notifyListeners();
    } catch (err) {
      throw ("Error PaginationP>fatchPost(): $err");
    }
  }

  List<PostDetalModel>? postDetals;
  PostDetalModel? detal;
  Future<void> fillPostDetal(int id) async {
    try {
      detal = null;
      notifyListeners();
      detal = await reposotiry.getDetal(id);
      // likeList = List.generate(chowsen.length, (index) => false);
      notifyListeners();
    } catch (err) {
      throw ("Error PaginationP>fillPostDetal($id): $err");
    }
  }

  int _badge = 0;
  int get badge => _badge;
  void get ereaseBadge => _badge = 0;

  Future<void> fillBadge() async {
    try {
      _badge = await reposotiry.badgePost();
      notifyListeners();
      // return _badge;
    } catch (err) {
      throw ("Error DiscountDataP>fillBadge: $err");
    }
  }
  // Future<void> fillChowsen(int offset) async {
  //   try {
  //     chowsen = [];
  //     notifyListeners();
  //     chowsen = await discountsCase.getChowsen(21, 0, 0);
  //     likeList = List.generate(chowsen.length, (index) => false);
  //     notifyListeners();
  //   } catch (err) {
  //     throw ("Error DiscountDataP fillChowsen: $err");
  //   }
  // }

  static PaginationP of(BuildContext context, {bool listen = true}) =>
      Provider.of<PaginationP>(context, listen: listen);
}
