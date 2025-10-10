import 'package:flutter/material.dart';

class CustomAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? color;

  const CustomAssetImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      color: color,
      assetPath,
      width: width,
      height: height,
      fit: fit,
    );

    return borderRadius != null
        ? ClipRRect(borderRadius: borderRadius!, child: image)
        : image;
  }
}
