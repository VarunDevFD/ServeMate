import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images = [
    'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/on_boarding1.jpg',
    'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/on_boarding2.jpg',
    'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/on_boarding3.jpg',
  ];

  final List<String> quotes = [
    "Make your moments unforgettable.",
    "Luxury for every celebration.",
    "Dream weddings made real.",
  ];

  ImageCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient Overlay
                Container(
                    height: 120.h,
                    width: 500.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withAlpha(178),
                          Colors.black.withAlpha(102),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        if (index == 0)
                          Text(
                            AuthConstants.appName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        if (index == 0) SizedBox(height: 8.h),
                        Text(
                          quotes[index % quotes.length],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
