import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  /// AppBar افتراضي
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Background color افتراضي
  Color backgroundColor() => Colors.white;

  /// Padding افتراضي
  EdgeInsetsGeometry padding() => const EdgeInsets.all(16.0);

  /// الـ body فاضي
  Widget buildBody(BuildContext context) => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: backgroundColor(),
      body: buildBody(context),
    );
  }
}
