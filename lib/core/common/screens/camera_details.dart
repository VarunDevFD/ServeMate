import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/models/camera_model.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';

class CameraDetails extends StatelessWidget {
  final CameraModel item;
  const CameraDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ImageConcatinate.concatinateImage(item.images);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                item.images.isNotEmpty ? imageUrl[0] : 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text('Name: ${item.name}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            Text('Brand: ${item.brand}', style: TextStyle(fontSize: 16.sp)),
            Text('Model: ${item.model}', style: TextStyle(fontSize: 16.sp)),
            Text('Price: ₹${item.price}', style: TextStyle(fontSize: 16.sp)),
            Text('Security Deposit: ₹${item.sdPrice}', style: TextStyle(fontSize: 16.sp)),
            Text('Location: ${item.location.join(', ')}', style: TextStyle(fontSize: 16.sp)),
            Text('Description: ${item.description}', style: TextStyle(fontSize: 16.sp)),
            Text('Condition: ${item.condition}', style: TextStyle(fontSize: 16.sp)),
            Text('Storage: ${item.storage?.join(', ') ?? 'N/A'}', style: TextStyle(fontSize: 16.sp)),
            Text('Connectivity: ${item.connectivity?.join(', ') ?? 'N/A'}', style: TextStyle(fontSize: 16.sp)),
            Text('Duration: ${item.duration}', style: TextStyle(fontSize: 16.sp)),
            Text('Late Policy: ${item.latePolicy}', style: TextStyle(fontSize: 16.sp)),
            Text('Phone Number: ${item.phoneNumber}', style: TextStyle(fontSize: 16.sp)),
            Text('Available: ${item.available ? 'Yes' : 'No'}', style: TextStyle(fontSize: 16.sp)),
            Text('Privacy Policy: ${item.privacyPolicy ? 'Accepted' : 'Not Accepted'}', style: TextStyle(fontSize: 16.sp)),
            Text('Permission: ${item.permission ?? 'N/A'}', style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}