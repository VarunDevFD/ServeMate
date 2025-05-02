import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class SectionOneDressCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController brand;
  final TextEditingController type;

  const SectionOneDressCard({
    super.key,
    required this.name,
    required this.brand,
    required this.type,
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
                  Icons.info_outline,
                  color: AppColors.orange1,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Basic Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            // Dress Name
            TextFormField(
              controller: name,
              maxLength: 30,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Dress Name*',
                counterText: '', // Hide the no. of Characters
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter dress name'
                  : null,
            ),
            SizedBox(height: 15.h),
            // Brand
            TextFormField(
              controller: brand,
              maxLength: 30,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Dress Brand*',
                counterText: '', // Hide the no. Pof Characters
                prefixIcon: Icon(Icons.breakfast_dining_rounded),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter dress name'
                  : null,
            ),
            SizedBox(height: 15.h),
            // Type
            ReusableDropdown(
              labelText: 'Category*',
              onFieldSubmitted: (value) {
                if (value != null) {
                  type.text = value;
                }
              },
              items: DropdownItems.categoriesDress,
            ),
            SizedBox(height: 6.h),
            // Gender
            const GenderSelectionWidget(),
          ],
        ),
      ),
    );
  }
}
