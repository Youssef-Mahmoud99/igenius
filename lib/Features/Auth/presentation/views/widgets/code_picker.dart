import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomPhoneField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.borderGrey),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InternationalPhoneNumberInput(
        maxLength: 11, // ✅ الحد الأقصى لعدد الرقم المدخل
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          }
          return null;
        },
        spaceBetweenSelectorAndTextField: 8, // ✅ مسافة بين العلم والنص
        onInputChanged: onInputChanged,
        countries: arabCountries,
        initialValue: PhoneNumber(isoCode: initialCountry),
        textFieldController: controller,
        cursorColor: AppColors.primary,
        formatInput: true,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useEmoji: true,
          showFlags: true,
          setSelectorButtonAsPrefixIcon: true,
        ),
        inputDecoration: InputDecoration(
          fillColor:
              Colors.transparent, // ✅ شفاف عشان الـ Container هو اللي فيه اللون
          filled: true,
          enabledBorder: InputBorder.none, // ✅ إلغاء البوردر الداخلي
          focusedBorder: InputBorder.none, // ✅ إلغاء البوردر عند Focus
          hintText: hint ?? 'Phone Number',
          hintStyle: TextStyle(
            color: AppColors.grey.withOpacity(0.5),
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero, // ✅ إلغاء الـ padding الداخلي
          isDense: true, // ✅ تقليل المسافات الداخلية
        ),
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
