 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/core/utils/constants_list.dart'; 
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
// import 'package:serve_mate/temp/custom_calendar_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart'; 
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';  
import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
 

class VehiclesPage extends StatelessWidget {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();
  final FocusNode brandFocusNode = FocusNode();
  final FocusNode modelFocusNode = FocusNode();
  final FocusNode capacityFocusNode = FocusNode();
  final FocusNode fuelFocusNode = FocusNode();
  final FocusNode transmissionFocusNode = FocusNode();
  final FocusNode regNumberFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode sdFocusNode = FocusNode();
  final FocusNode facilitiesFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  VehiclesPage({super.key});

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
                title: 'Vehicle Name',
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Enter Vehicle Name *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(typeFocusNode),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Vehicle Name'
                      : null,
                ),
              ),
              // Type DropDown
              _buildSection(
                title: 'Vehicle Type',
                child: ReusableDropdown(
                  labelText: "Vehicle Type",
                  focusNode: typeFocusNode,
                  onFieldSubmitted: (String? value) {
                    typeController.clear();
                    typeController.text = value ?? '';
                    FocusScope.of(context).requestFocus(brandFocusNode);
                  },
                  items: DropdownItems.vehicleTypeItems,
                ),
              ),
              // Brand Field
              _buildSection(
                title: 'Vehicle Brand',
                child: TextFormField(
                  maxLength: 10,
                  controller: brandController,
                  focusNode: brandFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Enter Vehicle Brand Name *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(modelFocusNode),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Vehicle Brand Name'
                      : null,
                ),
              ),
              // Model Year DropDown
              _buildSection(
                title: 'Vehicle Model',
                child: ReusableDropdown(
                  labelText: "Model Year *",
                  focusNode: modelFocusNode,
                  onFieldSubmitted: (String? value) {
                    modelController.clear();
                    modelController.text = value ?? '';
                    FocusScope.of(context).requestFocus(capacityFocusNode);
                  },
                  items: DropdownItems.vehicleModelItems,
                ),
              ),
              // Color Field
              _buildSection(
                title: "Vehicle Color",
                child: TextFieldWithColorPicker(
                  hint: 'Enter Dress Color',
                  onColorSelected: (controller) {
                    colorController.clear();
                    colorController.text = controller?.text ?? '';
                  },
                ),
              ),
              // Seating Capacity Field
              _buildSection(
                title: 'Seating Capacity',
                child: TextFormField(
                  maxLength: 2,
                  controller: capacityController,
                  focusNode: capacityFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Enter Vehicle Seating Capacity *',
                    counterText: '',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(fuelFocusNode),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Vehicle Seating Capacity'
                      : null,
                ),
              ),
              // Fuel Type DropDown
              _buildSection(
                title: 'Vehicle Fuel',
                child: ReusableDropdown(
                  labelText: "Fuel Type *",
                  focusNode: fuelFocusNode,
                  onFieldSubmitted: (String? value) {
                    fuelController.clear();
                    fuelController.text = value ?? '';
                    FocusScope.of(context).requestFocus(transmissionFocusNode);
                  },
                  items: DropdownItems.vehicleFuelItems,
                ),
              ),
              // Transmission Type DropDown
              _buildSection(
                title: 'Vehicle Transmission Type',
                child: ReusableDropdown(
                  labelText: "Transmission Type *",
                  focusNode: transmissionFocusNode,
                  onFieldSubmitted: (String? value) {
                    transmissionController.clear();
                    transmissionController.text = value ?? '';
                    FocusScope.of(context).requestFocus(regNumberFocusNode);
                  },
                  items: DropdownItems.vehicleFuelItems,
                ),
              ),
              // Registration Number Field
              _buildSection(
                title: 'Vehicle Registration Number',
                child: TextFormField(
                  maxLength: 10,
                  controller: regNumberController,
                  focusNode: regNumberFocusNode,
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText:
                        'Enter Vehicle Registration Number (e.g., "KL 10 AB 1234") *',
                  ),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(priceFocusNode),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Registration Number'
                      : null,
                ),
              ),
              // Rental Details Field
              _buildSection(
                title: 'Rental Price Per Day',
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
                  maxLength: 10,
                  controller: sdController,
                  focusNode: sdFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Security Deposit *',
                    counterText: '',
                  ),
                  // onFieldSubmitted: (value) =>
                  //     FocusScope.of(context).requestFocus(dateFocusNode),
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

              // Additional Features
              _buildSection(
                title: 'Facilities Available',
                child: FilterChipScreen(
                  id: 'facilities',
                  categories: facilitiesVehicle,
                ),
              ),

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
              // Location Field
              _buildSection(
                title: 'Location',
                child: TextFormField(
                  controller: locationController,
                  focusNode: locationFocusNode,
                  decoration: const InputDecoration(labelText: 'Location *'),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(dateFocusNode),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the Location'
                      : null,
                ),
              ),
              // Availability Switch
              // const SwitchTileScreen(),

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
