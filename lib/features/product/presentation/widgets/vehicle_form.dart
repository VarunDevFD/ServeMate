// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
// import 'package:serve_mate/core/utils/constants_list.dart';
// import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
// import 'package:serve_mate/features/product/presentation/widgets/child_field_toggle_btn.dart';
// import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
// import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
// import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
// import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
// import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
// import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';
// import 'package:serve_mate/features/product/presentation/widgets/venue_facilities_widget.dart';

// class VehicleForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController nameController;
//   final TextEditingController brandController;
//   final TextEditingController seatCapacityController;
//   final TextEditingController regNumberController;
//   final TextEditingController priceController;
//   final TextEditingController securityController;
//   final TextEditingController descriptionController;

//   final Function(TextEditingController?) onTypeSelected;
//   final Function(TextEditingController?) onModelSelected;
//   final Function(TextEditingController?) onFuelSelected;
//   final Function(TextEditingController?) onTransmissionSelected;
//   final Function(TextEditingController?) selectedFacilities;
//   final Function(List<TextEditingController>?) onImageSelected;
//   final Function(TextEditingController?) locationController;
//   final Function(String?) onToggleSelected;
//   final Function(String?) dateController;
//   final Function(TextEditingController?) onColorSelected;

//   const VehicleForm({
//     super.key,
//     required this.formKey,
//     required this.nameController,
//     required this.brandController,
//     required this.onColorSelected,
//     required this.seatCapacityController,
//     required this.regNumberController,
//     required this.priceController,
//     required this.securityController,
//     required this.dateController,
//     required this.onTypeSelected,
//     required this.onModelSelected,
//     required this.onFuelSelected,
//     required this.onTransmissionSelected,
//     required this.selectedFacilities,
//     required this.onImageSelected,
//     required this.locationController,
//     required this.onToggleSelected,
//     required this.descriptionController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final vehicleType = DropdownBloc();
//     final vehicleModel = DropdownBloc();
//     final vehicleFuel = DropdownBloc();
//     final vehicleTransmission = DropdownBloc();
//     log(locationController.toString());

//     return Form(
//       key: formKey,
//       child: ListView(
//         padding: EdgeInsets.all(16.r),
//         children: [
//           // Name
//           _buildSection(
//             title: 'Vehicle Name',
//             child: CustomTextField(
//               hint: 'Enter Vehicle Name',
//               numberLimit: 20,
//               controller: nameController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Vehicle Name'
//                   : null,
//             ),
//           ),
//           // Type
//           _buildSection(
//             title: 'Vehicle Type',
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//               child: ReusableDropdown(
//                 onDataSelected: onTypeSelected,
//                 bloc: vehicleType,
//                 items: DropdownItems.vehicleTypeItems,
//                 hint: "Vehicle Type",
//               ),
//             ),
//           ),
//           // Brand
//           _buildSection(
//             title: 'Vehicle Brand',
//             child: CustomTextField(
//               hint: 'Enter Vehicle Brand Name',
//               numberLimit: 10,
//               controller: brandController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Vehicle Brand Name'
//                   : null,
//             ),
//           ),
//           // Model Year
//           _buildSection(
//             title: 'Vehicle Model',
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//               child: ReusableDropdown(
//                 onDataSelected: onModelSelected,
//                 bloc: vehicleModel,
//                 items: DropdownItems.vehicleModelItems,
//                 hint: "Model Year",
//               ),
//             ),
//           ),
//           // Color
//           _buildSection(
//             title: "Vehicle Color",
//             child: TextFieldWithColorPicker(
//               hint: 'Enter color',
//               onColorSelected: onColorSelected,
//             ),
//           ),
//           // Seating Capacity
//           _buildSection(
//             title: 'Seating Capacity',
//             child: CustomTextField(
//               hint: 'Enter Vehicle Seating Capacity',
//               numberLimit: 2,
//               controller: seatCapacityController,
//               keyboardType: TextInputType.number,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Vehicle Seating Capacity'
//                   : null,
//             ),
//           ),
//           // Fuel Type
//           _buildSection(
//             title: 'Vehicle Fuel',
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//               child: ReusableDropdown(
//                 onDataSelected: onFuelSelected,
//                 bloc: vehicleFuel,
//                 items: DropdownItems.vehicleFuelItems,
//                 hint: "Fuel Type",
//               ),
//             ),
//           ),
//           // Transmission Type
//           _buildSection(
//             title: 'Vehicle Transmission Type',
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//               child: ReusableDropdown(
//                 onDataSelected: onTransmissionSelected,
//                 bloc: vehicleTransmission,
//                 items: DropdownItems.vehicleTransmissionItems,
//                 hint: "Transmission Type",
//               ),
//             ),
//           ),
//           // Registration Number
//           _buildSection(
//             title: 'Vehicle Registration Number',
//             child: CustomTextField(
//               hint: 'Enter Vehicle Registration Number (e.g., "KL 10 AB 1234")',
//               numberLimit: 10,
//               controller: regNumberController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Registration Number'
//                   : null,
//             ),
//           ),
//           // Rental Details
//           _buildSection(
//             title: 'Rental Price Per Day',
//             child: CustomTextField(
//               hint: "₹1500/day",
//               keyboardType: TextInputType.number,
//               maxLines: 1,
//               numberLimit: 8,
//               showSuffixIcon: false,
//               controller: priceController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the price';
//                 }
//                 if (double.tryParse(value) == null) {
//                   return 'Please enter a valid number';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           // Security Deposit
//           _buildSection(
//             title: 'Security Deposit',
//             child: CustomTextField(
//               hint: 'Enter security deposit',
//               numberLimit: 10,
//               keyboardType: TextInputType.number,
//               controller: securityController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the security deposit';
//                 }
//                 if (double.tryParse(value) == null) {
//                   return 'Please enter a valid deposit';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           // Date
//           _buildSection(
//             title: 'Date',
//             child: buildCalender(context, dateController),
//           ),
//           // Additional Features
//           _buildSection(
//             title: 'Facilities Available',
//             child: VenueFacilitiesWidget(
//                 facilities: facilitiesVehicle,
//                 selectedFacilities: selectedFacilities),
//           ),
//           // Image
//           _buildSection(
//             title: 'Images',
//             child: ImagePickerFormField(
//               onSaved: onImageSelected,
//               validator: (images) {
//                 if (images == null || images.isEmpty) {
//                   return 'Please pick at least one image.';
//                 }
//                 return null;
//               },
//             ),
//           ),

//           // Location
//           _buildSection(
//             title: 'Location',
//             child: buildLocationTextField(
//               context: context,
//               hint: 'Current Place',
//               locationController: locationController,
//             ),
//           ),
//           // Available
//           _buildSection(
//               title: 'Availability Status',
//               child: buildToggleContainerTextField(
//                 context,
//                 'Availability ON / OFF',
//                 onToggleSelected,
//               )),
//           // Description
//           _buildSection(
//             title: 'Vehicle Description',
//             child: CustomTextField(
//               hint: 'Enter description',
//               numberLimit: 100,
//               maxLines: 5,
//               keyboardType: TextInputType.text,
//               controller: descriptionController,
//             ),
//           ),
//           SizedBox(
//             height: 50.h,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildSection({required String title, required Widget child}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomSideHeadText(title: title),
//         child,
//         SizedBox(height: 10.h),
//       ],
//     );
//   }
// }
