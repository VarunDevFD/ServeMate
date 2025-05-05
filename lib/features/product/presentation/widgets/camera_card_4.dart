import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class SectionFourCameraCard extends StatelessWidget {
  final TextEditingController condition;
  final TextEditingController days;
  final TextEditingController latePolicy;

  SectionFourCameraCard({
    super.key,
    required this.condition,
    required this.days,
    required this.latePolicy,
  });

  @override
  Widget build(BuildContext context) {
    final paddingEdges = AppPadding.paddingEdgesAll;
    return Card(
      shape: CardProperties.cardShape,
      child: Padding(
        padding: paddingEdges,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Features & Specifications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
            // Condition
            ReusableDropdown(
              items: DropdownItems.condition,
              labelText: 'Condition *',
              onFieldSubmitted: (value) {
                condition.text = value;
              },
            ),
            SizedBox(height: 6.h),
            Text(
              'Storage Options',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 6.h),
            FilterChipScreen(
              id: 'storage',
              categories: DropdownItems.storageOptionsCamera,
            ),
            SizedBox(height: 6.h),
            Text(
              'Connectivity Options',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 6.h),
            FilterChipScreen(
              id: 'connectivity',
              categories: DropdownItems.connectivityOptionsCamera,
            ),
            SizedBox(height: 16.h),
            // Minimum Rental Duration
            TextFormField(
              controller: days,
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
            SizedBox(height: 6.h),
            // Late Fee Policy
            TextFormField(
              controller: latePolicy,
              decoration: const InputDecoration(
                labelText: 'Late Fee Policy*',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Accessories are required' : null,
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}
