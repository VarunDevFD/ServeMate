import 'package:flutter/material.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';

class CustomSideHeadText extends StatelessWidget {
  final String title;

  const CustomSideHeadText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: CustomText(
        text: title,
        styleType: TextStyleType.blackBody,
      ),
    );
  }
}
