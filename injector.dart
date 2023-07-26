import 'package:flutter/material.dart';
import 'package:pagination/data/source.dart/post_data.dart';
import 'package:provider/provider.dart';

import 'logic/pagination_provider.dart';

class Injector extends StatelessWidget {
  final Widget router;
  const Injector({required this.router, super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<PaginationP>(
              create: (context) => PaginationP(PostData())),
        ],
        child: router,
      );
}
