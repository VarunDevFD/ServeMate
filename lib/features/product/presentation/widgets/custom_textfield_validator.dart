import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/input_decoration.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? numberLimit;
  final bool showSuffixIcon;
  final String? popupMessage;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.maxLines,
    this.numberLimit,
    this.popupMessage,
    this.showSuffixIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.black,
        decoration: InputDecorations.defaultDecoration(
          hintText: hint,
          suffixIcon: showSuffixIcon // Conditionally show suffix icon
              ? IconButton(
                  icon: const Icon(Icons.info_outline),
                  iconSize: 14.r,
                  onPressed: () {
                    _showPopupMessage(context, popupMessage!);
                  },
                )
              : null,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(numberLimit), // Limit characters
        ],
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }

  void _showPopupMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(
                text: 'Close',
                styleType: TextStyleType.custom,
                customStyle: TextStyle(color: AppColors.red, fontSize: 12.r),
              ),
            ),
          ],
        );
      },
    );
  }
}
