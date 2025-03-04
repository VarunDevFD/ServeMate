import 'dart:io';

import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/constants_dropdown_name.dart';
import 'package:serve_mate/features/home/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import 'package:serve_mate/features/product/presentation/widgets/custom_checkbox_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:serve_mate/features/product/presentation/widgets/reusable_dropdown.dart';
import 'package:serve_mate/features/product/presentation/widgets/switch_custom_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_location.dart';

class Cameras extends StatelessWidget {
  Cameras({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode nameFocusNode = FocusNode();
    final FocusNode priceFocusNode = FocusNode();
    final FocusNode sdFocusNode = FocusNode();
    final FocusNode locationFocusNode = FocusNode();
    final FocusNode phoneFocusNode = FocusNode();
    final FocusNode rentalDurationFocusNode = FocusNode();
    final FocusNode brandFocusNode = FocusNode();
    final FocusNode modelFocusNode = FocusNode();
    final FocusNode categoryFocusNode = FocusNode();
    final FocusNode conditionFocusNode = FocusNode();
    final FocusNode dateAddedFocusNode = FocusNode();
    final FocusNode minDurationFocusNode = FocusNode();
    final FocusNode descriptionFocusNode = FocusNode();
    final FocusNode lateFeeFocusNode = FocusNode();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Common fields
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
                      SizedBox(height: 16.h),
                      // Name
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
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(brandFocusNode),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Decoration Name'
                            : null,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Brand',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 6.h),
                      // Brand
                      ReusableDropdown(
                        labelText: 'Equipment Brand *',
                        focusNode: brandFocusNode,
                        items: DropdownItems.brandsCamera,
                        onFieldSubmitted: (value) {
                          brandController
                            ..clear()
                            ..text = value ?? '';
                          FocusScope.of(context).requestFocus(modelFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      // Model
                      TextFormField(
                        maxLength: 30,
                        controller: modelController,
                        focusNode: modelFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Model*',
                          counterText: '',
                          prefixIcon: Icon(Icons.category),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(categoryFocusNode),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Decoration Name'
                            : null,
                      ),
                      SizedBox(height: 6.h),
                      // Category
                      ReusableDropdown(
                        labelText: 'Category*',
                        focusNode: categoryFocusNode,
                        items: DropdownItems.categoriesCamera,
                        onFieldSubmitted: (value) {
                          categoryController
                            ..clear()
                            ..text = value ?? '';
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
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
                      // Price
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
                      // Security Deposit
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
                      SizedBox(height: 16.h),
                      const SwitchTileScreen(),
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
                      LocationTextField(
                        controller: locationController,
                        locationFocusNode: locationFocusNode,
                        // nextFocusNode: dateFocusNode,
                      ),
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
                          counterText: '',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Features & Specifications
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Features & Specifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 16.h),
                      // Condition
                      ReusableDropdown(
                        items: DropdownItems.condition,
                        labelText: 'Condition *',
                        focusNode: conditionFocusNode,
                        onFieldSubmitted: (String? value) {
                          conditionController.clear();
                          conditionController.text = value ?? '';

                          FocusScope.of(context)
                              .requestFocus(dateAddedFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Storage Options',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      SizedBox(height: 6.h),
                      FilterChipScreen(
                        id: 'accessories',
                        categories: DropdownItems.storageOptionsCamera,
                        onSelectionChanged: (List<String> value) {
                          categoryController.text = value.join(', ');
                          FocusScope.of(context).requestFocus(priceFocusNode);
                        },
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Connectivity Options',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      SizedBox(height: 6.h),
                      FilterChipScreen(
                        id: 'accessories',
                        categories: DropdownItems.connectivityOptionsCamera,
                        onSelectionChanged: (List<String> value) {
                          categoryController.text = value.join(', ');
                          FocusScope.of(context).requestFocus(priceFocusNode);
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: rentalDurationController,
                        focusNode: rentalDurationFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(locationFocusNode),
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Minimum Rental Duration
                      TextFormField(
                        controller: minDurationController,
                        focusNode: minDurationFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Minimum Rental Duration (days)*',
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(lateFeeFocusNode);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Accessories are required' : null,
                      ),
                      SizedBox(height: 6.h),
                      // Late Fee Policy
                      TextFormField(
                        controller: lateFeeController,
                        focusNode: lateFeeFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Late Fee Policy*',
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Accessories are required' : null,
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 6.h),

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
                          SizedBox(height: 16.h),
                          ImagePickerPage(
                            imageNotifier: imagesNotifier,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Terms and Conditions
              const TermsAndConditionsScreen(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}


                  // Submit Button
                  //             ElevatedButton(
                  //               onPressed: () {
                  //                 if (formKey.currentState!.validate()) {
                  //                   context.read<FormSubBloc>().add(
                  //                         SubmitForm(
                  //                           formKey: formKey,
                  //                           nameController: nameController,
                  //                           priceController: priceController,
                  //                           securityDepositController:
                  //                               securityDepositController,
                  //                           locationController: locationController,
                  //                           imagesController: imagesController,
                  //                           notesController: notesController,
                  //                           equipmentTypeController:
                  //                               equipmentTypeController,
                  //                           brandModelController: brandModelController,
                  //                           conditionController: conditionController,
                  //                           dateAddedController: dateAddedController,
                  //                           accessoriesController: accessoriesController,
                  //                           damageController: damageController,
                  //                           nameFocusNode: nameFocusNode,
                  //                           priceFocusNode: priceFocusNode,
                  //                           sdFocusNode:
                  //                               sdFocusNode,
                  //                           locationFocusNode: locationFocusNode,
                  //                           imagesFocusNode: imagesFocusNode,
                  //                           notesFocusNode: notesFocusNode,
                  //                           equipmentTypeFocusNode: equipmentTypeFocusNode,
                  //                           brandFocusNode: brandModelFocusNode,
                  //                           conditionFocusNode: conditionFocusNode,
                  //                           dateAddedFocusNode: dateAddedFocusNode,
                  //                           accessoriesFocusNode: accessoriesFocusNode,
                  //                           damageFocusNode: damageFocusNode,
                  //                         ),
                  //                       );
                  //                   log('''
                  // Name: ${nameController.text}
                  // Price: ${priceController.text}
                  // Security Deposit: ${securityDepositController.text}
                  // Location: ${locationController.text}
                  // Images: ${imagesController.text}
                  // Notes: ${notesController.text}
                  // Equipment Type: ${equipmentTypeController.text}
                  // Brand/Model: ${brandModelController.text}
                  // Condition: ${conditionController.text}
                  // Date Added: ${dateAddedController.text}
                  // Accessories: ${accessoriesController.text}
                  // Damage: ${damageController.text}
                  // ''');
                  //                 }
                  //               },
                  //               child: const Text("Submit"),
                  //             ),

/*
SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Camera Type',
                  child: CustomTextField(
                    // controller: nameController,
                    hint: 'Enter Camera Type',
                    numberLimit: 20,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        formBloc.add(UpdateField('cameraType', 'Invalid'));
                        return 'Please enter the Camera Type';
                      }
                      formBloc.add(UpdateField('cameraType', value));
                      log("name entered---------------------------");
                      return null;
                    },
                  ),
                ),
                // _buildSection(
                //   title: 'Camera Equipment Type',
                //   child: ReusableDropdown(
                //     bloc: cameraType,
                //     items: const [
                //       "Photography",
                //       "Videography",
                //       "Action",
                //       "Specialized",
                //       "Hybrid",
                //     ],
                //     hint: 'Enter Equipment Type (e.g., Camera, Lens, Gimbal)',
                //     onDataSelected: onTypeSelected,
                //   ),
                // ),
                // _buildSection(
                //   title: 'Brand/Model',
                //   child: ReusableDropdown(
                //     bloc: cameraBrand,
                //     items: const [
                //       "Blackmagic Design",
                //       "Canon",
                //       "DJI",
                //       "Fujifilm",
                //       "GoPro",
                //       "Hasselblad",
                //       "InstaX (Fujifilm)",
                //       "Kodak",
                //       "Leica",
                //       "Nikon",
                //       "Olympus (OM System)",
                //       "Panasonic (Lumix)",
                //       "Pentax",
                //       "Polaroid",
                //       "Phase One",
                //       "Red Digital Cinema",
                //       "Ricoh",
                //       "Sigma",
                //       "Sony",
                //       "Z Cam",
                //     ],
                //     hint: 'Choose a Camera Brand',
                //     onDataSelected: onBrandSelected,
                //   ),
                // ),
                _buildSection(
                  title: 'Rental Price (Per Day)',
                  child: CustomTextField(
                    hint: 'Enter Rental Price Per Day',
                    numberLimit: 6,
                    // controller: rentalPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        formBloc.add(UpdateField('Price', 'Invalid'));
                        return 'Please enter the Camera Price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      formBloc.add(UpdateField('Price', value));

                      return null;
                    },
                  ),
                ),
                _buildSection(
                  title: 'Security Deposit',
                  child: CustomTextField(
                    hint: 'Enter Security Deposit Amount',
                    numberLimit: 6,
                    // controller: securityDepositController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Please enter the Security Deposit';
                        formBloc.add(UpdateField('Security', 'Invalid'));
                        return 'Please enter the Camera Security Price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid deposit';
                      }
                      formBloc.add(UpdateField('Security', value));
                      return null;
                    },
                  ),
                ),
                // _buildSection(
                //   title: 'Condition',
                //   child: ReusableDropdown(
                //     onDataSelected: onConditionSelected,
                //     bloc: cameraCondition,
                //     items: const ['New', 'Like New', 'Good'],
                //     hint: "Condition",
                //   ),
                // ),
                _buildSection(
                  title: 'Available Date',
                  child: buildCalender(context, onDaySelected),
                ),
                _buildSection(
                  title: 'Accessories Included',
                  child: CustomTextField(
                    hint:
                        'List Any Included Accessories (e.g., Tripod, Memory Card)',
                    numberLimit: 100,
                    // controller: accessoriesController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        formBloc.add(UpdateField('Accessories', 'Invalid'));
                        return 'Please enter the Camera Accessories';
                      }
                      formBloc.add(UpdateField('Accessories', value));
                      return null;
                    },
                  ),
                ),
                _buildSection(
                  title: 'Images',
                  child: ImagePickerFormField(
                    onSaved: (images) {
                      for (var controller in images ?? []) {
                        log('Image path: ${controller.text}');
                      }
                    },
                    validator: (images) {
                      if (images == null || images.isEmpty) {
                        formBloc.add(UpdateField('Images', 'Invalid'));
                        return 'Please enter the Camera Images';
                      }
                      formBloc.add(UpdateField('Images', images));
                      return null;
                    },
                  ),
                ),
                _buildSection(
                  title: 'Pickup/Location Option',
                  child: buildLocationTextField(
                    context: context,
                    hint: 'Current Place',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Current Place') {
                        BlocProvider.of<LocationBloc>(context).add(
                          LocationValidationFailed(
                              "Please Choose the Location"),
                        );
                        return "Please Choose the Location";
                      }

                      BlocProvider.of<LocationBloc>(context)
                          .add(LocationValidationCleared());
                      formBloc.add(UpdateField('Location', value));
                      return value;
                    },
                    locationController: onLocationSelected,
                  ),
                ),
                _buildSection(
                  title: 'Damage Policy',
                  child: CustomTextField(
                    hint: 'Enter the damage policy',
                    maxLines: 5,
                    // controller: insuranceController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        formBloc.add(UpdateField('Damage', 'Invalid'));
                        return 'Please enter the Camera Damage';
                      }
                      formBloc.add(UpdateField('Images', value));
                      return null;
                    },
                  ),
                ),
                _buildSection(
                  title: 'Notes or Additional Information',
                  child: CustomTextField(
                    hint: 'Enter Any Additional Notes',
                    keyboardType: TextInputType.text,
                    // controller: notesController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        formBloc.add(UpdateField('Notes', 'Invalid'));
                        return 'Please enter the Camera Notes';
                      }
                      formBloc.add(UpdateField('Notes', value));
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),

      */