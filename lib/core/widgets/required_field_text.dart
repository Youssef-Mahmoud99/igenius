import 'package:flutter/material.dart';
import '../resources/styles_manager.dart';
import 'custom_text.dart';

class RequiredFieldText extends StatelessWidget {
  const RequiredFieldText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return AppText(
      text: '$text *',
      style: AppsStyles.s16Regular,
    );
  }
}
