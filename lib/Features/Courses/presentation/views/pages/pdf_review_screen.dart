import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

/// صفحة مستقلة لعرض ملف PDF جوه التطبيق، بتنزّل نسخة مؤقتة من الرابط
/// وتعرضها بـ flutter_pdfview.
class PdfPreviewScreen extends StatefulWidget {
  final String pdfUrl;
  final String? title;

  const PdfPreviewScreen({Key? key, required this.pdfUrl, this.title})
    : super(key: key);

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  String? _localPath;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _downloadToTemp();
  }

  Future<void> _downloadToTemp() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName =
          'preview_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final savePath = '${tempDir.path}/$fileName';

      await Dio().download(widget.pdfUrl, savePath);

      if (!mounted) return;
      setState(() {
        _localPath = savePath;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // بنمسح النسخة المؤقتة بعد الخروج من الصفحة
    if (_localPath != null) {
      final file = File(_localPath!);
      file.exists().then((exists) {
        if (exists) file.delete();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? 'PDF')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_hasError || _localPath == null) {
      return const Center(child: Text("Couldn't load PDF file"));
    }
    return PDFView(
      filePath: _localPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: true,
      onError: (error) {
        setState(() => _hasError = true);
      },
    );
  }
}