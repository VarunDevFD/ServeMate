import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/usecase/add_dress_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/camera_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/decoration_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/jewelry_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/vehicle_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/venue_use_case.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    // Registering handlers for different events
    on<SubmitDressEvent>(_handleSubmitDressEvent);
    on<SubmitJewelryEvent>(_handleSubmitJewelryEvent);
    on<SubmitVenueEvent>(_handleSubmitVenueEvent);
    on<SubmitVehicleEvent>(_handleSubmitVehicleEvent);
    on<SubmitCameraEvent>(_handleSubmitCameraEvent);
    on<SubmitDecorationEvent>(_handleSubmitDecorationEvent);
  }

  Future<void> _handleSubmitDressEvent(
      SubmitDressEvent event, Emitter<ProductState> emit) async {
    final addDressUseCase = serviceLocator<AddDressUseCase>();
    emit(ProductLoadingState());
    try {
      await addDressUseCase.execute(event.dress);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _handleSubmitJewelryEvent(
      SubmitJewelryEvent event, Emitter<ProductState> emit) async {
    final addJewelryUseCase = serviceLocator<AddJewelryUseCase>();
    emit(ProductLoadingState());
    try {
      await addJewelryUseCase.execute(event.jewelry);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _handleSubmitVenueEvent(
      SubmitVenueEvent event, Emitter<ProductState> emit) async {
    final addVenueUseCase = serviceLocator<AddVenueUseCase>();
    emit(ProductLoadingState());
    try {
      await addVenueUseCase.execute(event.venue);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _handleSubmitVehicleEvent(
      SubmitVehicleEvent event, Emitter<ProductState> emit) async {
    final addVehicleUseCase = serviceLocator<AddVehicleUseCase>();
    emit(ProductLoadingState());
    try {
      await addVehicleUseCase.execute(event.vehicle);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _handleSubmitCameraEvent(
      SubmitCameraEvent event, Emitter<ProductState> emit) async {
    final addCameraUseCase = serviceLocator<AddCameraUseCase>();
    emit(ProductLoadingState());
    try {
      await addCameraUseCase.execute(event.camera);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _handleSubmitDecorationEvent(
      SubmitDecorationEvent event, Emitter<ProductState> emit) async {
    final addDecorationUseCase = serviceLocator<AddDecorationUseCase>();
    emit(ProductLoadingState());
    try {
      await addDecorationUseCase.execute(event.decoration);
      emit(ProductSuccessState());
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
