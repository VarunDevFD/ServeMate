import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCards extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;

  final String name;
  final String brand;
  final double rentalPrice;
  final String availability;

  const CategoryCards({
    Key? key,
    this.imageUrl,
    this.onTap,
    this.onPressed,
    required this.name,
    required this.brand,
    required this.rentalPrice,
    required this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Image Section with Gradient Overlay
          Container(
            height: 220.h,
            width: 150.w,
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imageUrl ??
                      'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicle_img.jpg',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(102),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  brand,
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${rentalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Delete Icon
          Positioned(
            top: 10.h,
            right: 10.w,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 24.sp,
              ),
              onPressed: onPressed,
              tooltip: 'Delete',
            ),
          ),
        ],
      ),
    );
  }
}
