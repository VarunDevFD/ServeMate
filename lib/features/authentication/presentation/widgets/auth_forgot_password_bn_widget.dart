import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';

class ForgotPasswordBn extends StatelessWidget {
  const ForgotPasswordBn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 10.w,
          height: 5.h,
        ),
        // TextButton(
        //   onPressed: () => context.go('/forgotPassword'),
        //   child: Text(
        //     'Forgot Password?',
        //     style: AppTextStyles.buttonTextStyleForgotBn,
        //   ),
        // ),
      ],
    );
  }
}
