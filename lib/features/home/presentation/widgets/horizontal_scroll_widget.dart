import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/home/presentation/widgets/button_venues_more.dart';

class CustomHorizontalListWidget extends StatelessWidget {
  final String title;
  CustomHorizontalListWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 230.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.red,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Center(child: Text("camera")),
          ),
          // SizedBox(
          //   height: 230.h,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 10,
          //     // itemCount: items.length,
          //     itemBuilder: (context, index) {
          //       final item = items[index];
          //       return Padding(
          //         padding: EdgeInsets.only(right: 15.w),
          //         child: SizedBox(
          //           width: 200.w,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               SizedBox(
          //                 height: 150.h,
          //                 width: 200.w,
          //                 child: Image.network(
          //                   item.imageUrl,
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   padding: EdgeInsets.all(8.w),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         item.name,
          //                         style: TextStyle(
          //                           fontSize: 16.sp,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       Text(
          //                         item.location,
          //                         style: TextStyle(
          //                           fontSize: 12.sp,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       RichText(
          //                         text: TextSpan(
          //                           children: [
          //                             TextSpan(
          //                               text: '₹',
          //                               style: TextStyle(
          //                                 fontSize: 14.sp,
          //                                 color: AppColors.orange,
          //                               ),
          //                             ),
          //                             TextSpan(
          //                               text: '${item.price}',
          //                               style: TextStyle(
          //                                 fontSize: 14.sp,
          //                                 fontWeight: FontWeight.bold,
          //                                 color: AppColors.orange,
          //                               ),
          //                             ),
          //                             TextSpan(
          //                               text: ' per day',
          //                               style: TextStyle(
          //                                 fontSize: 14.sp,
          //                                 color: AppColors.orange,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          SizedBox(height: 5.h),
          if (title.toLowerCase() == "venues")
            const MoreVenuesButton(), // Only for "Venues"
        ],
      ),
    );
  }
}
