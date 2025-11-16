import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class CustomDropdownBuilder {
  static Widget build({
    required String labelText,
    required List<String> items,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        SizedBox(height: 18.h),
        ReusableDropdown(
          labelText: labelText,
          items: items,
          onFieldSubmitted: (value) {
            controller.text = value;
          },
        ),
      ],
    );
  }
}
