import 'package:flutter/material.dart';

import '../../../../../core/resources/styles_manager.dart';

class MaterialDetails extends StatelessWidget {
  const MaterialDetails({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.name,
    this.padding, this.style,
  }) : super(key: key);
  final Color color;
  final Color backgroundColor;
  final String name;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style:  style ?? AppsStyles.s14SemiBold.copyWith(color: Colors.white),
      ),
    );
  }
}
