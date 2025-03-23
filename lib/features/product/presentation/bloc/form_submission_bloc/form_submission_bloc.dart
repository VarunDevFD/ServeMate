 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/usecase/camera_use_case.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';

class FormSubmissionBloc extends Bloc<FormSubmissionEvent, FormMainState> {
  final CameraUseCase _productRepository = serviceLocator<CameraUseCase>();
  FormSubmissionBloc()
      : super(InitialForm(Camera(
          name: '',
          model: '',
          brand: '',
          category: '',
          description: '',
          price: 0,
          sdPrice: 0,
          available: false,
          location: [''],
          phoneNumber: '',
          condition: '',
          storage: [''],
          connectivity: [''],
          duration: '',
          latePolicy: '',
          images: [''],
          privacyPolicy: false,
        ))) {
    on<UpdateField>(_onUpdateCameraField);
    on<CameraEvent>(_onSubmitCameraForm);
    on<ResetForm>(_onResetForm);
  }

  _onUpdateCameraField(UpdateField event, Emitter<FormMainState> emit) {
    Camera updatedCamera;
    if (state is UpdatedForm) {
      updatedCamera = (state as UpdatedForm).camera;
    } else if (state is InitialForm) {
      updatedCamera = (state as InitialForm).camera;
    } else {
      // Fallback (though this shouldn’t happen with your current states)
      updatedCamera = Camera();
    }
    switch (event.field) {
      case 'name':
        emit(UpdatedForm(updatedCamera.copyWith(name: event.value)));
        break;
      case 'brand':
        emit(UpdatedForm(updatedCamera.copyWith(brand: event.value)));
        break;
      case 'model':
        emit(UpdatedForm(updatedCamera.copyWith(model: event.value)));
        break;
      case 'category':
        emit(UpdatedForm(updatedCamera.copyWith(category: event.value)));
        break;
      case 'description':
        emit(UpdatedForm(updatedCamera.copyWith(description: event.value)));
        break;
      case 'price':
        emit(UpdatedForm(updatedCamera.copyWith(price: event.value)));
        break;
      case 'sdPrice':
        emit(UpdatedForm(updatedCamera.copyWith(sdPrice: event.value)));
        break;
      case 'available':
        emit(UpdatedForm(updatedCamera.copyWith(available: event.value)));
        {}
        break;
      case 'location':
        emit(UpdatedForm(updatedCamera.copyWith(location: event.value)));

        break;
      case 'phoneNumber':
        emit(UpdatedForm(updatedCamera.copyWith(phoneNumber: event.value)));

        break;
      case 'condition':
        emit(UpdatedForm(updatedCamera.copyWith(condition: event.value)));

        break;
      case 'storage':
        emit(UpdatedForm(updatedCamera.copyWith(storage: event.value)));

        break;
      case 'connectivity':
        emit(UpdatedForm(updatedCamera.copyWith(connectivity: event.value)));

        break;
      case 'duration':
        emit(UpdatedForm(updatedCamera.copyWith(duration: event.value)));

        break;
      case 'latePolicy':
        emit(UpdatedForm(updatedCamera.copyWith(latePolicy: event.value)));

        break;
      case 'images':
        emit(UpdatedForm(updatedCamera.copyWith(images: event.value)));

        break;
      case 'privacyPolicy':
        emit(UpdatedForm(updatedCamera.copyWith(privacyPolicy: event.value)));

        break;
    }
    // log(updatedCamera.name.toString());
    // log(updatedCamera.model.toString());
    // log(updatedCamera.brand.toString());
    // log(updatedCamera.category.toString());
    // log(updatedCamera.description.toString());
    // log(updatedCamera.price.toString());
    // log(updatedCamera.sdPrice.toString());
    // log(updatedCamera.available.toString());
    // log(updatedCamera.location.toString());
    // log(updatedCamera.condition.toString());
    // log(updatedCamera.storage.toString());
    // log(updatedCamera.connectivity.toString());
    // log(updatedCamera.duration.toString());
    // log(updatedCamera.latePolicy.toString());
    // log(updatedCamera.images.toString());
    // log(updatedCamera.privacyPolicy.toString());
  }

  void _onSubmitCameraForm(
      CameraEvent event, Emitter<FormMainState> emit) async {
    Camera camera;
    if (state is UpdatedForm) {
      camera = (state as UpdatedForm).camera;
    } else if (state is InitialForm) {
      camera = (state as InitialForm).camera;
    } else {
      camera = Camera();
    }

    if (camera.name?.isNotEmpty == true &&
        camera.model?.isNotEmpty == true &&
        camera.brand?.isNotEmpty == true &&
        camera.category?.isNotEmpty == true &&
        camera.description?.isNotEmpty == true &&
        camera.price != null &&
        camera.price! > 0 &&
        camera.sdPrice != null &&
        camera.sdPrice! > 0 &&
        camera.available != null &&
        camera.location?.isNotEmpty == true &&
        camera.phoneNumber?.isNotEmpty == true &&
        camera.condition?.isNotEmpty == true &&
        camera.storage?.isNotEmpty == true &&
        camera.connectivity?.isNotEmpty == true &&
        camera.duration?.isNotEmpty == true &&
        camera.latePolicy?.isNotEmpty == true &&
        camera.images?.isNotEmpty == true &&
        camera.privacyPolicy != null) {
      await _productRepository.execute(camera); // Call the use case
      emit(Success(isAnimating: true)); 
      await Future.delayed(const Duration(seconds: 5)); 
      // Reset to initial state
      emit(InitialForm(Camera(
        name: '',
        model: '',
        brand: '',
        category: '',
        description: '',
        price: 0,
        sdPrice: 0,
        available: false,
        location: [''],
        phoneNumber: '',
        condition: '',
        storage: [''],
        connectivity: [''],
        duration: '',
        latePolicy: '',
        images: [''],
        privacyPolicy: false,
      )));
    } else {
      emit(Failure('All fields are required and must be valid'));
    }
  }

  void _onResetForm(ResetForm event, Emitter<FormMainState> emit) {
    emit(InitialForm(Camera(
      name: '',
      model: '',
      brand: '',
      category: '',
      description: '',
      price: 0,
      sdPrice: 0,
      available: false,
      location: [''],
      phoneNumber: '',
      condition: '',
      storage: [''],
      connectivity: [''],
      duration: '',
      latePolicy: '',
      images: [''],
      privacyPolicy: false,
    )));
  }
}
