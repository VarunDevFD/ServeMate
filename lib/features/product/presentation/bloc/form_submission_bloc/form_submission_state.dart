import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';
import 'package:serve_mate/features/product/doamin/entities/jewelry.dart';
import 'package:serve_mate/features/product/doamin/entities/sound.dart';
import 'package:serve_mate/features/product/doamin/entities/vehicle.dart';
import 'package:serve_mate/features/product/doamin/entities/venue.dart';

abstract class FormMainState {}

class InitialForm extends FormMainState {
  final Camera? camera;
  final Decoration? decoration;
  final Dress? dress;
  final Footwear? footwear;
  final Jewelry? jewelry;
  final Sound? sound;
  final Vehicle? vehicle;
  final Venue? venue;
  


  InitialForm({
    this.camera,
    this.decoration,
    this.dress,
    this.footwear,
    this.jewelry,
    this.sound,
    this.vehicle,
    this.venue,
  });
}

class Failure extends FormMainState {
  final String message;
  Failure(this.message);
}

// Camera States
class UpdatedForm extends FormMainState {
  final Camera camera;
  UpdatedForm(this.camera);
}

class CameraSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  CameraSuccess({this.isAnimating = true});
}

// Decoration States
class UpdatedDecorationForm extends FormMainState {
  final Decoration decoration;
  UpdatedDecorationForm(this.decoration);
}

class DecorationSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  DecorationSuccess({this.isAnimating = true});
}

// Dress States
class UpdatedDressForm extends FormMainState {
  final Dress dress;
  UpdatedDressForm(this.dress);
}

class DressSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  DressSuccess({this.isAnimating = false});
}

// FootWear States
class UpdatedFootWearForm extends FormMainState {
  final Footwear footwear;
  UpdatedFootWearForm(this.footwear);
}

class FootWearSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  FootWearSuccess({this.isAnimating = true});
}

// Jewelry States
class UpdatedJewelryForm extends FormMainState {
  final Jewelry jewelry;
  UpdatedJewelryForm(this.jewelry);
}

class JewelrySuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  JewelrySuccess({this.isAnimating = true});
}

// Sound States
class UpdatedSoundForm extends FormMainState {
  final Sound sound;
  UpdatedSoundForm(this.sound);
}

class SoundSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  SoundSuccess({this.isAnimating = true});
}

// Vehicle States
class UpdatedVehicleForm extends FormMainState {
  final Vehicle vehicle;
  UpdatedVehicleForm(this.vehicle);
}

class VehicleSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  VehicleSuccess({this.isAnimating = true});
}


// Venue States
class UpdatedVenueForm extends FormMainState {
  final Venue  venue;
  UpdatedVenueForm(this.venue);
}

class VenueSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  VenueSuccess({this.isAnimating = true});
}

