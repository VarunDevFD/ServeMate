import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
import 'reusable_dropdown.dart';

class DressesPage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode categoryFocusNode = FocusNode();
  final FocusNode sizeFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode dateEndFocusNode = FocusNode();
  final FocusNode brandFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode durationFocusNode = FocusNode();
  final FocusNode materialFocusNode = FocusNode();
  final FocusNode conditionFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  DressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
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
                      // Dress Name
                      TextFormField(
                        maxLength: 30,
                        controller: nameController,
                        focusNode: nameFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Dress Name*',
                          counterText:
                              '', // Hide the maxLength count TextFormField
                          prefixIcon: Icon(Icons.shopping_bag),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(categoryFocusNode),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter dress name'
                            : null,
                      ),
                      SizedBox(height: 15.h),
                      // Category
                      ReusableDropdown(
                        labelText: 'Category*',
                        focusNode: categoryFocusNode,
                        items: DropdownItems.categoriesDress,
                        onFieldSubmitted: (value) {
                          categoryController
                            ..clear()
                            ..text = value ?? '';
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      // Gender
                      GenderSelectionWidget(
                        onValue: (value) {
                          genderController.clear();
                          genderController.text = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Dress Specifications
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
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
                        focusNode: sizeFocusNode,
                        items: DropdownItems.sizes,
                        onFieldSubmitted: (value) {
                          sizeController
                            ..clear()
                            ..text = value ?? '';
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      // Dress Condition
                      ReusableDropdown(
                        labelText: 'condition *',
                        focusNode: sizeFocusNode,
                        items: DropdownItems.sizes,
                        onFieldSubmitted: (value) {
                          sizeController
                            ..clear()
                            ..text = value ?? '';
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      // Dress Color
                      TextFieldWithColorPicker(
                        hint: 'Enter Dress Color',
                        onColorSelected: (controller) {
                          colorController.clear();
                          colorController.text = controller?.text ?? '';
                        },
                      ),
                      SizedBox(height: 6.h),
                      // Material
                      TextFormField(
                        maxLength: 30,
                        controller: materialController,
                        focusNode: materialFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Material',
                          counterText: '',
                          prefixIcon: Icon(Icons.sell_outlined),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(descriptionFocusNode),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter dress material'
                            : null,
                      ),
                      SizedBox(height: 6.h),

                      // Description
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
              SizedBox(
                height: 16.h,
              ),
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
                          labelText: 'Price (per day)*',
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
                            .requestFocus(dateEndFocusNode),
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
                      TextFormField(
                        maxLength: 6,
                        controller: dateEndController,
                        focusNode: dateEndFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Rental Duration Period*',
                          counterText: '',
                          prefixIcon: Icon(Icons.security_outlined),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(locationFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Rental Duration Period';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid Period';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // const SwitchTileScreen(),
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
                      //   nextFocusNode: phoneFocusNode,
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
                child: Padding(
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
                      SizedBox(height: 16.h),
                      const ImagePickerPage()
                    ],
                  ),
                ),
              ),

              // Terms and Conditions
              // const TermsAndConditionsScreen(),

              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
