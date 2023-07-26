// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PaginationView extends StatefulWidget {
  final Function? fetch;
  final bool isLast;
  final int itemCount;
  final double spacing;
  final double runSpacing;

  final EdgeInsetsGeometry? padding;
  final WrapAlignment alignment;
  Widget Function(BuildContext, int) itemBuilder;
  PaginationView({
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.padding,
    this.fetch,
    this.isLast=true,
    this.alignment = WrapAlignment.center,
    super.key,
  });

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  final _paginationControl = ScrollController();

  @override
  void initState() {
    if (widget.fetch != null) {
      _paginationControl.addListener(() {
        if (_paginationControl.position.maxScrollExtent ==
            _paginationControl.offset) {
          widget.fetch!();
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _paginationControl,
      physics: const BouncingScrollPhysics(),
      padding: widget.padding,
      child: buildContext(),
    );
  }

  Widget buildContext() {
    return Column(
      children: [
        Wrap(
          alignment: widget.alignment,
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: List.generate(
              widget.itemCount, (index) => widget.itemBuilder(context, index)),
        ),
        SizedBox(
          height: 80,
          child: Visibility(
            visible: !widget.isLast,
            child:const Center(child: CircularProgressIndicator(color: Colors.green),) )),
      ],
    );
  }
}
