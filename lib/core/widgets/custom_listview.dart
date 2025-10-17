import 'package:flutter/material.dart';

class CustomListViewSeparator extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool reverse;

  const CustomListViewSeparator({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics: physics,
      reverse: reverse,
    );
  }
}
