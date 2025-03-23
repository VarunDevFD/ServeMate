
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/gender_selector_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

import 'reusable_dropdown.dart';

class FootwearPage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode brandFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();
  final FocusNode sizeFocusNode = FocusNode();
  final FocusNode materialFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode dateEndFocusNode = FocusNode();
  final FocusNode categoryFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode conditionFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  FootwearPage({super.key});

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSideHeadText(title: title),
        child,
        SizedBox(height: 6.h),
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
              // Name
              _buildSection(
                title: 'Name',
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(brandFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Enter Name*',
                    counterText: '',
                    prefixIcon: Icon(Icons.shopping_bag_outlined),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Name'
                      : null,
                ),
              ),

              // Brand
              _buildSection(
                title: 'Brand',
                child: TextFormField(
                  controller: brandController,
                  focusNode: brandFocusNode,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(typeFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Enter the brand name*',
                    counterText: '',
                    prefixIcon: Icon(Icons.bubble_chart_rounded),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Enter the Name'
                      : null,
                ),
              ),

              // Type
              _buildSection(
                title: 'Category',
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
                  child: ReusableDropdown(
                    labelText: "Footwear Type",
                    onFieldSubmitted: (String? value) {
                      typeController.clear();
                      typeController.text = value ?? '';
                      FocusScope.of(context).requestFocus(sizeFocusNode);
                    },
                    items: DropdownItems.footwearTypes,
                  ),
                ),
              ),

              // Size
              _buildSection(
                title: 'Size',
                child: ReusableDropdown(
                  labelText: 'Size',
                  items: DropdownItems.sizeFootwear,
                  onFieldSubmitted: (String? value) {
                    sizeController.clear();
                    sizeController.text = value ?? '';
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
              ),

              // Gender Selection
              GenderSelectionWidget(
                onValue: (value) {
                  genderController.clear();
                  genderController.text = value;
                },
              ),

              // Color
              _buildSection(
                title: "Color",
                child: TextFieldWithColorPicker(
                  hint: 'Enter Dress Color',
                  onColorSelected: (controller) {
                    colorController.clear();
                    colorController.text = controller?.text ?? '';
                  },
                ),
              ),

              // Material Field
              _buildSection(
                title: 'Material',
                child: TextFormField(
                  controller: materialController,
                  focusNode: materialFocusNode,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(typeFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Enter the material name*',
                    counterText: '',
                    prefixIcon: Icon(Icons.bubble_chart_rounded),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Enter the Material Name'
                      : null,
                ),
              ),

              // Condition Dropdown
              _buildSection(
                title: 'Condition',
                child: ReusableDropdown(
                  items: DropdownItems.condition,
                  labelText: 'Condition *',
                  onFieldSubmitted: (String? value) {
                    conditionController.clear();
                    conditionController.text = value ?? '';

                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
              ),

              // Description Field
              _buildSection(
                title: 'Description',
                child: TextFormField(
                  controller: descriptionController,
                  focusNode: descriptionFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Enter description *',
                    counterText: '',
                    prefixIcon: Icon(Icons.description_outlined),
                    alignLabelWithHint: true,
                  ),
                  maxLength: 100,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                ),
              ),

              // Price Field
              _buildSection(
                title: 'Rental Price',
                child: TextFormField(
                  controller: priceController,
                  focusNode: priceFocusNode,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText: 'Enter Rental Price*',
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
              ),

              // Security Deposit Field
              _buildSection(
                title: 'Security Deposit',
                child: TextFormField(
                  controller: sdController,
                  focusNode: sdFocusNode,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText: 'Enter Security Deposit *',
                  ),
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

              // Availability Switch
              // const SwitchTileScreen(),

              // Rental Duration Field
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
              SizedBox(height: 10.h),
              // Late Return Charges

              // // Image Upload Section
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
              //             SizedBox(height: 16.h),
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

              // // Pickup Location Field
              // _buildSection(
              //   title: 'Location',
              //   child: LocationTextField( bloc: bloc,
              //     controller: locationController,
              //     locationFocusNode: locationFocusNode,
              //     // nextFocusNode: dateFocusNode,
              //   ),
              // ),

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
