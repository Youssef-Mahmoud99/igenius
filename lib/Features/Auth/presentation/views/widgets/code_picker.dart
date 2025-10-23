import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(PhoneNumber)? onInputChanged;
  final String? hint;
  final String? initialCountry;

  const CustomPhoneField({
    super.key,
    this.controller,
    this.onInputChanged,
    this.hint,
    this.initialCountry = 'EG',
  });

  static const List<String> arabCountries = [
    'EG',
    'SA',
    'AE',
    'KW',
    'QA',
    'BH',
    'OM',
    'JO',
    'LB',
    'MA',
    'DZ',
    'TN',
    'LY',
    'SD',
    'YE',
    'IQ',
    'PS',
    'SY',
  ];

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  PhoneNumber? _currentNumber;

  @override
  void initState() {
    super.initState();
    _currentNumber = PhoneNumber(isoCode: widget.initialCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.borderGrey),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InternationalPhoneNumberInput(
        maxLength: 11,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          }
          return null;
        },
        spaceBetweenSelectorAndTextField: 8,
        onInputChanged: (PhoneNumber number) {
          setState(() {
            _currentNumber = number;
          });
          widget.onInputChanged?.call(number);
        },
        countries: CustomPhoneField.arabCountries,
        initialValue: _currentNumber,
        textFieldController: widget.controller,
        cursorColor: AppColors.primary,
        formatInput: true,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useEmoji: true,
          showFlags: true,
          setSelectorButtonAsPrefixIcon: true,
        ),
        inputDecoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hint ?? 'Phone Number',
          hintStyle: TextStyle(
            color: AppColors.grey.withOpacity(0.5),
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
