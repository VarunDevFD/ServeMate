import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/widgets/child_field_toggle_btn.dart';
import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

class FootwearForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController brandController;
  final TextEditingController securityController;
  final TextEditingController descriptionController;
  final Function(TextEditingController?) onConditionSelected;
  final Function(TextEditingController?) onSizeSelected;
  final Function(TextEditingController?) onColorSelected;
  final Function(TextEditingController?) onCategorySelected;
  final Function(String?) onToggleSelected;
  final Function(List<TextEditingController>?) onImageSelected;
  final Function(TextEditingController?) locationController;
  final Function(String?) dateController;

  const FootwearForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.brandController,
    required this.securityController,
    required this.descriptionController,
    required this.onConditionSelected,
    required this.onSizeSelected,
    required this.onColorSelected,
    required this.onCategorySelected,
    required this.onToggleSelected,
    required this.onImageSelected,
    required this.locationController,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    final sizeBloc = DropdownBloc();
    final categoryBloc = DropdownBloc();
    final conditionBloc = DropdownBloc();

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Name
          _buildSection(
            title: 'Vehicle Name',
            child: CustomTextField(
              hint: 'Enter Vehicle Name',
              numberLimit: 20,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Vehicle Name'
                  : null,
            ),
          ),
          // Size
          _buildSection(
            title: 'Size',
            child: Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
              child: ReusableDropdown(
                onDataSelected: onSizeSelected,
                bloc: sizeBloc,
                items: DropdownItems.sizeList,
                hint: "Size",
              ),
            ),
          ),
          // Color
          _buildSection(
            title: "Color",
            child: TextFieldWithColorPicker(
              hint: 'Enter color',
              onColorSelected: onColorSelected,
            ),
          ),
          // Price
          _buildSection(
            title: 'Rental Price (Per Day)',
            child: CustomTextField(
              hint: 'Enter Rental Price Per Day',
              numberLimit: 6,
              controller: priceController,
              keyboardType: TextInputType.number,
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
          ),
          // Security Deposit
          _buildSection(
            title: 'Security Deposit',
            child: CustomTextField(
              hint: 'Enter security deposit',
              numberLimit: 10,
              keyboardType: TextInputType.number,
              controller: securityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the security deposit';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid deposit';
                }
                return null;
              },
            ),
          ),
          // Brand
          _buildSection(
            title: 'Brand Name',
            child: CustomTextField(
              hint: 'Enter Brands',
              numberLimit: 20,
              controller: brandController,
              keyboardType: TextInputType.text,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Brand name'
                  : null,
            ),
          ),
          // Category
          _buildSection(
            title: 'Category',
            child: Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
              child: ReusableDropdown(
                onDataSelected: onCategorySelected,
                bloc: categoryBloc,
                items: DropdownItems.footwearCategories,
                hint: "Category",
              ),
            ),
          ),
          // Location
          _buildSection(
            title: 'Location',
            child: buildLocationTextField(
                context, 'Enter Location', locationController),
          ),
          // Date
          _buildSection(
            title: 'Date',
            child: buildCalender(context, dateController),
          ),

          // Images
          _buildSection(
            title: 'Images',
            child: ImagePickerFormField(
              onSaved: (images) {
                // Save the list of TextEditingControllers (image paths)
                for (var controller in images ?? []) {
                  print('Image path: ${controller.text}');
                }
              },
              validator: (images) {
                if (images == null || images.isEmpty) {
                  return 'Please pick at least one image.';
                }
                return null;
              },
            ),
          ),
          // Condition
          _buildSection(
            title: 'Condition',
            child: Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
              child: ReusableDropdown(
                onDataSelected: onConditionSelected,
                bloc: conditionBloc,
                items: DropdownItems.conditionItems,
                hint: "Condition",
              ),
            ),
          ),
          // Available
          _buildSection(
              title: 'Availability Status',
              child: buildToggleContainerTextField(
                context,
                'Availability ON / OFF',
                onToggleSelected,
              )),
          // Description
          _buildSection(
            title: 'Vehicle Description',
            child: CustomTextField(
              hint: 'Enter description',
              numberLimit: 100,
              maxLines: 5,
              keyboardType: TextInputType.text,
              controller: descriptionController,
            ),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSideHeadText(title: title),
        child,
        SizedBox(height: 10.h),
      ],
    );
  }
}
