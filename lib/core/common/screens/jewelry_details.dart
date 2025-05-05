import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/common/widgets/details_field.dart';
import 'package:serve_mate/core/models/jewelry_model.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart'; 

class JewelryDetails extends StatelessWidget {
  final JewelryModel item;
  const JewelryDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ImageConcatinate.concatinateImage(item.images!);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                 imageUrl.isNotEmpty ? imageUrl[0] : 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Name: ${item.name ?? 'N/A'}',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            buildDetailField('Price', '₹${item.price ?? 'N/A'}'),
            buildDetailField('Security Deposit', '₹${item.securityDeposit ?? 'N/A'}'),
            buildDetailField('Location', item.location?.join(', ') ?? 'N/A'),
            buildDetailField('Description', item.description ?? 'N/A'),
            buildDetailField('Type', item.type ?? 'N/A'),
            buildDetailField('Material', item.material ?? 'N/A'),
            buildDetailField('Quantity', item.quantity ?? 'N/A'),
            buildDetailField('Condition', item.condition ?? 'N/A'),
            buildDetailField('Brand', item.brand ?? 'N/A'),
            buildDetailField('Available', item.available ?? false ? 'Yes' : 'No'),
            buildDetailField('Phone Number', item.phoneNumber ?? 'N/A'),
            buildDetailField('Privacy Policy', item.privacyPolicy ?? false ? 'Accepted' : 'Not Accepted'),
            buildDetailField('Date Added', item.dateAdded ?? 'N/A'),
            buildDetailField('Permission', item.permission ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}