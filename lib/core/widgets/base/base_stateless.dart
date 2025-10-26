import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Color backgroundColor() => Colors.white;

  EdgeInsetsGeometry padding() => const EdgeInsets.all(16.0);

  Widget buildBody(BuildContext context) => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    // 👇 ضبط الـ Status Bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // خلي الخلفية شفافة
        statusBarIconBrightness: Brightness.dark, // أيقونات سوداء
        statusBarBrightness: Brightness.light, // في حالة iOS
      ),
    );

    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
}
