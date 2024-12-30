import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/venue_facilities_widget.dart';

class DecorationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController rentalPriceController;
  final TextEditingController securityDepositController;
  final Function(List<TextEditingController>?) onImageSelected;
  final Function(TextEditingController) selectedFacilitiesFIrst;
  final Function(TextEditingController) selectedFacilitiesSecond;
  final Function(TextEditingController?) locationController;
  final Function(String?) dateController;
  final TextEditingController descriptionController;

  const DecorationForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.rentalPriceController,
    required this.securityDepositController,
    required this.onImageSelected,
    required this.selectedFacilitiesFIrst,
    required this.selectedFacilitiesSecond,
    required this.dateController,
    required this.locationController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Name
          _buildSection(
            title: 'Decoration Name',
            child: CustomTextField(
              hint: 'Enter Decoration Name',
              numberLimit: 20,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter the Decoration Name'
                  : null,
            ),
          ),
          // Category
          _buildSection(
            title: 'Category',
            child: VenueFacilitiesWidget(
              facilities: facilitiesDecorationCategory,
              selectedFacilities: selectedFacilitiesFIrst,
            ),
          ),
          // Price
          _buildSection(
            title: 'Rental Price (Per Day)',
            child: CustomTextField(
              hint: 'Enter Rental Price Per Day',
              numberLimit: 6,
              controller: rentalPriceController,
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
          // Deposit Amount
          _buildSection(
            title: 'Security Deposit',
            child: CustomTextField(
              hint: 'Enter Security Deposit Amount',
              numberLimit: 6,
              controller: securityDepositController,
              keyboardType: TextInputType.number,
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
          ),
          // Images
          _buildSection(
            title: 'Images',
            child: ImagePickerFormField(
              onSaved: (images) {
                // Save the list of TextEditingControllers (image paths)
                for (var controller in images ?? []) {
                  log('Image path: ${controller.text}');
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
          // Type
          _buildSection(
            title: 'Facilities Available',
            child: VenueFacilitiesWidget(
                facilities: facilitiesDecorationStyle,
                selectedFacilities: selectedFacilitiesSecond),
          ),
          // Date
          _buildSection(
            title: 'Available Date',
            child: buildCalender(context, dateController),
          ),
          // Location
          _buildSection(
            title: 'Location',
            child: buildLocationTextField(
                context, 'Enter Location', locationController),
          ),
          // Description
          _buildSection(
            title: 'Description',
            child: CustomTextField(
              hint: 'Enter any Description',
              keyboardType: TextInputType.text,
              controller: descriptionController,
              maxLines: 5,
            ),
          ),
          SizedBox(height: 50.h),
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
