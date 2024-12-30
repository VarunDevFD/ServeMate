import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
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
  final formKey = GlobalKey<FormState>();
  // Controllers
  final brandController = TextEditingController();
  final capacityController = TextEditingController();
  TextEditingController? categorySelected;
  TextEditingController? colorController;
  TextEditingController? conditionController;
  final damageController = TextEditingController();
  String? dateController;
  final descriptionController = TextEditingController();
  TextEditingController? durationController;
  List<TextEditingController>? facilities = [];
  List<TextEditingController>? facilitiesSecond = [];
  TextEditingController? fuelController;
  TextEditingController? genderController;
  List<TextEditingController>? imageController = [];
  TextEditingController locationController = TextEditingController();
  TextEditingController? materials;
  final materialController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final regNumberController = TextEditingController();
  final seatCapacityController = TextEditingController();
  TextEditingController? sizeController;
  final sizejweleryController = TextEditingController();
  final securityController = TextEditingController();
  String? toggleController;
  TextEditingController? transmissionController;
  TextEditingController? typeController;

  AddPage({super.key});

  // Callback to handle gender selection
  void onGenderSelected(TextEditingController? gender) {
    genderController = gender;
    log("Gender: ${genderController.toString()}");
  }

  void onTypeSelected(TextEditingController? type) {
    typeController = type;
    log("Type: ${typeController.toString()}");
  }

  // FootWear
  void onCategorySelected(TextEditingController? category) {
    categorySelected = category;
    log("Type: ${categorySelected.toString()}");
  }

  void onMaterialSelected(TextEditingController? material) {
    materials = material;
    log("Type: ${materials.toString()}");
  }

  void onModelSelected(TextEditingController? model) {
    modelController = model!;
    log("Model: ${modelController.toString()}");
  }

  void onSizeSelected(TextEditingController? size) {
    sizeController = size;
    log("Size: ${sizeController.toString()}");
  }

  void onColorSelected(TextEditingController? color) {
    colorController = color;
    log("Color: ${colorController.toString()}");
  }

  void onDurationSelected(TextEditingController? duration) {
    durationController = duration;
    log("Duration: ${durationController.toString()}");
  }

  void onConditionSelected(TextEditingController? condition) {
    conditionController = condition;
    log("Condition: ${conditionController.toString()}");
  }

  void onDateSelected(String? date) {
    dateController = date;
    log("Date: ${dateController.toString()}");
  }

  void onLocationSelected(TextEditingController? location) {
    locationController = location!;
    log("Location: ${locationController.toString()}");
  }

  void onImageSelected(List<TextEditingController>? images) {
    imageController = images!;
    for (var controller in images) {
      log('this is image ${controller.text}');
    }
  }

  void onFacilitySelected(TextEditingController? facility) {
    if (facility != null) {
      facilities?.add(facility);
      log("Selected Facility: ${facility.toString()}");
    }
  }

  void onFacilitySelected2(TextEditingController? facility2) {
    if (facility2 != null) {
      facilitiesSecond?.add(facility2);
      log("Selected Facility: ${facility2.toString()}");
    }
  }

  void onFuelSelected(TextEditingController? fuel) {
    fuelController = fuel;
    log("Fuel: ${fuelController.toString()}");
  }

  void onTransmissionSelected(TextEditingController? transmission) {
    transmissionController = transmission;
    log("Transmission: ${transmissionController.toString()}");
  }

  void onToggleSelected(String? toggle) {
    toggleController = toggle;
    log("Toggle: ${toggleController.toString()}");
  }

  Future<String?> _getCategoryFromPref() async {
    final PreferencesRepository prefs = serviceLocator<PreferencesRepository>();
    return prefs.getDataFn();
  }

  // Reset all the controllers
  void onFormReset() {
    nameController.clear();
    brandController.clear();
    materialController.clear();
    descriptionController.clear();
    capacityController.clear();
    durationController?.clear();
    genderController?.clear();
    typeController?.clear();
    sizeController?.clear();
    colorController?.clear();
    modelController.clear();
    priceController.clear();
    securityController.clear();
    phoneController.clear();
    emailController.clear();
    seatCapacityController.clear();
    regNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getCategoryFromPref(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
            // LoadingDialog.show(context)
          );
        }

        final category = snapshot.data;

        if (category == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('No category selected')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('$category  Rental Form'),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  handleFormSubmission(
                    categoryName: category,
                    formKey: formKey,
                    context: context,
                    onFormReset: onFormReset,
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
                    securityController:
                        double.tryParse(securityController.text),
                    conditionController: conditionController,
                    dateController: dateController,
                    locationController: locationController,
                    phoneController: phoneController,
                    fuelController: fuelController,
                    seatCapacityController: seatCapacityController,
                    regNumberController: regNumberController,
                    transmission: transmissionController,
                    toggleController: toggleController,
                    categoryController: categorySelected,
                  );
                },
              ),
            ],
          ),
          body: _getFormForCategory(category),
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
