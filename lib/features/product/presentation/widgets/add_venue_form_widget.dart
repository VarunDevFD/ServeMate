 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart'; 
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart'; 
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart'; 

class VenuePage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode venueCapacityFocusNode = FocusNode();
  final FocusNode durationFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode venueTypeFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode facilitiesFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode regNumberFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  VenuePage({super.key});

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
              // Name Field
              _buildSection(
                title: 'Venue Name',
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Enter Venue Name *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(locationFocusNode),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Venue Name'
                      : null,
                ),
              ),

              // Location Field
              // _buildSection(
              //   title: 'Location',
              //   child: LocationTextField( bloc: bloc,
              //     controller: locationController,
              //     locationFocusNode: locationFocusNode,
              //     nextFocusNode: venueCapacityFocusNode,
              //   ),
              // ),

              // Venue Capcity Field
              _buildSection(
                title: 'Venue Capacity',
                child: TextFormField(
                  maxLength: 6,
                  controller: venueCapacityController,
                  focusNode: venueCapacityFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Enter Venue Capacity *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(durationFocusNode),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Venue Capacity'
                      : null,
                ),
              ),

              // Rental Duration DropDown
              _buildSection(
                title: 'Rental Duration',
                child: ReusableDropdown(
                  items: DropdownItems.rentalDurationItems,
                  labelText: 'Duration *',
                  onFieldSubmitted: (String? value) {
                    durationController.clear();
                    durationController.text = value ?? '';
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
              ),

              // Rental Price Field
              _buildSection(
                title: 'Rental Price',
                child: TextFormField(
                  maxLength: 6,
                  controller: priceController,
                  focusNode: priceFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price *',
                    counterText: '',
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
                    labelText: 'Security Deposit *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(venueTypeFocusNode),
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

              // Venue Type DropDown
              _buildSection(
                title: 'Venue Type',
                child: ReusableDropdown(
                  items: DropdownItems.venueTypeItems,
                  labelText: 'Venue Type *',
                  onFieldSubmitted: (String? value) {
                    venueTypeController.clear();
                    venueTypeController.text = value ?? '';
                  },
                ),
              ),

              // Facilities Available
              _buildSection(
                title: 'Facilities Available',
                child: FilterChipScreen(
                  id: 'venue',
                  categories: facilitiesVenue,
                ),
              ),

              // // Image
              // _buildSection(
              //   title: 'Images',
              //   child: Card(
              //     child: ValueListenableBuilder<List<File>>(
              //       valueListenable: imagesNotifier,
              //       builder: (context, images, _) {
              //         return Padding(
              //           padding: EdgeInsets.all(20.r),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Icon(
              //                     Icons.photo_library,
              //                     color: AppColors.orange1,
              //                   ),
              //                   SizedBox(width: 8.w),
              //                   Text(
              //                     'Product Images',
              //                     style:
              //                         Theme.of(context).textTheme.titleMedium,
              //                   ),
              //                 ],
              //               ),
              //               SizedBox(height: 16.h),
              //               ImagePickerPage(
              //                 imageNotifier: imagesNotifier,
              //               )
              //             ],
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),

              // Contact Number Field
              _buildSection(
                title: 'Contact Number',
                child: TextFormField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(descriptionFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
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

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
