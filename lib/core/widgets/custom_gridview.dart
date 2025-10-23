import 'package:flutter/material.dart';

class CustomGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final SliverGridDelegate gridDelegate;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool reverse;

  const CustomGridViewBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      cacheExtent: 1000,

      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: gridDelegate,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics: physics,
      reverse: reverse,
    );
  }
}
