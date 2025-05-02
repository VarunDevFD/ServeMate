import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';

class SectionOneDecorationCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController description;

  SectionOneDecorationCard({
    super.key,
    required this.name,
    required this.description,
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
            // Name
            TextFormField(
              controller: name,
              maxLength: 30,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name*',
                counterText: '', // Hide the maxLength count TextFormField
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Decoration Name'
                  : null,
            ),
            SizedBox(height: 15.h),
            // Category
            Text(
              'Category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 6.h),
            FilterChipScreen(
              id: 'decorCategory',
              categories: decorationCategory,
            ),
            SizedBox(height: 10.h),
            // DecorStyle
            Text(
              'Facilities',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 6.h),
            FilterChipScreen(
              id: 'decorStyles',
              categories: decorThemes,
            ),
            SizedBox(height: 6.h),
            // Description
            TextFormField(
              controller: description,
              maxLength: 100,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_outlined),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
