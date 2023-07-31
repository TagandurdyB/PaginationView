import 'package:flutter/material.dart';
import 'data/source.dart/post_data.dart';
import 'data/source.dart/register_data.dart';
import 'logic/register_provider.dart';
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
                        ChangeNotifierProvider<RegisterP>(
              create: (context) => RegisterP(RegisterData())),
        ],
        child: router,
      );
}
