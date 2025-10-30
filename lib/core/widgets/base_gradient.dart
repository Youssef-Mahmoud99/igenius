import 'package:flutter/material.dart';

class BaseGradient extends StatelessWidget {
  const BaseGradient({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.padding,
  }) : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          padding != null ? width ?? MediaQuery.of(context).size.width : null,
      height:
          padding != null ? height ?? MediaQuery.of(context).size.height : null,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFCE7F3), Color(0xFFFFFFFF)],
        ),
      ),
      child: child,
    );
  }
}
