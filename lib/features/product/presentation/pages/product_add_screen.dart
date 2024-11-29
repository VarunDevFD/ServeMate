import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/product/data/models/dress_model.dart';
import 'package:serve_mate/features/product/presentation/widgets/camera_videography_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/catering_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/footwear_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/jewelry_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/sound_dj_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/vehicle_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/venue_form.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? genderController;
  String? typeController;
  String? modelController;
  String? sizeController;
  String? colorController;

  final materialController = TextEditingController();
  final brandController = TextEditingController();
  String? durationController;
  final priceController = TextEditingController();
  final securityController = TextEditingController();
  String? conditionController;
  String? dateController;
  String? locationController;
  List<String> imageController = [];
  final damageController = TextEditingController();
  final descriptionController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(state.message)),
          );
        } else if (state is CategoryLoaded && state.selectedCategory != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${state.selectedCategory!.name} Rental Form'),
              actions: [
                // Icon button on the right side for form confirmation
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    // Trigger form validation before proceeding
                    final isValid = formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      formKey.currentState?.save();

                      // Collect all the data and create a DressModel
                      final dress = DressModel(
                        gender: genderController,
                        type: typeController,
                        model: modelController,
                        size: sizeController,
                        color: colorController,
                        material: materialController.text,
                        brand: brandController.text,
                        duration: durationController,
                        price: double.tryParse(priceController.text),
                        security: double.tryParse(securityController.text),
                        condition: conditionController,
                        date: dateController,
                        location: locationController,
                        images: imageController,
                        damage: damageController.text,
                        description: descriptionController.text,
                      );
                      _showSuccessDialog(context);
                      // Form is valid, proceed to next screen or action
                    } else {
                      // Optionally show an error message or do nothing if invalid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please complete the form correctly.')),
                      );
                    }
                  },
                ),
              ],
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _getFormForCategory(state.selectedCategory!.name),
            ).animate().fadeIn(duration: 500.ms).slideY(),
          );
        }

        // Return statement added here
        return Scaffold(
          appBar: AppBar(
            title: const Text('No category selected'),
          ),
          body: const Center(child: Text('No category selected')),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Form completed successfully!'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
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
        return const VehicleForm();
      case 'Decoration':
        return const DecorationForm();
      case 'Jewelry':
        return const JewelryForm();
      case 'Venue':
        return const VenueForm();
      case 'Catering':
        return const CateringForm();
      case 'Footwear':
        return const FootwearForm();
      case 'Cameras':
        return const CameraVideographyForm();
      case 'Sound & DJ Systems':
        return const SoundDJForm();
      default:
        return const Center(child: Text('Invalid Category'));
    }
  }
}