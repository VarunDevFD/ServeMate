import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/data/models/vehicle_model.dart';
import 'package:serve_mate/features/product/data/models/venues_model.dart';

void handleFormSubmission({
  required String categoryName,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
  // Add all your controllers here
  TextEditingController? nameController,
  TextEditingController? brandController,
  TextEditingController? materialController,
  TextEditingController? descriptionController,
  TextEditingController? capacityController,
  TextEditingController? phoneController,
  TextEditingController? damageController,
  TextEditingController? seatCapacityController,
  TextEditingController? regNumberController,
  List<String>? imageController,
  List<String>? facilitiesVenue,
  String? durationController,
  String? genderController,
  String? typeController,
  String? sizeController,
  String? colorController,
  String? modelController,
  double? priceController,
  double? securityController,
  String? conditionController,
  String? dateController,
  String? locationController,
  String? emailController,
  String? fuelController,
  String? transmission,
  String? toggleController,
}) {
  // Validate the form
  if (formKey.currentState?.validate() ?? false) {
    formKey.currentState?.save();

    // Switch case to handle different categories
    switch (categoryName.toLowerCase()) {
      case 'dress':
        final dress = DressModel(
          gender: genderController,
          type: typeController,
          model: modelController,
          size: sizeController,
          color: colorController,
          material: materialController?.text,
          brand: brandController?.text,
          duration: durationController,
          price: priceController,
          security: securityController,
          condition: conditionController,
          date: dateController,
          location: locationController,
          images: imageController,
          damage: damageController?.text, // Add damage controller if needed
          description: descriptionController?.text,
        );
        _submitDressForm(dress, context);
        break;

      case 'venue':
        final venue = VenueModel(
          name: nameController?.text,
          capacity: int.tryParse(capacityController?.text ?? ''),
          rentalPrice: priceController,
          securityDeposit: securityController,
          venueType: typeController,
          phone: phoneController,
          email: emailController,
          location: locationController,
          duration: durationController,
          date: dateController,
          images: imageController,
          facilities: facilitiesVenue,
          description: descriptionController?.text,
        );
        _submitVenueForm(venue, context);
        break;

      case 'Cameras':
        final camera = CameraModel(
          cameraName: nameController?.text,
          equipmentType: typeController,
          brandModel: brandController?.text,
          rentalPrice: priceController,
          securityDeposit: securityController,
          condition: conditionController,
          date: dateController,
          accessories: facilitiesVenue,
          location: locationController,
          damage: damageController?.text,
          notes: descriptionController?.text,
        );
        _submitCameraForm(camera, context);
        break;

      case 'vehicle':
        final vehicle = VehicleModel(
          name: nameController?.text,
          brand: brandController?.text,
          color: colorController,
          seatCapacity: int.tryParse(seatCapacityController?.text ?? ''),
          registrationNumber: regNumberController?.text,
          rentalPrice: priceController,
          securityDeposit: securityController,
          vehicleType: typeController, // This will be a selected type
          model: brandController?.text, // Selected model
          fuelType: fuelController, // Selected fuel type
          transmission: transmission, // Selected transmission type
          facilities: facilitiesVenue, // Selected facilities
          images: imageController, // Assuming images are passed here
          date: dateController,
          location: locationController, // Location controller function
          toggleOption: toggleController, // Toggle-specific option
          description: descriptionController?.text,
        );
        _submitVehicleForm(vehicle, context);
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid category selected.')),
        );
        break;
    }
  } else {
    // Show error message if the form is invalid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please complete the form correctly.')),
    );
  }
}

// Helper methods for submission
void _submitDressForm(DressModel dress, BuildContext context) {
  // Add logic to save the dress model to the database or backend
  log('DressModel submitted: $dress');
  _showSuccessDialog(context);
}

void _submitVenueForm(VenueModel venue, BuildContext context) {
  // Add logic to save the venue model to the database or backend
  log('VenueModel submitted: $venue');
  _showSuccessDialog(context);
}

void _submitCameraForm(CameraModel camera, BuildContext context) {
  // Add logic to save the venue model to the database or backend
  log('VenueModel submitted: $camera');
  _showSuccessDialog(context);
}

void _submitVehicleForm(VehicleModel vehicle, BuildContext context) {
  // Add logic to save the venue model to the database or backend
  log('VehicleModel submitted: $vehicle');
  _showSuccessDialog(context);
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Success'),
      content: const Text('Form submitted successfully!'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
