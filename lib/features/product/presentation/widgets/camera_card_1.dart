import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';

class SectionOneCameraCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController model;
  final TextEditingController brand;
  final TextEditingController category;
  final TextEditingController description;

  SectionOneCameraCard({
    super.key,
    required this.name,
    required this.model,
    required this.brand,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final paddingEdges = AppPadding.paddingEdgesAll;
    return Card(
      elevation: 2,
      shape: CardProperties.cardShape,
      child: Padding(
        padding: paddingEdges,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.orange1),
                SizedBox(width: 8.w),
                Text(
                  'Basic Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 15.h),
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
              onChanged: (value) => (),
              // bloc.add(FormUpdateEvent('camera', 'name', value)),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Name'
                  : null,
            ),
            SizedBox(height: 10.h),
            // Model
            TextFormField(
              controller: model,
              maxLength: 30,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Model*',
                counterText: '',
                prefixIcon: Icon(Icons.category),
              ),
              // bloc.add(FormUpdateEvent('camera', 'model', value)),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Model'
                  : null,
            ),
            SizedBox(height: 10.h),
            // Brand
            ReusableDropdown(
              labelText: 'Equipment Brand *',
              items: DropdownItems.brandsCamera,
              onFieldSubmitted: (value) {
                if (value != null) {
                  brand.text = value;
                }
              },
            ),
            SizedBox(height: 10.h),
            // Category
            ReusableDropdown(
              labelText: 'Category*',
              items: DropdownItems.categoriesCamera,
              onFieldSubmitted: (value) {
                if (value != null) {
                  category.text = value;
                }
              },
            ),
            SizedBox(height: 10.h),
            // Description
            TextFormField(
              controller: description,
              maxLength: 100,
              maxLines: 3,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
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
