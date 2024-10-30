import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/widgets/custom_text_styles.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Choose a category\n',
            style: CustomTextStyles.headTitle,
            children: <TextSpan>[
              TextSpan(
                text: '\nFind the perfect touch to make your event\n',
                style: CustomTextStyles.subTitle1,
              ),
              TextSpan(
                text: 'unforgettable.',
                style: CustomTextStyles.subTitle1,
              ),
            ],
          ),
        ),
        SizedBox(height: 45.h),
      ],
    );
  }
}
