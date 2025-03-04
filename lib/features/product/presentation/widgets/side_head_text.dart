import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';

class CustomSideHeadText extends StatelessWidget {
  final String title;

  const CustomSideHeadText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
      child: CustomText(
        text: title,
        styleType: TextStyleType.blackBody,
      ),
    );
  }
}
