// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

class SectionTwoDressCard extends StatelessWidget {
  final TextEditingController size;
  final TextEditingController condition;
  final TextEditingController material;
  final TextEditingController description;

  const SectionTwoDressCard({
    Key? key,
    required this.size,
    required this.condition,
    required this.material,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: CardProperties.cardShape,
      child: Padding(
        padding: AppPadding.paddingEdgesAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.straighten, color: AppColors.orange1),
                SizedBox(width: 6.h),
                Text(
                  'Specifications',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            // Dress Size
            ReusableDropdown(
              labelText: 'Size*',
              items: DropdownItems.sizes,
              onFieldSubmitted: (value) {
                if (value != null) {
                  size.text = value;
                }
              },
            ),
            SizedBox(height: 6.h),
            // Dress Condition
            ReusableDropdown(
              labelText: 'condition *',
              items: DropdownItems.condition,
              onFieldSubmitted: (value) {
                if (value != null) {
                  condition.text = value;
                }
              },
            ),
            SizedBox(height: 6.h),
            // Dress Color
            TextFieldWithColorPicker(),
            SizedBox(height: 6.h),
            // Material
            TextFormField(
              controller: material,
              maxLength: 30,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Material',
                counterText: '',
                prefixIcon: Icon(Icons.sell_outlined),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter dress material'
                  : null,
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
