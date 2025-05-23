import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/helper/home_demo_card.dart';
import 'package:serve_mate/core/widgets/animation/an_button.dart';

class CustomDemoCard extends StatelessWidget {
  const CustomDemoCard({super.key, this.category});

  final String? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category ?? 'Category Not Found',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color:
                  AppColors.primary, // Replace with a defined dark text color
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 200.h,
            width: 500.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.3),
                  spreadRadius: 2.r,
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(
                  CatUtils.image(category ?? Names.empty),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay for text readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.black.withOpacity(0.7),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.r,
                  right: 12.r,
                  child: AnimatedAddButton(
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        category ?? Names.empty,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          shadows: const [
                            Shadow(
                              blurRadius: 4,
                              color: AppColors.black54,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        CatUtils.description(category ?? Names.empty),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(225, 243, 242, 242),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
