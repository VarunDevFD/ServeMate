// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
// import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
// import 'package:serve_mate/features/product/presentation/widgets/child_field_toggle_btn.dart';
// import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
// import 'package:serve_mate/features/product/presentation/widgets/dress_type_model.dart';
// import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
// import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
// import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
// import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
// import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

// class JewelryForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;

//   final TextEditingController nameController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final TextEditingController brandController;
//   final TextEditingController sizeController;
//   final TextEditingController descriptionController;
//   final TextEditingController securityDepositController;

//   final Function(TextEditingController?) onTypeSelected;
//   final Function(TextEditingController?) onMaterialSelected;
//   final Function(TextEditingController?) onConditionSelected;
//   final Function(TextEditingController?) onColorSelected;
//   final Function(String?) dateController;
//   final Function(String?) onToggleSelected;
//   final Function(TextEditingController?) locationController;
//   final Function(List<TextEditingController>?) onImageSelected;

//   const JewelryForm({
//     super.key,
//     required this.formKey,
//     required this.nameController,
//     required this.priceController,
//     required this.quantityController,
//     required this.brandController,
//     required this.sizeController,
//     required this.onColorSelected,
//     required this.descriptionController,
//     required this.securityDepositController,
//     required this.dateController,
//     required this.onTypeSelected,
//     required this.onMaterialSelected,
//     required this.onConditionSelected,
//     required this.onImageSelected,
//     required this.locationController,
//     required this.onToggleSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final conditionBloc = DropdownBloc();

//     return Form(
//       key: formKey,
//       child: ListView(
//         padding: EdgeInsets.all(16.r),
//         children: [
//           // Name
//           _buildSection(
//             title: 'Jewelry Name',
//             child: CustomTextField(
//               hint: 'Enter Jewelry Name',
//               numberLimit: 20,
//               controller: nameController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Jewelry Name'
//                   : null,
//             ),
//           ),
//           // Category & Material
//           _buildSection(
//             title: 'Jewelry Type & Material',
//             child: DressTypeAndModel(
//               onTypeSelected: onTypeSelected,
//               onModelSelected: onMaterialSelected,
//             ),
//           ),
//           // Price
//           _buildSection(
//             title: 'Rental Price (Per Day)',
//             child: CustomTextField(
//               hint: 'Enter Rental Price Per Day',
//               numberLimit: 6,
//               controller: priceController,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the Rental Price';
//                 }
//                 if (double.tryParse(value) == null) {
//                   return 'Please enter a valid number';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           // Security
//           _buildSection(
//             title: 'Security Deposit',
//             child: CustomTextField(
//               hint: 'Enter security deposit',
//               numberLimit: 10,
//               keyboardType: TextInputType.number,
//               controller: securityDepositController,
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
//           // Available Quantity
//           _buildSection(
//             title: 'Available Quantity',
//             child: CustomTextField(
//               hint: 'Enter the Count',
//               numberLimit: 10,
//               controller: quantityController,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the Rental Price';
//                 }

//                 return null;
//               },
//             ),
//           ),
//           // Condition
//           _buildSection(
//             title: 'Condition',
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//               child: ReusableDropdown(
//                 onDataSelected: onConditionSelected,
//                 bloc: conditionBloc,
//                 items: DropdownItems.rentalDurationItems,
//                 hint: "Condition",
//               ),
//             ),
//           ),
//           // Brand
//           _buildSection(
//             title: 'Jewelry Brands',
//             child: CustomTextField(
//               hint: 'Enter Jewelry Brands',
//               numberLimit: 20,
//               controller: brandController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Jewelry Brands'
//                   : null,
//             ),
//           ),
//           // Size/ Dimension
//           _buildSection(
//             title: 'Size/Dimensions',
//             child: CustomTextField(
//               hint: 'Enter Jewelry Size/Dimensions',
//               numberLimit: 20,
//               controller: sizeController,
//               keyboardType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please enter the Jewelry Size/Dimensions'
//                   : null,
//             ),
//           ),
//           // Color
//           _buildSection(
//             title: "Color",
//             child: TextFieldWithColorPicker(
//               hint: 'Enter color',
//               onColorSelected: onColorSelected,
//             ),
//           ),
//           // Images
//           _buildSection(
//             title: 'Images',
//             child: ImagePickerFormField(
//               onSaved: (images) {
//                 // Save the list of TextEditingControllers (image paths)
//                 for (var controller in images ?? []) {
//                   log('Image path: ${controller.text}');
//                 }
//               },
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
//           // Date
//           _buildSection(
//             title: 'Date',
//             child: buildCalender(context, dateController),
//           ),
//           // Availability Status
//           _buildSection(
//               title: 'Availability Status',
//               child: buildToggleContainerTextField(
//                 context,
//                 'Availability ON / OFF',
//                 onToggleSelected,
//               )),
//           // Add Note
//           _buildSection(
//             title: 'Description',
//             child: CustomTextField(
//               hint: 'Enter description',
//               numberLimit: 100,
//               maxLines: 5,
//               keyboardType: TextInputType.text,
//               controller: descriptionController,
//             ),
//           ),
//           const SizedBox(
//             height: 50,
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
