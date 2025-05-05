import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/common/widgets/details_field.dart';
import 'package:serve_mate/core/models/footwear_model.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';

class FootwearDetails extends StatelessWidget {
  final FootwearModel item;
  const FootwearDetails({super.key, required this.item});

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
                item.images.isNotEmpty
                    ? imageUrl[0]
                    : 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Name: ${item.name}',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            buildDetailField('Price', '₹${item.price}'),
            buildDetailField('Security Deposit', '₹${item.sdPrice}'),
            buildDetailField('Location', item.location.join(', ')),
            buildDetailField('Description', item.description),
            buildDetailField('Brand', item.brand),
            buildDetailField('Condition', item.condition),
            buildDetailField('Size', item.size.join(', ')),
            buildDetailField('Color', item.color),
            buildDetailField('Category', item.category),
            buildDetailField('Available', item.available ? 'Yes' : 'No'),
            buildDetailField('Date Added', item.date),
            buildDetailField('Phone Number', item.phoneNumber ?? 'N/A'),
            buildDetailField('Privacy Policy',
                item.privacyPolicy ?? false ? 'Accepted' : 'Not Accepted'),
            buildDetailField('Permission', item.permission ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}
