import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.dimBlack,
            thickness: 1.2,
            endIndent: 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.dimBlack,
            thickness: 1.2,
            indent: 20,
          ),
        ),
      ],
    );
  }
}
