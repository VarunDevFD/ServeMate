import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/features/naviaton/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
 

class DecorationPage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode categoryFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode facilitiesFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  DecorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
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
                      TextFormField(
                        maxLength: 30,
                        controller: nameController,
                        focusNode: nameFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Name*',
                          counterText:
                              '', // Hide the maxLength count TextFormField
                          prefixIcon: Icon(Icons.inventory_2_outlined),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(categoryFocusNode),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Decoration Name'
                            : null,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 6.h),
                      FilterChipScreen(
                        id: 'category',
                        categories: decorationCategory,
                      ),
                      SizedBox(height: 10.h),
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
                      TextFormField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode,
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
              ),
              SizedBox(height: 16.h),
              // Pricing and Availability Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: AppColors.orange1,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Pricing & Availability',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        maxLength: 6,
                        controller: priceController,
                        focusNode: priceFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price*',
                          counterText: '',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(sdFocusNode),
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
                      TextFormField(
                        maxLength: 6,
                        controller: sdController,
                        focusNode: sdFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Security Deposit *',
                          counterText: '',
                          prefixIcon: Icon(Icons.security_outlined),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(locationFocusNode),
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
                      // SizedBox(height: 16.h),
                      //   SwitchTileScreen(
                      //     bloc:  , // Replace 'someBlocInstance' with the actual bloc instance
                      //   ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),
              // Location and Contact Card
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location & Contact',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 16.h),
                      // LocationTextField( bloc: bloc,
                      //   controller: locationController,
                      //   locationFocusNode: locationFocusNode,
                      //   // nextFocusNode: dateFocusNode,
                      // ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(locationFocusNode),
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Image Upload Section
              Card(
                child: ValueListenableBuilder<List<File>>(
                  valueListenable: imagesNotifier,
                  builder: (context, images, _) {
                    return Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: AppColors.orange1,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Product Images',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          //  ImagePickerPage()
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Terms and Conditions
              // const TermsAndConditionsScreen(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
