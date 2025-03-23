import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';

class FormSubmissionBloc extends Bloc<FormSubmissionEvent, FormMainState> {
  FormSubmissionBloc() : super(InitialForm(Camera.empty())) {
    // Register event handlers in the constructor
    on<UpdateField>(_onUpdateCameraField);
    on<CameraEvent>(_onSubmitCameraForm);
  }
  late Camera updatedCamera;
  _onUpdateCameraField(UpdateField event, Emitter<FormMainState> emit) {
    final currentCamera = state.camera;

    switch (event.field) {
      case 'name':
        updatedCamera = currentCamera.copyWith(name: event.value);
        break;
      case 'brand':
        updatedCamera = currentCamera.copyWith(brand: event.value);
        break;
      case 'model':
        updatedCamera = currentCamera.copyWith(model: event.value);
        break;
      case 'category':
        updatedCamera = currentCamera.copyWith(category: event.value);
        break;
      case 'description':
        updatedCamera = currentCamera.copyWith(description: event.value);
        break;
      case 'price':
        updatedCamera = currentCamera.copyWith(price: event.value);
        break;
      case 'sdPrice':
        updatedCamera = currentCamera.copyWith(sdPrice: event.value);
        break;
      case 'available':
        updatedCamera = currentCamera.copyWith(available: event.value);
        break;
      case 'location':
        updatedCamera = currentCamera.copyWith(location: event.value);
        break;
      case 'phoneNumber':
        updatedCamera = currentCamera.copyWith(phoneNumber: event.value);
        break;
      case 'condition':
        updatedCamera = currentCamera.copyWith(condition: event.value);
        break;
      case 'storage':
        updatedCamera = currentCamera.copyWith(storage: event.value);
        break;
      case 'connectivity':
        updatedCamera = currentCamera.copyWith(connectivity: event.value);
        break;
      case 'duration':
        updatedCamera = currentCamera.copyWith(duration: event.value);
        break;
      case 'latePolicy':
        updatedCamera = currentCamera.copyWith(latePolicy: event.value);
        break;
      case 'images': {
        final List<String> images = List.from(currentCamera.images);
        images.add(event.value);
        updatedCamera = currentCamera.copyWith(images: images);
      }
        
        break;
      case 'privacyPolicy':
        updatedCamera = currentCamera.copyWith(privacyPolicy: event.value);
        break;
      default:
        updatedCamera = currentCamera;
    }
    log(updatedCamera.name.toString());
    log(updatedCamera.model.toString());
    log(updatedCamera.brand.toString());
    log(updatedCamera.category.toString());
    log(updatedCamera.description.toString());
    log(updatedCamera.price.toString());
    log(updatedCamera.sdPrice.toString());
    log(updatedCamera.available.toString());
    log(updatedCamera.location.toString());
    log(updatedCamera.condition.toString());
    log(updatedCamera.storage.toString());
    log(updatedCamera.connectivity.toString());
    log(updatedCamera.duration.toString());
    log(updatedCamera.latePolicy.toString());
    log(updatedCamera.images.toString());
    log(updatedCamera.privacyPolicy.toString());

    emit(Submitting(updatedCamera));
  }

  void _onSubmitCameraForm(
      CameraEvent event, Emitter<FormMainState> emit) async {
    emit(LoadingForm(state.camera));
    try {
       
      await Future.delayed(const Duration(seconds: 1));
      emit(Success(state.camera));
    } catch (e) {
      emit(Failure(state.camera, 'Failed to submit form: $e'));
    }
  }
}
