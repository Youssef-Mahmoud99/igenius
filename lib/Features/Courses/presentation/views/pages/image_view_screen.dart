import 'package:flutter/material.dart';

/// صفحة مستقلة لعرض صورة Full Screen مع إمكانية الزوم.
class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;
  final String? title;

  const ImagePreviewScreen({Key? key, required this.imageUrl, this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const CircularProgressIndicator(color: Colors.white);
            },
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                "Couldn't load image",
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}