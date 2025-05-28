import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
 
class MoreVenuesButton extends StatelessWidget {
  final String title;
  const MoreVenuesButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: InkWell(
        onTap: () async {
           
          // Handle button tap
        },
        child: Container(
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: AppColors.orange),
          ),
          child: Center(
            child: Text(
              'View All $title',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
