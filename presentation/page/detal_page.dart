import 'package:flutter/material.dart';
import 'package:pagination/data/models/post_detal_model.dart';
import 'package:pagination/logic/pagination_provider.dart';

class DetalPage extends StatefulWidget {
  // final int id;
  final int initIndex;
  final Function? fetch;
  final bool isLast;
  final List objs;
  const DetalPage({
    // required this.id,
    required this.initIndex,
    required this.objs,
    this.fetch,
    this.isLast = true,
    super.key,
  });

  @override
  State<DetalPage> createState() => _DetalPageState();
}

class _DetalPageState extends State<DetalPage> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.initIndex, keepPage: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PaginationP.of(context, listen: false)
          .fillPostDetal(widget.objs[widget.initIndex].id);
    });
    super.initState();
  }

  PostDetalModel? obj;

  @override
  Widget build(BuildContext context) {
    obj = PaginationP.of(context).detal;
    return Scaffold(
      appBar: AppBar(title: Text("Detal:$obj")),
      body: PageView.builder(
        onPageChanged: (index) {
// obj=
print("Index:=$index");
          if (index == widget.objs.length - 1) {
            if (widget.fetch != null) {
              widget.fetch!();
            }
          } else {
            PaginationP.of(context, listen: false)
                .fillPostDetal(widget.objs[index].id);
          }
        },
        controller: _controller,
        itemCount: widget.objs.length,
        itemBuilder: (context, index) {
          if (obj == null) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          } else {
            return Column(
              children: [
                Image.network(obj!.pictures.first),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(obj!.title),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(obj!.phone),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(obj!.id.toString()),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
