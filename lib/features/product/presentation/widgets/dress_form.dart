// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
// import 'package:serve_mate/features/product/presentation/widgets/child_widget_calender.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_gender_widget.dart';
// import 'package:serve_mate/features/product/presentation/widgets/custom_textfield_validator.dart';
// import 'package:serve_mate/features/product/presentation/widgets/dress_type_model.dart';
// import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
// import 'package:serve_mate/features/product/presentation/widgets/location_text_field.dart';
// import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
// import 'package:serve_mate/features/product/presentation/widgets/side_head_text.dart';
// import 'package:serve_mate/features/product/presentation/widgets/text_field_with_color_picker.dart';

// class DressForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController materialController;
//   final TextEditingController brandController;
//   final TextEditingController priceController;
//   final TextEditingController securityController;
//   final TextEditingController damageController;
//   final TextEditingController descriptionController;

//   final Function(TextEditingController?) onGenderSelected;
//   final Function(TextEditingController?) onTypeSelected;
//   final Function(TextEditingController?) onModelSelected;
//   final Function(TextEditingController?) onSizeSelected;
//   final Function(TextEditingController?) onColorSelected;
//   final Function(TextEditingController?) onDurationSelected;
//   final Function(TextEditingController?) onConditionSelected;
//   final Function(String?) dateController;
//   final Function(TextEditingController?) locationController;
//   final Function(List<TextEditingController>?) onImageSelected;

//   const DressForm({
//     super.key,
//     required this.formKey,
//     required this.materialController,
//     required this.brandController,
//     required this.priceController,
//     required this.securityController,
//     required this.damageController,
//     required this.descriptionController,
//     required this.onGenderSelected,
//     required this.onColorSelected,
//     required this.onTypeSelected,
//     required this.onModelSelected,
//     required this.onSizeSelected,
//     required this.onDurationSelected,
//     required this.onConditionSelected,
//     required this.dateController,
//     required this.onImageSelected,
//     required this.locationController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final dressCondition = DropdownBloc();
//     final dressDuration = DropdownBloc();
//     final dressSize = DropdownBloc<String>();

//     return Form(
//       key: formKey,
//       child: ListView(
//         padding: EdgeInsets.all(16.r),
//         children: [
//           // Gender Field
//           CustomGenderWidget(
//             onGenderSelected: onGenderSelected,
//           ),
//           // Type & Model Side Head
//           const CustomSideHeadText(title: 'Dress Type & Model'),
//           // Type & Model Field
//           DressTypeAndModel(
//             onTypeSelected: onTypeSelected,
//             onModelSelected: onModelSelected,
//           ),
//           // Size Side Head
//           const CustomSideHeadText(title: 'Size'),
//           // Size Field
//           Padding(
//             padding: EdgeInsets.only(top: 8.0.h),
//             child: ReusableDropdown(
//               onDataSelected: onSizeSelected,
//               bloc: dressSize,
//               items: const ['Small', 'Medium', 'Large'],
//               hint: "Select Dress Size",
//             ),
//           ),
//           // Color Side Head
//           const CustomSideHeadText(title: 'Color'),
//           // Color Field
//           TextFieldWithColorPicker(
//               hint: 'Enter color', onColorSelected: onColorSelected),
//           // Meterial Side Head
//           const CustomSideHeadText(title: 'Material'),
//           // Material Field
//           CustomTextField(
//             hint: 'Enter material',
//             numberLimit: 20,
//             controller: materialController,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the material';
//               }
//               return null;
//             },
//           ),
//           // Brand/Designer Side Head
//           const CustomSideHeadText(title: 'Brand/Designer'),
//           // Brand/Designer Field
//           CustomTextField(
//             hint: 'Enter brand/designer',
//             numberLimit: 20,
//             controller: brandController,
//             keyboardType: TextInputType.text,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the Brand/Designer';
//               }
//               return null;
//             },
//           ),
//           // Duration Side Head
//           const CustomSideHeadText(title: 'Rental Duration'),
//           // Duration Field
//           Padding(
//             padding: EdgeInsets.only(top: 8.0.h, bottom: 5.h),
//             child: ReusableDropdown(
//               onDataSelected: onDurationSelected,
//               bloc: dressDuration,
//               items: const ['1 Day', '1 Week', '1 Month'],
//               hint: "Duration",
//             ),
//           ),
//           // Rental Price Side Head
//           const CustomSideHeadText(title: 'Rental Price'),
//           // Rental Price Field
//           CustomTextField(
//             hint: 'Enter rental price',
//             keyboardType: TextInputType.number,
//             maxLines: 1,
//             numberLimit: 8,
//             showSuffixIcon: true,
//             controller: priceController,
//             popupMessage:
//                 'This is field depend on the Rental Duration field if You choose the one item form there that, that duration based price showcase here!',
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the price';
//               }
//               if (double.tryParse(value) == null) {
//                 return 'Please enter a valid number';
//               }
//               return null;
//             },
//           ),
//           // Security Deposit Side Head
//           const CustomSideHeadText(title: 'Security Deposit'),
//           // Security Deposit Field
//           CustomTextField(
//             hint: 'Enter security deposit',
//             numberLimit: 10,
//             keyboardType: TextInputType.number,
//             controller: securityController,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the security deposit';
//               }
//               if (double.tryParse(value) == null) {
//                 return 'Please enter a valid deposit';
//               }
//               return null;
//             },
//           ),
//           // Condition Side Head
//           const CustomSideHeadText(title: 'Dress Condition'),
//           // Condition Field
//           Padding(
//             padding: EdgeInsets.only(top: 8.0.h),
//             child: ReusableDropdown(
//                 onDataSelected: onConditionSelected,
//                 bloc: dressCondition,
//                 items: const ['New', 'Like New', 'Good'],
//                 hint: "Condition"),
//           ),
//           // Available Date
//           const CustomSideHeadText(title: 'Available Date'),
//           buildCalender(context, dateController),
//           // Location Side Head
//           const CustomSideHeadText(title: 'Location'),
//           // Location Field
//           buildLocationTextField(
//             context: context,
//             hint: 'Current Place',
//             locationController: locationController,
//           ),
//           // Image Side Head
//           const CustomSideHeadText(title: 'Images'),
//           // Image Field
//           ImagePickerFormField(
//             onSaved: (images) {
//               // Save the list of TextEditingControllers (image paths)
//               for (var controller in images ?? []) {
//                 log('Image path: ${controller.text}');
//               }
//             },
//             validator: (images) {
//               if (images == null || images.isEmpty) {
//                 return 'Please pick at least one image.';
//               }
//               return null;
//             },
//           ),
//           // Damage Policy Side Head
//           const CustomSideHeadText(title: 'Damage Policy'),
//           // Damge Policy Field
//           CustomTextField(
//             hint: 'Damage Policy (optional)',
//             keyboardType: TextInputType.text,
//             controller: damageController,
//             maxLines: 5,
//           ),
//           // Description Side Head
//           const CustomSideHeadText(title: 'Description'),
//           // Description Field
//           CustomTextField(
//             hint: 'Enter any Description',
//             keyboardType: TextInputType.text,
//             controller: descriptionController,
//             numberLimit: 100,
//             maxLines: 5,
//           ),
//           SizedBox(height: 50.h)
//         ],
//       ),
//     );
//   }
// }

// /*
// Widget _buildTypeAndModel() {
//     final dressType = DropdownBloc();
//     final dressModel = DropdownBloc();
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Row(
//         children: [
//           // Gender Dropdown
//           Expanded(
//             child: ReusableDropdown(
//               bloc: dressType,
//               items: const [
//                 'Formal',
//                 'Casual',
//                 'Traditional',
//                 'Bridal',
//                 "Groom's",
//                 'Bridesmaid',
//                 'Groomsmen',
//                 'Wedding Party'
//               ],
//               hint: "Select Dress Type",
//             ),
//           ),
//           SizedBox(
//             width: 10.w,
//           ),
//           Expanded(
//             child: ReusableDropdown(
//               bloc: dressModel,
//               items: const ['Suit', 'Tuxedo', 'Jacket'],
//               hint: "Select Dress Model",
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//  Widget _buildLocationTextField(BuildContext context, String hint) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           return TextField(
//             cursorColor: AppColors.balck1,
//             DecorationEntity: InputDecorationEntity(
//               // Display place name if available, otherwise show the default hint
//               hintText: state.placeName!.isNotEmpty
//                   ? state.placeName
//                   : (state.currentLocation ?? hint),
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.location_on),
//                 onPressed: () {
//                   // Trigger the CurrentLocation event to fetch the current location
//                   BlocProvider.of<LocationBloc>(context)
//                       .add(FetchCurrentLocation());
//                 },
//               ),
//               errorText: state.locationError,
//             ),

//             readOnly:
//                 true, // The text field is read-only since it's just displaying the location
//           );
//         },
//       ),
//     );
//   }
// }



//  Widget _buildImageGrid(BuildContext context, List<File> images) {
//     if (images.isEmpty) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 8.0),
//         child: Center(
//           child:
//               Text('No images selected', style: TextStyle(color: Colors.grey)),
//         ),
//       );
//     }
//     return Card(
//       color: const Color.fromARGB(255, 252, 217, 163),
//       margin: const EdgeInsets.all(3),
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: images.isNotEmpty
//             ? Wrap(
//                 spacing: 8, // Horizontal space between items
//                 runSpacing: 8, // Vertical space between rows
//                 children: List.generate(images.length, (index) {
//                   return Stack(
//                     children: [
//                       // Display selected images in a container with a fixed size
//                       Container(
//                         width: 100, // Adjust width as per design
//                         height: 100, // Adjust height as per design
//                         DecorationEntity: BoxDecorationEntity(
//                           borderRadius: BorderRadius.circular(8),
//                           image: DecorationEntityImage(
//                             image: FileImage(images[index]),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: -10,
//                         top: -10,
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.highlight_remove,
//                             color: AppColors.red,
//                           ),
//                           onPressed: () {
//                             BlocProvider.of<ImageBloc>(context)
//                                 .add(RemoveImage(index));
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               )
//             : Center(
//                 child: Icon(
//                   Icons.image,
//                   color: AppColors.orange1,
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildAddImageButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: ElevatedButton.icon(
//         onPressed: () async {
//           final picker = ImagePicker();
//           final pickedFile =
//               await picker.pickImage(source: ImageSource.gallery);

//           if (pickedFile != null) {
//             BlocProvider.of<ImageBloc>(context)
//                 .add(AddImage(File(pickedFile.path)));
//           }
//         },
//         onLongPress: () {
//           context.push('/next-page');
//         },
//         icon: Icon(Icons.image, color: AppColors.orange),
//         label: Text('Add Image', style: TextStyle(color: AppColors.orange)),
//       ),
//     );
//   }

// Widget _buildTextFieldWithColorPicker(String hint) {
//     return BlocBuilder<DressFormBloc, DressFormState>(
//       builder: (context, state) {
//         final TextEditingController controller = TextEditingController(
//           text: state.colorName, // Show the color name in the text field
//         );
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: TextField(
//             cursorColor: AppColors.balck1,
//             controller: controller,
//             onChanged: (text) {
//               final color =
//                   getColorByName(text); // Function to convert text to color
//               if (color != null) {
//                 // If color is found from name, update both color and colorName
//                 context.read<DressFormBloc>().add(ColorChanged(color, text));
//               }
//             },
//             DecorationEntity: InputDecorationEntitys.defaultDecorationEntity(
//               suffixIcon: Padding(
//                 padding: EdgeInsets.all(8.0.r),
//                 child:
//                     const ColorPickerWidget(), // Color picker as the suffix icon
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// TableCalendar(
//           calendarStyle: CalendarStyle(
//             todayDecorationEntity: BoxDecorationEntity(
//               color: Colors.blue,
//               shape: BoxShape.circle,
//             ),
//             selectedDecorationEntity: BoxDecorationEntity(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//           ),
//           firstDay: DateTime.utc(2020, 10, 16),
//           lastDay: DateTime.utc(2030, 3, 14),
//           focusedDay: DateTime.now(),
//           onDaySelected: (selectedDay, focusedDay) {
//             // Handle selected date
//             print('Selected date: $selectedDay');
//           },
//         ),

        
//   Widget _buildDressTypeField(BuildContext context, String selectedGender) {
//     // Define dress types based on the selected gender
//     List<String> dressTypes = (selectedGender == 'Men')
//         ? ['Formal', 'Casual', 'Traditional']
//         : ['Bridal', "Groom's", 'Bridesmaid', 'Groomsmen', 'Wedding Party'];

//     // Ensure the default value is part of the list
//     return BlocBuilder<DressFormBloc, DressFormState>(
//       builder: (context, state) {
//         return DropdownButtonFormField<String>(
//           value: (state.selectedDressType.isNotEmpty &&
//                   dressTypes.contains(state.selectedDressType))
//               ? state.selectedDressType
//               : dressTypes.first, // default to the first item
//           onChanged: (value) {
//             context.read<DressFormBloc>().add(DressTypeChanged(value!));
//           },
//           items: dressTypes
//               .map((dressType) => DropdownMenuItem<String>(
//                     value: dressType,
//                     child: Text(dressType),
//                   ))
//               .toList(),
//           DecorationEntity: InputDecorationEntitys.defaultDecorationEntity(),
//         );
//       },
//     );
//   }

//   final dressModels = {
//   'Men': {
//     'Formal': ['Suit', 'Tuxedo', 'Jacket'],
//     'Casual': [
//       'T-shirt',
//       'Polo Shirt',
//       'Sweatshirt',
//       'Hoodie',
//       'Jeans',
//       'Chinos',
//       'Shorts',
//       'Coat',
//       'Hat',
//     ],
//     'Traditional': ['Kurta Pajama', 'Sherwani', 'Dhoti'],
//   },
//   'Women': {
//     'Bridal': [
//       'Ball Gown',
//       'Mermaid',
//       'A-Line',
//       'Sheath',
//       'Tea-Length',
//     ],
//     "Groom's": [
//       'Tuxedo',
//       'Suit',
//       'Sherwani',
//       'Kurta Pajama',
//       'Dhoti Kurta'
//     ],
//     // ... Add entries for other dress types
//   },
// };

//   Widget _buildSizeDropdown(BuildContext context, String selectedSize) {
//     // Predefined sizes
//     List<String> sizes = ['Small', 'Medium', 'Large'];

//     // Ensure the default value is part of the list
//     return DropdownButtonFormField<String>(
//       value: (selectedSize.isNotEmpty && sizes.contains(selectedSize))
//           ? selectedSize
//           : sizes.first, // default to the first item
//       onChanged: (value) {
//         context.read<DressFormBloc>().add(SizeChanged(value!));
//       },
//       items: sizes
//           .map((size) => DropdownMenuItem<String>(
//                 value: size,
//                 child: Text(size),
//               ))
//           .toList(),
//       DecorationEntity: InputDecorationEntitys.defaultDecorationEntity(),
//     );
//   }


//  _buildConditionDropdown(BuildContext context, String selectedCondition) {
//     List<String> conditions = ['New', 'Like New', 'Good'];

//     return DropdownButtonFormField<String>(
//       DecorationEntity: InputDecorationEntitys.defaultDecorationEntity(),
//       value: (selectedCondition.isNotEmpty &&
//               conditions.contains(selectedCondition))
//           ? selectedCondition
//           : null, // Fix: Use null instead of 'Condition' as the default value

//       items: conditions
//           .map((condition) => DropdownMenuItem<String>(
//                 value: condition,
//                 child: Text(condition),
//               ))
//           .toList(),
//       onChanged: (value) {
//         context.read<DressFormBloc>().add(DressConditionChanged(value!));
//       },
//     );
//   }
//   */
