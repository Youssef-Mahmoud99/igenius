import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomCountryCityField extends StatefulWidget {
  final Function(String country, String city)? onChanged;
  final String? Function(String?)? countryValidator;
  final String? Function(String?)? cityValidator;

  const CustomCountryCityField({
    super.key,
    this.onChanged,
    this.countryValidator,
    this.cityValidator,
  });

  static const Map<String, List<String>> countryCities = {
    'Egypt': [
      'Cairo', 'Alexandria', 'Giza', 'Shubra El Kheima', 'Port Said',
      'Suez', 'Mansoura', 'Tanta', 'Asyut', 'Ismailia', 'Faiyum',
      'Zagazig', 'Luxor', 'Aswan', 'Minya', 'Damanhur', 'Beni Suef',
      'Hurghada', 'Sohag', 'Qena', 'Shibin El Kom', 'Banha',
      'Kafr El Sheikh', 'Arish', 'Marsa Matruh',
    ],
  };

  @override
  State<CustomCountryCityField> createState() => _CustomCountryCityFieldState();
}

class _CustomCountryCityFieldState extends State<CustomCountryCityField> {
  String? selectedCountry;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    final cities = selectedCountry != null
        ? CustomCountryCityField.countryCities[selectedCountry] ?? []
        : [];

    return Column(
      children: [
        FormField<String>(
          validator: widget.countryValidator,
          builder: (field) => _buildDropdown(
            hint: 'Select Country',
            value: selectedCountry,
            items: CustomCountryCityField.countryCities.keys.toList(),
            hasError: field.hasError,
            errorText: field.errorText,
            onChanged: (value) {
              field.didChange(value);
              setState(() {
                selectedCountry = value;
                selectedCity = null;
              });
            },
          ),
        ),

        10.verticalSpace,

        FormField<String>(
          validator: widget.cityValidator,
          builder: (field) => _buildDropdown(
            hint: 'Select City',
            value: selectedCity,
            items: cities.cast<String>(),
            enabled: selectedCountry != null,
            hasError: field.hasError,
            errorText: field.errorText,
            onChanged: (value) {
              field.didChange(value);
              setState(() {
                selectedCity = value;
              });
              if (selectedCountry != null && value != null) {
                widget.onChanged?.call(selectedCountry!, value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool enabled = true,
    bool hasError = false,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: hasError ? AppColors.error : AppColors.borderGrey,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: TextStyle(
                  color: AppColors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              items: items
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: enabled ? onChanged : null,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (hasError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              errorText,
              style: TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}