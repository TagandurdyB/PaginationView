import 'package:flutter/material.dart';
import 'package:pagination/logic/pagination_provider.dart';
import 'package:pagination/presentation/widget/pagination_view.dart';

import '../../data/models/post_model.dart';
import '../widget/post_card.dart';
import 'detal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PaginationP.of(context, listen: false).fillPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paginationP = PaginationP.of(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Posts")),
      body: Builder(builder: (context) {
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
              fetch: () => PaginationP.of(context, listen: false).fetchPost(),
              isLast: paginationP.isPostLast,
              itemBuilder: (context, index) {
                return PostCard(
                  obj: posts[index],
                  onTap: () {
                    // print("askdjas ${posts[index].id}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetalPage(
                                  objs: PaginationP.of(context).posts!,
                                  initIndex: index,
                                  fetch: () =>
                                      PaginationP.of(context, listen: false)
                                          .fetchPost(),
                                  isLast: paginationP.isPostLast,
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
    );
  }
}
