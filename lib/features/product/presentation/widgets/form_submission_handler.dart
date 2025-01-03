import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';
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
  List<String>? imageController,
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
    log("****************${imageController.toString()}***********************");

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
              imageController?.map((controller) => controller).toList() ?? [],
          damage: damageController?.text ?? '',
          description: descriptionController?.text ?? '',
        );
        // _showLoadingIndicator(context);

        Future.delayed(const Duration(seconds: 3), () {
          // After 3 seconds, hide the loading indicator and show success dialog
          Navigator.of(context).pop(); // Pop the loading indicator
        });
        _showSuccessDialogDress(context, onFormReset, dress);
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
              imageController?.map((controller) => controller).toList() ?? [],
          facilities:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          selectedFacilities:
              facilitiesVenue?.map((controller) => controller.text).toList() ??
                  [],
          description: descriptionController?.text ?? '',
        );
        _showSuccessDialogVenue(context, onFormReset, venue);
        break;

      case 'Cameras':
        final camera = CameraModel(
          name: nameController?.text ?? '',
          price: priceController ?? 0.0,
          securityDeposit: securityController ?? 0.0,
          location: locationController?.text ?? '',
          images:
              imageController?.map((controller) => controller).toList() ?? [],
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
        _showSuccessDialogCamera(context, onFormReset, camera);
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
              imageController?.map((controller) => controller).toList() ?? [],
          date: dateController ?? '',
          location: locationController?.text ?? '',
          toggleOption: toggleController ?? '',
          description: descriptionController?.text ?? '',
        );
        _showLoadingIndicator(context);

        Future.delayed(const Duration(seconds: 5), () {
          LoadingDialog.show(context);
        });
        LoadingDialog.hide(context);

        _showSuccessDialogVehicle(context, onFormReset, vehicle);

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
              imageController?.map((controller) => controller).toList() ?? [],
          selectedFacilitiesSecond:
              facilitiesVenue2?.map((controller) => controller.text).toList() ??
                  [],
          date: dateController ?? '',
          location: locationController?.text ?? '',
          description: descriptionController?.text ?? '',
        );
        _showSuccessDialogDecoration(context, onFormReset, decorationItem);
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
              imageController?.map((controller) => controller).toList() ?? [],
        );
        _showSuccessDialogJewelry(context, onFormReset, jewelryItem);
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
              imageController?.map((controller) => controller).toList() ?? [],
          date: dateController ?? '',
        );
        _showSuccessDialogFootwear(context, onFormReset, footwearItem);
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

void _showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents the dialog from being dismissed by tapping outside
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(), // Loading indicator
      );
    },
  );
}

void _showSuccessDialogDress(
  BuildContext context,
  VoidCallback onFormReset,
  DressModel dress,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Dress form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitDressEvent(dress));
              context.pop();

              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialogVenue(
  BuildContext context,
  VoidCallback onFormReset,
  VenueModel venue,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Venue form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitVenueEvent(venue));
              context.pop();
              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialogCamera(
  BuildContext context,
  VoidCallback onFormReset,
  CameraModel camera,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Camera form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitCameraEvent(camera));
              context.pop();
              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialogVehicle(
  BuildContext context,
  VoidCallback onFormReset,
  VehicleModel vehicle,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Vehicle form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitVehicleEvent(vehicle));
              LoadingDialog.show(context);
              context.pop();
              onFormReset();
              LoadingDialog.hide(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}


void _showSuccessDialogDecoration(
  BuildContext context,
  VoidCallback onFormReset,
  DecorationModel decoration,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Decoration form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<ProductBloc>()
                  .add(SubmitDecorationEvent(decoration));
              context.pop();
              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialogJewelry(
  BuildContext context,
  VoidCallback onFormReset,
  JewelryModel jewelry,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Jewelry form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitJewelryEvent(jewelry));
              context.pop();
              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialogFootwear(
  BuildContext context,
  VoidCallback onFormReset,
  FootwearModel footWear,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Footwear form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(SubmitFootwearEvent(footWear));

              context.pop();
              onFormReset();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

/*

// void _submitDressForm(
//   DressModel dress,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogDress(context, onFormReset, dress);

// void _submitVenueForm(
//   VenueModel venue,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogVenue(context, onFormReset, venue);

// void _submitCameraForm(
//   CameraModel camera,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogCamera(context, onFormReset, camera);

// void _submitVehicleForm(
//   VehicleModel vehicle,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogVehicle(context, onFormReset, vehicle);

// void _submitDecorationForm(
//   DecorationModel decorationItem,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogDecoration(context, onFormReset, decorationItem);

// void _submitJewelryForm(
//   JewelryModel jewelryItem,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogJewelry(context, onFormReset, jewelryItem);

// void _submitFootWearForm(
//   FootwearModel footwearItem,
//   BuildContext context,
//   VoidCallback onFormReset,
// ) =>
//     _showSuccessDialogFootwear(context, onFormReset, footwearItem);
*/

