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
  TextEditingController? nameController,
  TextEditingController? brandController,
  TextEditingController? materialController,
  TextEditingController? descriptionController,
  TextEditingController? capacityController,
  TextEditingController? phoneController,
  TextEditingController? damageController,
  TextEditingController? seatCapacityController,
  TextEditingController? regNumberController,
  TextEditingController? quantityController,
  TextEditingController? sizejweleryController,
  List<String>? imageController,
  List<String>? facilitiesVenue,
  List<String>? facilities1,
  List<String>? facilities2,
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
  String? categoryController,
}) {
  // Validate the form
  if (formKey.currentState?.validate() ?? false) {
    formKey.currentState?.save();

    // Switch case to handle different categories
    switch (categoryName) {
      case 'Dresses':
        final dress = DressModel(
          gender: genderController ?? '',
          type: typeController ?? '',
          model: modelController ?? '',
          size: sizeController ?? '',
          color: colorController ?? '',
          material: materialController?.text ?? '',
          brand: brandController?.text ?? '',
          duration: durationController ?? '',
          price: priceController ?? 0.0,
          security: securityController ?? 0.0,
          condition: conditionController ?? '',
          date: DateTime.tryParse(dateController ?? '') ?? DateTime.now(),
          location: locationController ?? '',
          images: imageController ?? [],
          damage: damageController?.text ?? '',
          description: descriptionController?.text ?? '',
        );
        _submitDressForm(dress, context, categoryName);
        break;

      case 'Venue':
        final venue = VenueModel(
          name: nameController?.text ?? '',
          capacity: int.tryParse(capacityController?.text ?? '0') ?? 0,
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          venueType: typeController ?? '',
          location: locationController ?? '',
          duration: durationController ?? '',
          date: dateController ?? '',
          images: imageController ?? [], // Ensure this is a List<String>
          facilities: facilitiesVenue ?? [], // Ensure this is a List<String>
          selectedFacilities:
              facilitiesVenue ?? [], // Ensure this is a List<String>
          description: descriptionController?.text ?? '',
        );
        _submitVenueForm(venue, context, categoryName);
        break;

      case 'Cameras':
        final camera = CameraModel(
          name: nameController?.text ?? '',
          price: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          location: locationController ?? '',
          images: imageController ?? [], // Ensure this is a List<String>
          notes: descriptionController?.text ?? '',
          equipmentType: typeController ?? '',
          brandModel: brandController?.text ?? '',
          condition: conditionController ?? '',
          dateAdded: dateController ?? '',
          accessories: facilitiesVenue ?? [], // Ensure this is a List<String>
          damage: damageController?.text ?? '',
        );

        _submitCameraForm(camera, context, categoryName);
        break;

      case 'Vehicles':
        final vehicle = VehicleModel(
          name: nameController?.text ?? '',
          brand: brandController?.text ?? '',
          color: colorController ?? '',
          seatCapacity: int.tryParse(seatCapacityController?.text ?? '0') ?? 0,
          registrationNumber: regNumberController?.text ?? '',
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          vehicleType: typeController ?? '',
          model: brandController?.text ?? '',
          fuelType: fuelController ?? '',
          transmission: transmission ?? '',
          facilities: facilitiesVenue ?? [],
          images: imageController ?? [],
          date: dateController ?? '',
          location: locationController ?? '',
          toggleOption: toggleController ?? '',
          description: descriptionController?.text ?? '',
        );
        _submitVehicleForm(vehicle, context, categoryName);
        break;

      case 'Decoration':
        final decorationItem = DecorationItem(
          name: nameController?.text ?? '',
          selectedFacilitiesFirst: facilities1 ?? [],
          rentalPrice: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          imageUrls: imageController ?? [],
          selectedFacilitiesSecond: facilities2 ?? [],
          date: dateController ?? '',
          location: locationController ?? '',
          description: descriptionController?.text ?? '',
        );

        _submitDecorationForm(decorationItem, context, categoryName);
        break;

      case 'Jewelry':
        final jewelryItem = JewelryModel(
          name: nameController?.text ?? '',
          type: typeController ?? '',
          material: materialController?.text ?? '',
          price: priceController ?? 0.0,
          quantity: quantityController?.text ?? '',
          condition: conditionController ?? '',
          brand: brandController?.text ?? '',
          size: sizejweleryController?.text ?? '',
          color: colorController ?? '',
          securityDeposit: securityController ?? 0.0,
          isAvailable: toggleController ?? '',
          description: descriptionController?.text ?? '',
          dateAdded: dateController ?? '',
          location: locationController ?? '',
          images: imageController ?? [],
        );

        _submitJewelryForm(jewelryItem, context);
        break;
      case 'Footwear':
        final footwearItem = FootwearModel(
          name: nameController?.text ?? '',
          price: priceController,
          brand: brandController?.text ?? '',
          securityDeposit: securityController,
          description: descriptionController?.text,
          condition: conditionController ?? '',
          size: sizejweleryController?.text ?? '',
          color: colorController ?? '',
          category: categoryController ?? '',
          isAvailable: toggleController ?? '',
          location: locationController,
          images: imageController ?? [],
          date: dateController ?? '',
        );

        _submitFootWearForm(footwearItem, context);
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
    DressModel dress, BuildContext context, String categoryName) {
  context.read<ProductBloc>().add(SubmitDressEvent(dress));
  log(dress.toString());
  _showSuccessDialog(context);
}

void _submitVenueForm(
    VenueModel venue, BuildContext context, String categoryName) {
  context.read<ProductBloc>().add(SubmitVenueEvent(venue));
  log(venue.toString());
  _showSuccessDialog(context);
}

void _submitCameraForm(
    CameraModel camera, BuildContext context, String categoryName) {
  context.read<ProductBloc>().add(SubmitCameraEvent(camera));
  log(camera.toString());
  _showSuccessDialog(context);
}

void _submitVehicleForm(
    VehicleModel vehicle, BuildContext context, String categoryName) {
  context.read<ProductBloc>().add(SubmitVehicleEvent(vehicle));
  log("------------------------------");
  log(vehicle.toString());
  log("------------------------------");

  _showSuccessDialog(context);
}

void _submitDecorationForm(
    DecorationItem decoration, BuildContext context, String categoryName) {
  context.read<ProductBloc>().add(SubmitDecorationEvent(decoration));
  log(decoration.toString());
  _showSuccessDialog(context);
}

void _submitJewelryForm(JewelryModel jewelry, BuildContext context) {
  context.read<ProductBloc>().add(SubmitJewelryEvent(jewelry));
  log(jewelry.toString());
  _showSuccessDialog(context);
}

void _submitFootWearForm(FootwearModel footwear, BuildContext context) {
  log(footwear.toString());
  _showSuccessDialog(context);
  context.read<ProductBloc>().add(SubmitFootwearEvent(footwear));
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: const Text('Form submitted successfully!'),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
