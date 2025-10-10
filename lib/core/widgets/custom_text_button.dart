import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;

  const CustomTextButton({
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    Key? key,
    required this.text,
    required this.color,

    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: color,fontSize:fontSize , fontWeight:fontWeight )),
    );
  }
}
