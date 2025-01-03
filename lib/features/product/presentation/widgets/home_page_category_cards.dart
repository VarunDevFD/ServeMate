import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCards extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final List<String>? details;
  final VoidCallback? onTap;

  const CategoryCards({
    Key? key,
    this.imageUrl,
    this.title,
    this.details,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.network(
                    imageUrl ?? 'https://example.com/default-image.jpg',
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: Text(
                    title ?? 'Default Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details != null
                    ? details!.map((detail) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Text(
                            detail,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }).toList()
                    : [
                        Text(
                          'No details available.',
                          style: TextStyle(fontSize: 14.sp),
                        )
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
