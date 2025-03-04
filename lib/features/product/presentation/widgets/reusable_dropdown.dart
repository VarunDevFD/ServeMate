import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/input_decoration.dart';

class ReusableDropdown extends StatelessWidget {
  final List<String> items;
  final String labelText;
  final FocusNode? focusNode;
  final dynamic onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  const ReusableDropdown({
    Key? key,
    required this.items,
    required this.labelText,
    required this.focusNode,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: focusNode,
      decoration: InputDecorations.defaultDecoration(labelText: labelText),
      iconDisabledColor: AppColors.orange,
      alignment: Alignment.centerLeft,
      menuMaxHeight: 200,
      onChanged: onFieldSubmitted,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 12.sp)),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }
}
