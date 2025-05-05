import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/common/widgets/details_field.dart';
import 'package:serve_mate/core/models/vehicle_model.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';

class VehicleDetails extends StatelessWidget {
  final VehicleModel item;
  const VehicleDetails({super.key, required this.item});

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
            buildDetailField('Model', item.model),
            buildDetailField('Brand', item.brand),
            buildDetailField('Price', '₹${item.price}'),
            buildDetailField('Vehicle Type', item.vehicleType),
            buildDetailField('Security Deposit', '₹${item.securityDeposit}'),
            buildDetailField('Location', item.location.join(', ')),
            buildDetailField('Seat Capacity', item.seatCapacity.toString()),
            buildDetailField('Registration Number', item.registrationNumber),
            buildDetailField('Fuel Type', item.fuelType),
            buildDetailField('Transmission', item.transmission),
            buildDetailField('Facilities', item.facilities.join(', ')),
            buildDetailField('Date Added', item.date),
            buildDetailField('Color', item.color),
            buildDetailField('Available', item.availability ? 'Yes' : 'No'),
            buildDetailField('Privacy Policy',
                item.privacyPolicy ? 'Accepted' : 'Not Accepted'),
            buildDetailField('Description', item.description ?? 'N/A'),
            buildDetailField('Permission', item.permission ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}
