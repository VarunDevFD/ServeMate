import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:serve_mate/features/product/data/models/camera_model.dart';
import 'item_event.dart';
import 'item_state.dart';

class FormSubBloc extends Bloc<FormSubEvent, FormSubState> {
  FormSubBloc() : super(FormSubState(cameraData: CameraModel())) {
    // on<FormFieldChanged>(addCameraData);
    on<ToggleAvailableEvent>(addAvailable);
    on<FilterExpantionEvent>(filterExpnaded);
    on<AvailableCheckbox>(addAvailableCheckbox);
    on<GenderChanged>(genderChanged);
  }

/*
  void addCameraData(
    FormFieldChanged event,
    Emitter<FormSubState> emit,
  ) async {
    final data = state.cameraData.copyWith(
      name: event.key == 'name' ? event.value : state.cameraData.name,
      price: event.key == 'price' ? event.value : state.cameraData.price,
      sdPrice: event.key == 'sdPrice' ? event.value : state.cameraData.sdPrice,
      location:
          event.key == 'location' ? event.value : state.cameraData.location,
      images: event.key == 'images' ? event.value : state.cameraData.images,
      notes: event.key == 'notes' ? event.value : state.cameraData.notes,
      equipmentType: event.key == 'equipmentType'
          ? event.value
          : state.cameraData.equipmentType,
      brand: event.key == 'brand' ? event.value : state.cameraData.brand,
      condition:
          event.key == 'condition' ? event.value : state.cameraData.condition,
      date: event.key == 'date' ? event.value : state.cameraData.date,
      accessories: event.key == 'accessories'
          ? event.value
          : state.cameraData.accessories,
      damage: event.key == 'damage' ? event.value : state.cameraData.damage,
    );
    emit(state.copyWith(cameraData: data));

    log('Updated Camera Data: ${data.equipmentType} ${data.brand} ${data.condition} ${data.date}');

    // Upload images first
    // final uploadedImageUrls = await _uploadImages(event.images);

    // Prepare camera data for database
    // final cameraData = {
    //   'name': event.name,
    //   'price': event.price,
    //   'securityDeposit': event.securityDeposit,
    //   'location': event.location,
    //   'notes': event.notes,
    //   'equipmentType': event.equipmentType,
    //   'brandModel': event.brandModel,
    //   'condition': event.condition,
    //   'dateAdded': event.dateAdded,
    //   'accessories': event.accessories,
    //   'images': uploadedImageUrls,
    //   'damage': event.damage ?? '',
    // };

    // Save to database
    // await _cameraRepository.addCamera(cameraData);
  }
  */

  void addAvailable(ToggleAvailableEvent event, Emitter<FormSubState> emit) {
    log('ToggleAvailability: ${event.isAvailable}');
    emit(state.copyWith(isAvailable: event.isAvailable));
  }

  void addAvailableCheckbox(
      AvailableCheckbox event, Emitter<FormSubState> emit) {
    emit(state.copyWith(isAvailableCheckbox: event.isAvailableCheckbox));
  }

  void genderChanged(GenderChanged event, Emitter<FormSubState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void filterExpnaded(
    FilterExpantionEvent event,
    Emitter<FormSubState> emit,
  ) {
    final updateExpansionStates =
        Map<String, bool>.from(state.isFilterChipExpanded);
    updateExpansionStates[event.widgetId] =
        !(updateExpansionStates[event.widgetId] ?? false);
    emit(state.copyWith(isFilterChipExpanded: updateExpansionStates));
  }
}
