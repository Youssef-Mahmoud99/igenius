import 'package:flutter/material.dart';
import 'package:igenius/core/localization/strings_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';

class PreviewButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;

  const PreviewButton({Key? key, this.onPressed, this.text = 'preview'})
    : super(key: key);

  @override
  State<PreviewButton> createState() => _PreviewButtonState();
}

class _PreviewButtonState extends State<PreviewButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double shift = _controller.value * 2 - 1; // يتحرك من -1 إلى 1
        return GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0 + shift, -1.0),
                end: Alignment(1.0 + shift, 1.0),
                colors: const [
                  Color(0xFF7D1C33),
                  Color(0xFF53A1D2),
                  Color(0xFF7D1C33),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
             
              widget.text,
              style: AppsStyles.s14Bold.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
