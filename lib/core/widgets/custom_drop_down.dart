import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class CustomSmallDropdown extends StatefulWidget {
  const CustomSmallDropdown({
    super.key,
    required this.itemsMap, // 👈 changed from List to Map
    this.onChanged,
    this.value,
    this.hint,
    this.height,
  });

  final Map<String, String> itemsMap; // 👈 key: display, value: code
  final Function(String?)? onChanged;
  final String? value;
  final String? hint;
  final double? height;

  @override
  State<CustomSmallDropdown> createState() => _CustomSmallDropdownState();
}

class _CustomSmallDropdownState extends State<CustomSmallDropdown> {
  @override
  Widget build(BuildContext context) {
    // Reverse lookup: find the name (key) for the selected code (value)
    String? selectedKey =
        widget.itemsMap.entries
            .firstWhere(
              (entry) => entry.value == widget.value,
              orElse: () => const MapEntry('', ''),
            )
            .key;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(widget.hint ?? 'Select item', style: AppsStyles.s18Regular),
        items:
            widget.itemsMap.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.value, // 👈 actual value (e.g., "01")
                child: Text(
                  entry.key, // 👈 shown name (e.g., "Cairo")
                  style: AppsStyles.s14Regular,
                ),
              );
            }).toList(),
        value: widget.value,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(
          height: widget.height ?? 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderGrey),
            color: Colors.white,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 20,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
