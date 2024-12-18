import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/product/presentation/widgets/camera_videography_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/footwear_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/form_submission_handler.dart';
import 'package:serve_mate/features/product/presentation/widgets/jewelry_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/sound_dj_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/vehicle_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/venue_form.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> imageController = [];
  String? transmissionController;
  String? genderController;
  String? typeController;
  String? materials;
  String? modelController;
  String? sizeController;
  String? colorController;
  String? fuelController;
  String? toggleController;
  String? categorySelected;
  String? conditionController;
  String? durationController;
  String? locationController;
  String? dateController;

  final materialController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  final securityController = TextEditingController();
  final damageController = TextEditingController();
  final descriptionController = TextEditingController();

  // venues
  final nameController = TextEditingController();
  final capacityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  List<String> facilities = [];

  // Vehicle
  final seatCapacityController = TextEditingController();
  final regNumberController = TextEditingController();

  // Decoration
  List<String> facilitiesSecond = [];

  // Jwelery
  final quantityController = TextEditingController();
  final sizejweleryController = TextEditingController();

  AddPage({super.key});

  // Callback to handle gender selection
  void onGenderSelected(String? gender) {
    genderController = gender;
    log("Gender: ${genderController.toString()}");
  }

  void onTypeSelected(String? type) {
    typeController = type;
    log("Type: ${typeController.toString()}");
  }

  // FootWear
  void onCategorySelected(String? category) {
    categorySelected = category;
    log("Type: ${categorySelected.toString()}");
  }

  void onMaterialSelected(String? material) {
    materials = material;
    log("Type: ${materials.toString()}");
  }

  void onModelSelected(String? model) {
    modelController = model;
    log("Model: ${modelController.toString()}");
  }

  void onSizeSelected(String? size) {
    sizeController = size;
    log("Size: ${sizeController.toString()}");
  }

  void onColorSelected(String? color) {
    colorController = color;
    log("Color: ${colorController.toString()}");
    log(materialController.toString());
    log(brandController.toString());
  }

  void onDurationSelected(String? duration) {
    durationController = duration;
    log("Duration: ${durationController.toString()}");
    log(priceController.toString());
    log(securityController.toString());
  }

  void onConditionSelected(String? condition) {
    conditionController = condition;
    log("Condition: ${conditionController.toString()}");
  }

  void onDateSelected(String? date) {
    dateController = date;
    log("Date: ${dateController.toString()}");
  }

  void onLocationSelected(String? location) {
    locationController = location;
    log("Location: ${locationController.toString()}");
  }

  void onImageSelected(List<String> images) {
    imageController = images;
    log("Images: ${imageController.toString()}");
  }

  void onFacilitySelected(String? facility) {
    if (facility != null) {
      facilities.add(facility);
      log("Selected Facility: ${facility.toString()}");
    }
  }

  void onFacilitySelected2(String? facility2) {
    if (facility2 != null) {
      facilitiesSecond.add(facility2);
      log("Selected Facility: ${facility2.toString()}");
    }
  }

  void onFuelSelected(String? fuel) {
    fuelController = fuel;
    log("Fuel: ${fuelController.toString()}");
  }

  void onTransmissionSelected(String? transmission) {
    transmissionController = transmission;
    log("Transmission: ${transmissionController.toString()}");
  }

  void onToggleSelected(String? toggle) {
    toggleController = toggle;
    log("Toggle: ${toggleController.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        Widget body; // Common body content
        String title; // AppBar title
        List<Widget>? actions; // Optional actions for the AppBar

        if (state is CategoryInitial) {
          title = 'Loading...';
          body = Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: AppColors.orange,
              size: 50.r,
              secondRingColor: AppColors.grey,
              thirdRingColor: AppColors.white,
            ),
          );
        } else if (state is CategoryError) {
          title = 'Error';
          body = Center(child: Text(state.message));
        } else if (state is CategoryLoaded) {
          title = '${state.categories[1].name} Rental Form';
          actions = [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                handleFormSubmission(
                  categoryName: state.categories[1].name,
                  formKey: formKey,
                  context: context,
                  nameController: nameController,
                  brandController: brandController,
                  materialController: materialController,
                  descriptionController: descriptionController,
                  imageController: imageController,
                  facilitiesVenue: facilities,
                  capacityController: capacityController,
                  durationController: durationController,
                  genderController: genderController,
                  typeController: typeController,
                  sizeController: sizeController,
                  colorController: colorController,
                  modelController: modelController,
                  priceController: double.tryParse(priceController.text),
                  securityController: double.tryParse(securityController.text),
                  conditionController: conditionController,
                  dateController: dateController,
                  locationController: locationController,
                  phoneController: phoneController,
                  emailController: emailController.text,
                  fuelController: fuelController,
                  seatCapacityController: seatCapacityController,
                  regNumberController: regNumberController,
                  transmission: transmissionController,
                  toggleController: toggleController,
                  categoryController: categorySelected,
                );
              },
            ),
          ];
          body = AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _getFormForCategory(state.categories[1].name),
          ).animate().fadeIn(duration: 500.ms).slideY();
        } else {
          title = 'No category selected';
          body = const Center(child: Text('No category selected'));
        }

        return Scaffold(
          appBar: AppBar(title: Text(title), actions: actions),
          body: body,
        );
      },
    );
  }

  Widget _getFormForCategory(String? category) {
    switch (category) {
      case 'Dresses':
        return DressForm(
          formKey: formKey,
          onGenderSelected: onGenderSelected,
          onTypeSelected: onTypeSelected,
          onModelSelected: onModelSelected,
          onSizeSelected: onSizeSelected,
          onColorSelected: onColorSelected,
          materialController: materialController,
          brandController: brandController,
          onDurationSelected: onDurationSelected,
          priceController: priceController,
          securityController: securityController,
          onConditionSelected: onConditionSelected,
          dateController: onDateSelected,
          locationController: onLocationSelected,
          onImageSelected: onImageSelected,
          damageController: damageController,
          descriptionController: descriptionController,
        );
      case 'Vehicles':
        return VehicleForm(
          formKey: formKey,
          nameController: nameController,
          brandController: brandController,
          seatCapacityController: seatCapacityController,
          regNumberController: regNumberController,
          priceController: priceController,
          securityController: securityController,
          onColorSelected: onColorSelected,
          dateController: onDateSelected,
          onTypeSelected: onTypeSelected,
          onModelSelected: onModelSelected,
          onFuelSelected: onFuelSelected,
          onTransmissionSelected: onTransmissionSelected,
          selectedFacilities: onFacilitySelected,
          onImageSelected: onImageSelected,
          locationController: onLocationSelected,
          onToggleSelected: onToggleSelected,
          descriptionController: descriptionController,
        );
      case 'Decoration':
        return DecorationForm(
          formKey: formKey,
          nameController: nameController,
          selectedFacilitiesFIrst: onFacilitySelected,
          rentalPriceController: priceController,
          securityDepositController: securityController,
          onImageSelected: onImageSelected,
          selectedFacilitiesSecond: onFacilitySelected2,
          dateController: onDateSelected,
          locationController: onLocationSelected,
          descriptionController: descriptionController,
        );
      case 'Jewelry':
        return JewelryForm(
          formKey: formKey,
          nameController: nameController,
          onTypeSelected: onTypeSelected,
          onMaterialSelected: onMaterialSelected,
          priceController: priceController,
          quantityController: quantityController,
          onConditionSelected: onConditionSelected,
          brandController: brandController,
          sizeController: sizejweleryController,
          onColorSelected: onColorSelected,
          securityDepositController: securityController,
          onToggleSelected: onToggleSelected,
          descriptionController: descriptionController,
          dateController: onDateSelected,
          locationController: onLocationSelected,
          onImageSelected: onImageSelected,
        );
      case 'Venue':
        return VenueForm(
          formKey: formKey,
          nameController: nameController,
          capacityController: capacityController,
          priceController: priceController,
          securityController: securityController,
          onTypeSelected: onTypeSelected,
          descriptionController: descriptionController,
          phoneController: phoneController,
          emailController: emailController,
          locationController: onLocationSelected,
          onDurationSelected: onDurationSelected,
          dateController: onDateSelected,
          onImageSelected: onImageSelected,
          selectedFacilities: onFacilitySelected,
        );

      case 'Footwear':
        return FootwearForm(
          formKey: formKey,
          nameController: nameController,
          priceController: priceController,
          brandController: brandController,
          securityController: securityController,
          descriptionController: descriptionController,
          onConditionSelected: onConditionSelected,
          onSizeSelected: onSizeSelected,
          onColorSelected: onColorSelected,
          onCategorySelected: onCategorySelected,
          onToggleSelected: onToggleSelected,
          onImageSelected: onImageSelected,
          locationController: onLocationSelected,
          dateController: onDateSelected,
        );
      case 'Cameras':
        return CameraVideographyForm(
          formKey: formKey, // Pass a unique GlobalKey for the form
          nameController: nameController,
          onTypeSelected: onTypeSelected,
          onBrandSelected: onModelSelected,
          rentalPriceController: TextEditingController(),
          securityDepositController: TextEditingController(),
          onConditionSelected: onConditionSelected,
          dateController: onDateSelected,
          accessoriesController: TextEditingController(),
          pickupOptionController: TextEditingController(),
          insuranceController: TextEditingController(),
          notesController: TextEditingController(),
          onImageSelected: onImageSelected,
          locationController: onLocationSelected,
        );
      case 'Sound & DJ Systems':
        return const SoundDJForm();
      default:
        return const Center(child: Text('Invalid Category'));
    }
  }
}


/*
                    // // Trigger form validation before proceeding
                    // final isValid = formKey.currentState?.validate() ?? false;
                    // if (isValid) {
                    //   formKey.currentState?.save();

                    //   // Collect all the data and create a DressModel
                    //   final dress = DressModel(
                    //     gender: genderController,
                    //     type: typeController,
                    //     model: modelController,
                    //     size: sizeController,
                    //     color: colorController,
                    //     material: materialController.text,
                    //     brand: brandController.text,
                    //     duration: durationController,
                    //     price: double.tryParse(priceController.text),
                    //     security: double.tryParse(securityController.text),
                    //     condition: conditionController,
                    //     date: dateController,
                    //     location: locationController,
                    //     images: imageController,
                    //     damage: damageController.text,
                    //     description: descriptionController.text,
                    //   );
                    //   final venue = VenueModel(
                    //     name: nameController.text,
                    //     capacity: capacityController,
                    //     rentalPrice: double.tryParse(priceController.text),
                    //     securityDeposit: double.tryParse(securityController.text),
                    //     venueType: typeController,
                    //     phone: phoneController,
                    //     email: emailController,
                    //     location: locationController,
                    //     duration: durationController,
                    //     date: dateController,
                    //     images: imageController,
                    //     facilities: const [],
                    //     selectedFacilities: const [],
                    //     description: descriptionController.text,
                    //   );

                    //   _showSuccessDialog(context);
                    //   // Form is valid, proceed to next screen or action
                    // } else {
                    //   // Optionally show an error message or do nothing if invalid
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content:
                    //             Text('Please complete the form correctly.')),
                    //   );
                    // }
                    */
                    