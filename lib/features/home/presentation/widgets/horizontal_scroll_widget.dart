import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/home/presentation/widgets/button_venues_more.dart';

class HorizontalGridScroll extends StatelessWidget {
  const HorizontalGridScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5.h,
        children: [
          Text(
            'Venues',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: SizedBox(
                    width: 200.w,
                    height: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150.h,
                          width: 200.w,
                          child: Image.network(
                            'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicle_img.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 6.h,
                              children: [
                                Text(
                                  'Item Name $index',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Location $index',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '2000',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' per day',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5.h),
          const MoreVenuesButton(),
        ],
      ),
    );
  }
}
