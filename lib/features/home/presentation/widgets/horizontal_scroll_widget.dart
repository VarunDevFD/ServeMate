import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:serve_mate/features/home/presentation/widgets/button_venues_more.dart';

class CustomHorizontalListWidget extends StatelessWidget {
  final String dataName;
  final List<dynamic> dataValue;
  CustomHorizontalListWidget({
    Key? key,
    required this.dataName,
    required this.dataValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10.h),

          SizedBox(
            height: 260.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dataValue.length ?? 1,
              itemBuilder: (context, index) {
                final item = dataValue[index];
                final imageUrl = ImageConcatinate.concatinateImage(item.images);

                return Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: SizedBox(
                    width: 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150.h,
                          width: 200.w,
                          child: Image.network(
                            imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.location[0],
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
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${item.price}',
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
          if (dataName.toLowerCase() == "venues")
            const MoreVenuesButton(), // Only for "Venues"
        ],
      ),
    );
  }
}
