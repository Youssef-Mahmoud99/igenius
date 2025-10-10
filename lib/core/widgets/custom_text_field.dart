import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffix;
  final TextInputType? inputType;
  final bool obscureText;
  final String? hint;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? initialValue;
  final bool readOnly;

  CustomTextField({
    super.key,
    this.controller,
    this.suffix,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.hint,
    this.validator,
    this.focusNode,
    this.inputFormatters,
    this.prefix,
    this.onChanged,
    this.maxLines,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isPasswordVisible =
        !widget.obscureText; // Set initial state based on obscureText
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        cursorErrorColor: AppColors.error,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue ?? "",
        maxLines: widget.maxLines ?? 1,
        cursorColor: AppColors.primary,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters ?? [],
        focusNode: widget.focusNode,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.obscureText ? !isPasswordVisible : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: AppColors.greyLight,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
          prefixIcon: widget.prefix,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                )
              : widget.suffix,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 5, vertical: (widget.maxLines ?? 1) > 1 ? 10 : 0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.greyLight,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.greyLight,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.error,
            ),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
