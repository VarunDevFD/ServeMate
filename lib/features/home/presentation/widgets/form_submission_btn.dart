import 'dart:developer';

import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';

void submissionForm({
  final String? formName,
  required FormSubmissionBloc bloc,
}) {
  // Reset all controllers function
  void resetAllControllers() {
    sdController.clear();
    nameController.clear();
    priceController.clear();
    notesController.clear();
    brandController.clear();
    imagesController.clear();
    damageController.clear();
    storageController.clear();
    locationController.clear();
    categoryController.clear();
    conditionController.clear();
    accessoriesController.clear();
    decorStylesController.clear();
    descriptionController.clear();
    equipmentTypeController.clear();
  }

  // Camera Form
  final camera = Camera(
      name: nameController.text,
      brand: brandController.text,
      model: modelController.text,
      category: categoryController.text,
      description: descriptionController.text,
      price: int.parse(priceController.text),
      sdPrice: int.parse(sdController.text),
      available: true,
      location: [locationController.text],
      phoneNumber: phoneController.text,
      condition: conditionController.text,
      storage: [storageController.text],
      connectivity: [accessoriesController.text],
      duration: minDurationController.text,
      latePolicy: lateFeeController.text,
      images: [lateFeeController.text],
      privacyPolicy: true);
      log(camera.toString());

  // Select the Button from the Form Selected
  switch (formName) {
    case 'Cameras':
      {
        log("-----------------------------------------------------------------");
        log(nameController.toString());

        bloc.add(CameraEvent());
        resetAllControllers();
        log(nameController.toString());
        break;
      }

    // case 'Decoration':
    //   {
    //     bloc.add(DecorationEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Dresses':
    //   {
    //     bloc.add(DressesEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Footwear':
    //   {
    //     bloc.add(FootwearEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Jewelry':
    //   {
    //     bloc.add(JewelryEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Sound & DJ Systems':
    //   {
    //     bloc.add(SoundDJEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Vehicles':
    //   {
    //     bloc.add(VehiclesEvent());
    //     resetAllControllers();
    //     break;
    //   }

    // case 'Venue':
    //   {
    //     bloc.add(VenueEvent());
    //     resetAllControllers();
    //     break;
    //   }
    default:
      {
        break;
      }
  }
}
