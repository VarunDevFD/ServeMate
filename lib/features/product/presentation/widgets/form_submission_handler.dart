import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/decoration_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/footwear_model.dart';
import 'package:serve_mate/features/product/data/models/jewelry_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';
import 'package:serve_mate/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/product_bloc/product_event.dart';

void handleFormSubmission({
  required String categoryName,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
  required VoidCallback onFormReset, // Callback for resetting controllers
  TextEditingController? brandController,
  TextEditingController? capacityController,
  TextEditingController? categoryController,
  TextEditingController? colorController,
  TextEditingController? conditionController,
  TextEditingController? damageController,
  String? dateController,
  TextEditingController? descriptionController,
  TextEditingController? durationController,
  List<TextEditingController>? facilitiesVenue,
  List<TextEditingController>? facilitiesVenue2,
  TextEditingController? fuelController,
  TextEditingController? genderController,
  List<TextEditingController>? imageController,
  TextEditingController? locationController,
  TextEditingController? materialController,
  TextEditingController? modelController,
  TextEditingController? nameController,
  double? priceController,
  TextEditingController? quantityController,
  TextEditingController? regNumberController,
  TextEditingController? seatCapacityController,
  double? securityController,
  TextEditingController? sizeController,
  TextEditingController? sizejweleryController,
  String? toggleController,
  TextEditingController? transmission,
  TextEditingController? typeController,
  TextEditingController? phoneController,
}) {
  // Validate the form
  if (formKey.currentState?.validate() ?? false) {
    formKey.currentState?.save();

    // Switch case to handle different categories
    switch (categoryName) {
      case 'Dresses':
        final dress = DressModel(
          gender: genderController?.text ?? '',
          type: typeController?.text ?? '',
          model: modelController?.text ?? '',
          size: sizeController?.text ?? '',
          color: colorController?.text ?? '',
          material: materialController?.text ?? '',
          brand: brandController?.text ?? '',
          duration: durationController?.text ?? '',
          price: priceController ?? 0.0,
          security: securityController ?? 0.0,
          condition: conditionController?.text ?? '',
          date: dateController ?? '',
          location: locationController?.text ?? '',
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          damage: damageController?.text ?? '',
          description: descriptionController?.text ?? '',
        );
        _submitDressForm(dress, context, onFormReset);
        break;

      case 'Venue':
        final venue = VenueModel(
          name: nameController?.text ?? '',
          capacity: int.tryParse(capacityController?.text ?? '0') ?? 0,
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          venueType: typeController?.text ?? '',
          location: locationController?.text ?? '',
          duration: durationController?.text ?? '',
          date: dateController ?? '',
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          facilities:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          selectedFacilities:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          description: descriptionController?.text ?? '',
        );
        _submitVenueForm(venue, context, onFormReset);
        break;

      case 'Cameras':
        final camera = CameraModel(
          name: nameController?.text ?? '',
          price: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          location: locationController?.text ?? '',
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          notes: descriptionController?.text ?? '',
          equipmentType: typeController?.text ?? '',
          brandModel: brandController?.text ?? '',
          condition: conditionController?.text ?? '',
          dateAdded: dateController ?? '',
          accessories:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          damage: damageController?.text ?? '',
        );

        _submitCameraForm(camera, context, onFormReset);
        break;

      case 'Vehicles':
        final vehicle = VehicleModel(
          name: nameController?.text ?? '',
          brand: brandController?.text ?? '',
          color: colorController?.text ?? '',
          seatCapacity: int.tryParse(seatCapacityController?.text ?? '0') ?? 0,
          registrationNumber: regNumberController?.text ?? '',
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          vehicleType: typeController?.text ?? '',
          model: brandController?.text ?? '',
          fuelType: fuelController?.text ?? '',
          transmission: transmission?.text ?? '',
          facilities:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          date: dateController ?? '',
          location: locationController?.text ?? '',
          toggleOption: toggleController ?? '',
          description: descriptionController?.text ?? '',
        );
        _submitVehicleForm(vehicle, context, onFormReset);
        break;

      case 'Decoration':
        final decorationItem = DecorationModel(
          name: nameController?.text ?? '',
          selectedFacilitiesFirst:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          selectedFacilitiesSecond:
              facilitiesVenue2?.map((controller) => controller.text).toList() ??
                  [],
          date: dateController ?? '',
          location: locationController?.text ?? '',
          description: descriptionController?.text ?? '',
        );

        _submitDecorationForm(decorationItem, context, onFormReset);
        break;

      case 'Jewelry':
        final jewelryItem = JewelryModel(
          name: nameController?.text ?? '',
          type: typeController?.text ?? '',
          material: materialController?.text ?? '',
          price: priceController ?? 0.0,
          quantity: quantityController?.text ?? '',
          condition: conditionController?.text ?? '',
          brand: brandController?.text ?? '',
          size: sizejweleryController?.text ?? '',
          color: colorController?.text ?? '',
          securityDeposit: securityController ?? 0.0,
          isAvailable: toggleController ?? '',
          description: descriptionController?.text ?? '',
          dateAdded: dateController ?? '',
          location: locationController?.text ?? '',
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
        );

        _submitJewelryForm(jewelryItem, context, onFormReset);
        break;
      case 'Footwear':
        final footwearItem = FootwearModel(
          name: nameController?.text ?? '',
          price: priceController,
          brand: brandController?.text ?? '',
          securityDeposit: securityController,
          description: descriptionController?.text,
          condition: conditionController?.text ?? '',
          size: sizejweleryController?.text ?? '',
          color: colorController?.text ?? '',
          category: categoryController?.text ?? '',
          isAvailable: toggleController ?? '',
          location: locationController?.text,
          images:
              imageController?.map((controller) => controller.text).toList() ??
                  [],
          date: dateController ?? '',
        );

        _submitFootWearForm(footwearItem, context, onFormReset);
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid category selected.')),
        );
        break;
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please complete the form correctly.')),
    );
  }
}

void _submitDressForm(
  DressModel dress,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitDressEvent(dress));
  log(dress.toString());
  _showSuccessDialog(
    context,
    onFormReset,
  );
}

void _submitVenueForm(
  VenueModel venue,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitVenueEvent(venue));
  log(venue.toString());
  _showSuccessDialog(
    context,
    onFormReset,
  );
}

void _submitCameraForm(
  CameraModel camera,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitCameraEvent(camera));
  log(camera.toString());
  _showSuccessDialog(context, onFormReset);
}

void _submitVehicleForm(
  VehicleModel vehicle,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitVehicleEvent(vehicle));
  log("------------------------------");
  log(vehicle.toString());
  log("------------------------------");

  _showSuccessDialog(context, onFormReset);
}

void _submitDecorationForm(
  DecorationModel decoration,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitDecorationEvent(decoration));
  log(decoration.toString());
  _showSuccessDialog(context, onFormReset);
}

void _submitJewelryForm(
  JewelryModel jewelry,
  BuildContext context,
  VoidCallback onFormReset,
) {
  context.read<ProductBloc>().add(SubmitJewelryEvent(jewelry));
  log(jewelry.toString());
  _showSuccessDialog(context, onFormReset);
}

void _submitFootWearForm(
  FootwearModel footwear,
  BuildContext context,
  VoidCallback onFormReset,
) {
  log(footwear.toString());
  _showSuccessDialog(context, onFormReset);
  context.read<ProductBloc>().add(SubmitFootwearEvent(footwear));
}

void _showSuccessDialog(BuildContext context, VoidCallback onFormReset) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: const Text('Form submitted successfully!'),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
            onFormReset(); // Reset controllers here
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
