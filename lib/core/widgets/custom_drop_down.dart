import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class CustomSmallDropdown extends StatefulWidget {
  const CustomSmallDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.value,
    this.hint,
    this.height,
    this.validator,
  });

  final List<String> items;
  final Function(String?)? onChanged;
  final String? value;
  final String? hint;
  final double? height;
  final String? Function(String?)? validator; // 👈

  @override
  State<CustomSmallDropdown> createState() => _CustomSmallDropdownState();
}

class _CustomSmallDropdownState extends State<CustomSmallDropdown> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(widget.hint ?? 'Select item', style: AppsStyles.s12Regular),
                items: widget.items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: AppsStyles.s14Regular),
                  );
                }).toList(),
                value: widget.value,
                onChanged: (value) {
                  field.didChange(value); // 👈 عشان الـ validator يشتغل
                  widget.onChanged?.call(value);
                },
                buttonStyleData: ButtonStyleData(
                  height: widget.height ?? 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      // 👈 لون أحمر لو في error
                      color: field.hasError ? AppColors.error : AppColors.borderGrey,
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  elevation: 7,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 20,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
            // 👇 error message
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: AppColors.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}