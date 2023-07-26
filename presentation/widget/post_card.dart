import 'package:flutter/material.dart';
import 'package:pagination/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel obj;
  final Function? onTap;
  const PostCard({required this.obj, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.red,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(obj.img))),
            ),
            // Image.network(obj.img),
            Text(obj.title),
            Text(obj.id.toString()),
          ],
        ),
      ),
    );
  }
}
