import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_button_widget.dart';

class SectionTwoDecorationCard extends StatelessWidget {
  final TextEditingController price;
  final TextEditingController sdPrice;
  final TextEditingController duration;

  const SectionTwoDecorationCard({
    super.key,
    required this.price,
    required this.sdPrice,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: CardProperties.cardShape,
      child: Padding(
        padding: AppPadding.paddingEdgesAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: AppColors.orange1,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Pricing & Availability',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Price
            TextFormField(
              controller: price,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price*',
                counterText: '',
                prefixIcon: Icon(Icons.attach_money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Rental Price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // Security Deposit
            TextFormField(
              controller: sdPrice,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Security Deposit *',
                counterText: '',
                prefixIcon: Icon(Icons.security_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Security Deposit';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid deposit';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // Minimum Rental Duration
            TextFormField(
              controller: duration,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minimum Rental Duration (days)*',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter minimum rental duration';
                }
                final number = int.tryParse(value);
                if (number == null) {
                  return 'Please enter a valid number';
                }
                if (number <= 0) {
                  return 'Duration must be greater than 0';
                }
                if (number > 30) {
                  return 'Duration cannot exceed 30 days or One Month';
                }

                return null;
              },
            ),
            SizedBox(height: 16.h),
            const SwitchTileScreen(),
          ],
        ),
      ),
    );
  }
}
