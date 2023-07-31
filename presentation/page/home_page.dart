import 'package:flutter/material.dart';
import '../../config/services/dio_manager.dart';
import '../../logic/pagination_provider.dart';
import '../widget/pagination_view.dart';

import '../../data/models/post_model.dart';
import '../widget/post_card.dart';
import 'detal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PaginationP paginationDo;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      paginationDo = PaginationP.of(context, listen: false);
      DioClient.initInterceptor();
      _fillPosts();
    });
    super.initState();
  }

  Future<void> _fillPosts() {
    return Future.wait([
      paginationDo.fillPosts(),
      paginationDo.fillBadge(),
    ]);
  }

  Future<void> _fetch() => paginationDo.fetchPosts();

  @override
  Widget build(BuildContext context) {
    final paginationP = PaginationP.of(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text("Posts (${paginationP.badge})")),
      body: RefreshIndicator(
        onRefresh: _fillPosts,
        child: Builder(builder: (context) {
          if (paginationP.posts == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else if (paginationP.posts!.isNotEmpty) {
            List<PostModel> posts = paginationP.posts!;
            return SizedBox(
              // color: Colors.green,
              width: double.infinity,
              child: PaginationView(
                spacing: 10,
                runSpacing: 20,
                itemCount: posts.length,
                fetch: _fetch,
                isLast: paginationP.isPostLast,
                itemBuilder: (context, index) {
                  return PostCard(
                    obj: posts[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetalPage(
                                    //Required to there have model and this model have an id. There need providers list!!!
                                    objs: PaginationP.of(context).posts!,
                                    //Required==============================================
                                    initIndex: index,
                                    fetch: _fetch,
                                    isLast: PaginationP.of(context).isPostLast,
                                  )));
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text("Empty!!!"),
            );
          }
        }),
      ),
    );
  }
}
