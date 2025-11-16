import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/helper/text_field_helper.dart';

class UpTextField extends StatelessWidget {
  final TextEditingController ctr;
  final String label;

  const UpTextField({
    super.key,
    required this.ctr,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      maxLength: TextFieldHelper.getMaxLengthForLabel(label),
      keyboardType: TextFieldHelper.getKeyboardTypeForLabel(label),
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
