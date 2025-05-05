import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/common/widgets/details_field.dart';
import 'package:serve_mate/core/models/decoration_model.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';

class DecorationDetails extends StatelessWidget {
  final DecorationModel item;
  const DecorationDetails({super.key, required this.item});

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
            buildDetailField('Decor Category', item.decorCategory.join(', ')),
            buildDetailField('Decor Styles', item.decorStyles.join(', ')),
            buildDetailField('Price', '₹${item.price}'),
            buildDetailField('Security Deposit', '₹${item.sdPrice}'),
            buildDetailField('Location', item.location.join(', ')),
            buildDetailField('Description', item.description),
            buildDetailField('Duration', item.duration),
            buildDetailField('Phone Number', item.phoneNumber),
            buildDetailField('Available', item.available ? 'Yes' : 'No'),
            buildDetailField('Privacy Policy',
                item.privacyPolicy ? 'Accepted' : 'Not Accepted'),
            buildDetailField('Permission', item.permission ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}
