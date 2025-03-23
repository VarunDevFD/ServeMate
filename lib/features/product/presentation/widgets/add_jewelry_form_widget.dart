 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:serve_mate/core/utils/constants_dropdown_name.dart'; 
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart'; 
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart'; 
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';  
class JewelryPage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode categoryFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode quantityFocusNode = FocusNode();
  final FocusNode conditionFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode sizeFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  JewelryPage({super.key});

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
              // Product Name
              _buildSection(
                title: 'Product Name',
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Enter Jewelry Name *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(categoryFocusNode);
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Jewelry Name'
                      : null,
                ),
              ),

              // Category  DropDown
              ReusableDropdown(
                labelText: 'Category*',
                focusNode: categoryFocusNode,
                items: DropdownItems.jewelryCategorys,
                onFieldSubmitted: (value) {
                  categoryController
                    ..clear()
                    ..text = value ?? '';
                  FocusScope.of(context).requestFocus(typeFocusNode);
                },
              ),
              SizedBox(height: 10.h),

              // Jewelry Type DropDown
              ReusableDropdown(
                labelText: 'Type*',
                focusNode: typeFocusNode,
                items: DropdownItems.jewelryTypes,
                onFieldSubmitted: (value) {
                  typeController
                    ..clear()
                    ..text = value ?? '';
                },
              ),
              SizedBox(height: 10.h),

              // Suitable for Gender DropDown
              GenderSelectionWidget(
                onValue: (value) {
                  genderController.clear();
                  genderController.text = value;
                },
              ),
              SizedBox(height: 10.h),

              // Rental Price Field
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
              SizedBox(height: 10.h),

              // Security Deposit Field
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
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(quantityFocusNode),
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
              SizedBox(height: 10.h),

              // Available Quantity
              TextFormField(
                controller: quantityController,
                focusNode: quantityFocusNode,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter the Count *',
                  counterText: '',
                  prefixIcon: Icon(Icons.add_outlined),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(sdFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Rental Price';
                  }

                  return null;
                },
              ),

              // Avilability Field
              // const SwitchTileScreen(),
              SizedBox(height: 10.h),

              // Description Field
              TextFormField(
                controller: descriptionController,
                focusNode: descriptionFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined),
                  counterText: '',
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 10.h),

              // // Images
              // Card(
              //   child: ValueListenableBuilder<List<File>>(
              //     valueListenable: imagesNotifier,
              //     builder: (context, images, _) {
              //       return Padding(
              //         padding: EdgeInsets.all(20.r),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(
              //                   Icons.photo_library,
              //                   color: AppColors.orange1,
              //                 ),
              //                 SizedBox(width: 8.w),
              //                 Text(
              //                   'Product Images',
              //                   style: Theme.of(context).textTheme.titleMedium,
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 6.h),
              //             ImagePickerPage(
              //               imageNotifier: imagesNotifier,
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(height: 10.h),

              // Condition DropDown
              ReusableDropdown(
                items: DropdownItems.condition,
                labelText: 'Duration *',
                focusNode: conditionFocusNode,
                onFieldSubmitted: (String? value) {
                  conditionController
                    ..clear()
                    ..text = value ?? '';
                  FocusScope.of(context).requestFocus(locationFocusNode);
                },
              ),
              SizedBox(height: 10.h),

              // Location Field
              // LocationTextField( bloc: bloc,
              //   controller: locationController,
              //   locationFocusNode: locationFocusNode,
              //   nextFocusNode: phoneFocusNode,
              // ),
              SizedBox(height: 10.h),

              // Contact Number Field
              TextFormField(
                controller: phoneController,
                focusNode: phoneFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(locationFocusNode),
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
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
