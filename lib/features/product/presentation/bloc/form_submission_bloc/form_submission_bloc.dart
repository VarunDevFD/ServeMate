import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/usecase/add_dress_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/camera_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/decoration_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/footwear_use_case.dart';
import 'package:serve_mate/features/product/doamin/usecase/sound_use_case.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';

final Camera initialCamera = Camera(
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
);
final Decoration initialDecoration = Decoration(
  name: '',
  decorCategory: [''],
  decorStyles: [''],
  description: '',
  price: 0,
  sdPrice: 0,
  available: false,
  location: [''],
  phoneNumber: '',
  duration: '',
  images: [''],
  privacyPolicy: false,
);

class FormSubmissionBloc extends Bloc<FormSubmissionEvent, FormMainState> {
  final CameraUseCase _productRepository = serviceLocator<CameraUseCase>();
  final DecorationUseCase _decorationRepository =
      serviceLocator<DecorationUseCase>();
  final DressUseCase _dressRepository = serviceLocator<DressUseCase>();
  final FootwearUseCase _footwearRepository = serviceLocator<FootwearUseCase>();
  final SoundUseCase _soundRepository = serviceLocator<SoundUseCase>();

  Camera _camera;
  Decoration _decoration;
  Dress _dress;
  Footwear _footwear;
  Jewelry _jewelry;
  Sound _sound;

  FormSubmissionBloc()
      : _camera = initialCamera,
        _decoration = initialDecoration,
        _dress = Dress.empty(),
        _footwear = Footwear.empty(),
        _jewelry = Jewelry.empty(),
        _sound = Sound.empty(),
        super(InitialForm()) {
    // Field Listeners
    on<UpdateField>(_onUpdateCameraField);
    on<DecorationUpdateField>(_onUpdateDecorationField);
    on<DressUpdateField>(_onUpdateDressField);
    on<FootWearUpdateField>(_onUpdateFootWearField);
    on<JewelryUpdateField>(_onUpdateJewelryField);
    on<SoundUpdateField>(_onUpdateSoundField);

    // Form Submission Listeners
    on<CameraEvent>(_onSubmitCameraForm);
    on<DecorationEvent>(_onSubmitDecorationForm);
    on<DressEvent>(_onSubmitDressForm);
    on<FootWearEvent>(_onSubmitFootWearForm);
    on<JewelryEvent>(_onSubmitJewelryForm);
    on<SoundEvent>(_onSubmitSoundForm);

    on<ResetForm>(onResetForm);
  }

  _onUpdateCameraField(UpdateField event, Emitter<FormMainState> emit) {
    final updates = {
      'name': () => _camera.copyWith(name: event.value),
      'model': () => _camera.copyWith(model: event.value),
      'brand': () => _camera.copyWith(brand: event.value),
      'category': () => _camera.copyWith(category: event.value),
      'description': () => _camera.copyWith(description: event.value),
      'price': () => _camera.copyWith(price: event.value),
      'sdPrice': () => _camera.copyWith(sdPrice: event.value),
      'available': () => _camera.copyWith(available: event.value),
      'location': () => _camera.copyWith(location: event.value),
      'phoneNumber': () => _camera.copyWith(phoneNumber: event.value),
      'condition': () => _camera.copyWith(condition: event.value),
      'storage': () => _camera.copyWith(storage: event.value),
      'connectivity': () => _camera.copyWith(connectivity: event.value),
      'duration': () => _camera.copyWith(duration: event.value),
      'latePolicy': () => _camera.copyWith(latePolicy: event.value),
      'images': () => _camera.copyWith(images: event.value),
      'privacyPolicy': () => _camera.copyWith(privacyPolicy: event.value),
    };

    if (updates.containsKey(event.field)) {
      _camera = updates[event.field]!();
      emit(UpdatedForm(_camera));
    }
  }

  _onUpdateDecorationField(
      DecorationUpdateField event, Emitter<FormMainState> emit) {
    final updatesDecoration = {
      'name': () => _decoration.copyWith(name: event.value),
      'decorCategory': () => _decoration.copyWith(decorCategory: event.value),
      'decorStyles': () => _decoration.copyWith(decorStyles: event.value),
      'description': () => _decoration.copyWith(description: event.value),
      'price': () => _decoration.copyWith(price: event.value),
      'sdPrice': () => _decoration.copyWith(sdPrice: event.value),
      'available': () => _decoration.copyWith(available: event.value),
      'location': () => _decoration.copyWith(location: event.value),
      'phoneNumber': () => _decoration.copyWith(phoneNumber: event.value),
      'duration': () => _decoration.copyWith(duration: event.value),
      'images': () => _decoration.copyWith(images: event.value),
      'privacyPolicy': () => _decoration.copyWith(privacyPolicy: event.value),
    };

    if (updatesDecoration.containsKey(event.field)) {
      _decoration = updatesDecoration[event.field]!();
      emit(UpdatedDecorationForm(_decoration));
    }
  }

  _onUpdateDressField(DressUpdateField event, Emitter<FormMainState> emit) {
    final data = {
      'name': () => _dress.copyWith(name: event.value),
      'gender': () => _dress.copyWith(gender: event.value),
      'type': () => _dress.copyWith(type: event.value),
      'size': () => _dress.copyWith(size: event.value),
      'color': () => _dress.copyWith(color: event.value),
      'material': () => _dress.copyWith(material: event.value),
      'brand': () => _dress.copyWith(brand: event.value),
      'duration': () => _dress.copyWith(duration: event.value),
      'price': () => _dress.copyWith(price: event.value),
      'sdPrice': () => _dress.copyWith(sdPrice: event.value),
      'condition': () => _dress.copyWith(condition: event.value),
      'location': () => _dress.copyWith(location: event.value),
      'phoneNumber': () => _dress.copyWith(phoneNumber: event.value),
      'images': () => _dress.copyWith(images: event.value),
      'privacyPolicy': () => _dress.copyWith(privacyPolicy: event.value),
      'description': () => _dress.copyWith(description: event.value),
    };

    if (data.containsKey(event.field)) {
      _dress = data[event.field]!();
      emit(UpdatedDressForm(_dress));
    }
  }

  _onUpdateFootWearField(
      FootWearUpdateField event, Emitter<FormMainState> emit) {
    final data = {
      'name': () => _footwear.copyWith(name: event.value),
      'price': () => _footwear.copyWith(price: event.value),
      'sdPrice': () => _footwear.copyWith(sdPrice: event.value),
      'location': () => _footwear.copyWith(location: event.value),
      'images': () => _footwear.copyWith(images: event.value),
      'description': () => _footwear.copyWith(description: event.value),
      'brand': () => _footwear.copyWith(brand: event.value),
      'condition': () => _footwear.copyWith(condition: event.value),
      'size': () => _footwear.copyWith(size: event.value),
      'color': () => _footwear.copyWith(color: event.value),
      'category': () => _footwear.copyWith(category: event.value),
      'available': () => _footwear.copyWith(isAvailable: event.value),
    };

    if (data.containsKey(event.field)) {
      _footwear = data[event.field]!();
      emit(UpdatedFootWearForm(_footwear));
    }
  }

  _onUpdateJewelryField(JewelryUpdateField event, Emitter<FormMainState> emit) {
    final data = {
      'name': () => _jewelry.copyWith(name: event.value),
      'price': () => _jewelry.copyWith(price: event.value),
      'securityDeposit': () => _jewelry.copyWith(securityDeposit: event.value),
      'location': () => _jewelry.copyWith(location: event.value),
      'images': () => _jewelry.copyWith(images: event.value),
      'description': () => _jewelry.copyWith(description: event.value),
      'type': () => _jewelry.copyWith(type: event.value),
      'material': () => _jewelry.copyWith(material: event.value),
      'quantity': () => _jewelry.copyWith(quantity: event.value),
      'condition': () => _jewelry.copyWith(condition: event.value),
      'brand': () => _jewelry.copyWith(brand: event.value),
      'size': () => _jewelry.copyWith(size: event.value),
      'color': () => _jewelry.copyWith(color: event.value),
      'available': () => _jewelry.copyWith(isAvailable: event.value),
    };

    if (data.containsKey(event.field)) {
      _jewelry = data[event.field]!();
      emit(UpdatedJewelryForm(_jewelry));
    }
  }

  _onUpdateSoundField(SoundUpdateField event, Emitter<FormMainState> emit) {
    final data = {
      'name': () => _sound.copyWith(name: event.value),
      'category': () => _sound.copyWith(category: event.value),
      'equipmentTypes': () => _sound.copyWith(equipmentTypes: event.value),
      'description': () => _sound.copyWith(description: event.value),
      'isAvailable': () => _sound.copyWith(isAvailable: event.value),
      'price': () => _sound.copyWith(price: event.value),
      'securityDeposit': () => _sound.copyWith(securityDeposit: event.value),
      'location': () => _sound.copyWith(location: event.value),
      'images': () => _sound.copyWith(images: event.value),
      'privacyPolicy': () => _sound.copyWith(privacyPolicy: event.value),
    };

    if (data.containsKey(event.field)) {
      _sound = data[event.field]!();
      emit(UpdatedSoundForm(_sound));
    }
  }

  void _onSubmitCameraForm(
      CameraEvent event, Emitter<FormMainState> emit) async {
    emit(CameraSuccess(isAnimating: true)); // Show processing
    await _productRepository.execute(_camera); // Submit to repository
    await Future.delayed(const Duration(seconds: 5)); // Simulate delay
    resetCamera(emit); // Reset after success
  }

  void _onSubmitDecorationForm(
      DecorationEvent event, Emitter<FormMainState> emit) async {
    emit(DecorationSuccess(isAnimating: true)); // Show processing
    try {
      await Future.delayed(const Duration(seconds: 5));
      await _decorationRepository.execute(_decoration);
      resetDedcoration(emit); // Reset after success
    } catch (e) {
      emit(Failure('Submission failed: $e'));
    }
  }

  void _onSubmitDressForm(DressEvent event, Emitter<FormMainState> emit) async {
    emit(DressSuccess(isAnimating: true));
    try {
      await Future.delayed(const Duration(seconds: 5));
      log("Bloc DressUseCase: ${_dress.name.toString()}");

      await _dressRepository.execute(_dress);
      resetDedcoration(emit); // Reset after success
    } catch (e) {
      emit(Failure('Submission failed: $e'));
    }
  }

  void _onSubmitFootWearForm(
      FootWearEvent event, Emitter<FormMainState> emit) async {
    emit(FootWearSuccess());
    try {
      await Future.delayed(const Duration(seconds: 5));
      log("Bloc DressUseCase: ${_dress.name.toString()}");

      await _footwearRepository.execute(_footwear);
      resetDedcoration(emit); // Reset after success
    } catch (e) {
      emit(Failure('Submission failed: $e'));
    }
  }

  void _onSubmitJewelryForm(
      JewelryEvent event, Emitter<FormMainState> emit) async {
    emit(JewelrySuccess());
    try {
      await Future.delayed(const Duration(seconds: 5));
      log("Bloc DressUseCase: ${_dress.name.toString()}");

      await _footwearRepository.execute(_footwear);
      resetJewelry(emit); // Reset after success
    } catch (e) {
      emit(Failure('Submission failed: $e'));
    }
  }

  void _onSubmitSoundForm(SoundEvent event, Emitter<FormMainState> emit) async {
    emit(SoundSuccess());
    try {
      await Future.delayed(const Duration(seconds: 5));

      await _soundRepository.execute(_sound);

      resetSound(emit);
    } catch (e) {
      emit(Failure('Submission failed: $e'));
    }
  }

  void onResetForm(ResetForm event, Emitter<FormMainState> emit) {
    resetCamera(emit);
    resetDedcoration(emit);
    resetDress(emit);
    resetJewelry(emit);
  }

  // Helper to reset camera state
  void resetCamera(Emitter<FormMainState> emit) {
    _camera = initialCamera;
    _decoration = initialDecoration;
    emit(InitialForm(camera: _camera));
  }

  void resetDedcoration(Emitter<FormMainState> emit) {
    _decoration = initialDecoration;
    emit(InitialForm(decoration: _decoration));
  }

  void resetDress(Emitter<FormMainState> emit) {
    _dress = Dress.empty();
    emit(InitialForm(dress: _dress));
  }

  void resetJewelry(Emitter<FormMainState> emit) {
    _jewelry = Jewelry.empty();
    emit(InitialForm(jewelry: _jewelry));
  }

  void resetSound(Emitter<FormMainState> emit) {
    _sound = Sound.empty();
    emit(InitialForm(sound: _sound));
  }
}
