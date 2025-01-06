import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCards extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final List<String>? details;
  final VoidCallback? onTap;
  final Widget? action;

  // New parameters
  final String name;
  final String vehicleType;
  final String brand;
  final String color;
  final double rentalPrice;
  final double securityDeposit;
  final String date;
  final List<String> images;
  final String location;
  final String availability;
  final String? description;

  const CategoryCards({
    Key? key,
    this.imageUrl,
    this.title,
    this.details,
    this.onTap,
    this.action,
    required this.name,
    required this.vehicleType,
    required this.brand,
    required this.color,
    required this.rentalPrice,
    required this.securityDeposit,
    required this.date,
    required this.images,
    required this.location,
    required this.availability,
    this.description,
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
                    imageUrl ?? 'assets/images/category/vehicle_img.jpg',
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
                children: [
                  // Display the new information
                  Text(
                    name,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),

                  Text('Vehicle Type: $vehicleType'),
                  Text('Brand: $brand'),
                  Text('Color: $color'),
                  Text('Rental Price: \$${rentalPrice.toStringAsFixed(2)}'),
                  Text(
                      'Security Deposit: \$${securityDeposit.toStringAsFixed(2)}'),
                  Text('Date: $date'),
                  Text('Location: $location'),
                  Text('Availability: $availability'),
                  description != null
                      ? Text('Description: $description')
                      : const SizedBox.shrink(),

                  // // Facilities list
                  // ...facilities
                  //     .map((facility) => Text('Facility: $facility'))
                  //     .toList(),
                  // Images list (just displaying a count for now)
                  Text('Images: ${images.length} available'),

                  // Display the details as before
                  if (details != null)
                    ...details!.map((detail) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text(
                          detail,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    }).toList(),
                  if (action != null)
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: action!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
