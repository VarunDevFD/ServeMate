import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/image_handler.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/entities/venue.dart';
import 'package:serve_mate/features/product/doamin/usecase/add_dress_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/camera_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/decoration_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/footwear_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/jewelry_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/sound_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/vehicle_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/venue_use_case.dart';

import 'form_submission_event.dart';
import 'form_submission_state.dart';

class FormSubmissionBloc extends Bloc<FormSubEvent, FormSubState> {
  // Use case map
  final Map<String, dynamic> _useCases = {
    Names.camera: serviceLocator<CameraUseCase>(),
    Names.decoration: serviceLocator<DecorationUseCase>(),
    Names.dress: serviceLocator<DressUseCase>(),
    Names.footwear: serviceLocator<FootwearUseCase>(),
    Names.jewelry: serviceLocator<JewelryUseCase>(),
    Names.sound: serviceLocator<SoundUseCase>(),
    Names.vehicle: serviceLocator<VehicleUseCase>(),
    Names.venue: serviceLocator<VenueUseCase>(),
  };

  // Entity map
  final Map<String, dynamic> _entities = {
    Names.camera: Camera.empty(),
    Names.decoration: Decoration.empty(),
    Names.dress: Dress.empty(),
    Names.footwear: Footwear.empty(),
    Names.jewelry: Jewelry.empty(),
    Names.sound: Sound.empty(),
    Names.vehicle: Vehicle.empty(),
    Names.venue: Venue.empty(),
  };

  final ImageHandler _imageHandler;

  FormSubmissionBloc()
      : _imageHandler = ImageHandler(),
        super(FormInitial({
          Names.camera: Camera.empty(),
          Names.decoration: Decoration.empty(),
          Names.dress: Dress.empty(),
          Names.footwear: Footwear.empty(),
          Names.jewelry: Jewelry.empty(),
          Names.sound: Sound.empty(),
          Names.vehicle: Vehicle.empty(),
          Names.venue: Venue.empty(),
        })) {
    on<FormUpdateEvent>(_onUpdateEvent);
    on<FormSubmitEvent>(_onSubmitEvent);
    on<FormResetEvent>(_onResetEvent);
  }

  void _onUpdateEvent(FormUpdateEvent event, Emitter<FormSubState> emit) {
    final entityType = event.entityType;
    var entity = _entities[entityType];
    final updatedEntity = _updateEntityField(entity, event.field, event.value);
    _entities[entityType] = updatedEntity;
    emit(FormInitial(Map.from(_entities)));
  }

  Future<void> _onSubmitEvent(
      FormSubmitEvent event, Emitter<FormSubState> emit) async {
    final type = event.entityType;
    emit(FormLoading(type));
    try {
      var entity = _entities[type];
      if (entity == null) {
        emit(FormError('Invalid entity type: $type'));
        return;
      }
      // Process images if they exist
      if (entity.images != null && entity.images.isNotEmpty) {
        List<String> uploadedImageUrls =
            await _imageHandler.processAndUploadImages(entity.images);

        // Update entity with uploaded URLs
        entity = entity.copyWith(images: uploadedImageUrls);
        _entities[type] = entity; // Update the stored entity
      }
      await _useCases[type].execute(entity);
      _entities[type] = _resetEntity(type);
      await Future.delayed(const Duration(seconds: 3));
      emit(FormSuccess(type, _entities[type]));
    } catch (e) {
      emit(FormError('Submission failed: $e'));
    }
  }

  void _onResetEvent(FormResetEvent event, Emitter<FormSubState> emit) {
    _entities.forEach((type, _) => _entities[type] = _resetEntity(type));
    emit(FormInitial(Map.from(_entities)));
  }

  dynamic _updateEntityField(dynamic entity, String field, dynamic value) {
    // Assumes all entities have a copyWith method with named parameters
    switch (field) {
      case 'name':
        return entity.copyWith(name: value);
      case 'model':
        return entity.copyWith(model: value);
      case 'brand':
        return entity.copyWith(brand: value);
      case 'category':
        return entity.copyWith(category: value);
      case 'description':
        return entity.copyWith(description: value);
      case 'price':
        return entity.copyWith(price: value);
      case 'sdPrice':
        return entity.copyWith(sdPrice: value);
      case 'available':
        return entity.copyWith(available: value);
      case 'location':
        return entity.copyWith(location: value);
      case 'phoneNumber':
        return entity.copyWith(phoneNumber: value);
      case 'condition':
        return entity.copyWith(condition: value);
      case 'storage':
        return entity.copyWith(storage: value);
      case 'connectivity':
        return entity.copyWith(connectivity: value);
      case 'duration':
        return entity.copyWith(duration: value);
      case 'latePolicy':
        return entity.copyWith(latePolicy: value);
      case 'images':
        return entity.copyWith(images: value);
      case 'privacyPolicy':
        return entity.copyWith(privacyPolicy: value);
      case 'decorCategory':
        return entity.copyWith(decorCategory: value);
      case 'decorStyles':
        return entity.copyWith(decorStyles: value);
      case 'gender':
        return entity.copyWith(gender: value);
      case 'type':
        return entity.copyWith(type: value);
      case 'size':
        return entity.copyWith(size: value);
      case 'color':
        return entity.copyWith(color: value);
      case 'material':
        return entity.copyWith(material: value);
      case 'quantity':
        return entity.copyWith(quantity: value);
      case 'equipmentTypes':
        return entity.copyWith(equipmentTypes: value);
      case 'vehicleType':
        return entity.copyWith(vehicleType: value);
      case 'rentalPrice':
        return entity.copyWith(rentalPrice: value);
      case 'seatCapacity':
        return entity.copyWith(seatCapacity: value);
      case 'registrationNumber':
        return entity.copyWith(registrationNumber: value);
      case 'fuelType':
        return entity.copyWith(fuelType: value);
      case 'transmission':
        return entity.copyWith(transmission: value);
      case 'facilities':
        return entity.copyWith(facilities: value);
      case 'availability':
        return entity.copyWith(availability: value);
      case 'venueType':
        return entity.copyWith(venueType: value);
      case 'capacity':
        return entity.copyWith(capacity: value);
      default:
        return entity; // No update if field is unknown
    }
  }

  dynamic _resetEntity(String type) {
    switch (type) {
      case 'camera':
        return Camera.empty();
      case 'decoration':
        return Decoration.empty();
      case 'dress':
        return Dress.empty();
      case 'footwear':
        return Footwear.empty();
      case 'jewelry':
        return Jewelry.empty();
      case 'sound':
        return Sound.empty();
      case 'vehicle':
        return Vehicle.empty();
      case Names.venue:
        return Venue.empty();
      default:
        throw Exception('Unknown entity type');
    }
  }
}
// 200
