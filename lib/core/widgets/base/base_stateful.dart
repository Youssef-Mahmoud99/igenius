import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseStatefulWidgetState<T extends BaseStatefulWidget>
    extends State<T> {
  /// AppBar افتراضي
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Background color افتراضي
  Color backgroundColor() => Colors.white;

  /// Padding افتراضي
  EdgeInsetsGeometry padding() => const EdgeInsets.all(16.0);

  /// الـ body فاضي
  Widget buildBody(BuildContext context) => const SizedBox.shrink();

  /// دالة initState الافتراضية (لو حبيت تستدعيها من الأب)
  @mustCallSuper
  @override
  void initState() {
    super.initState();
  }

  /// دالة dispose الافتراضية (لو حبيت تستخدمها في الأب)
  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: backgroundColor(),
      body: buildBody(context),
    );
  }
}
