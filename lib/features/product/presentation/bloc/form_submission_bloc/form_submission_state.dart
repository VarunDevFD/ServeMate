import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';
import 'package:serve_mate/features/product/doamin/entities/footwear.dart';

abstract class FormMainState {}

class InitialForm extends FormMainState {
  final Camera? camera;
  final Decoration? decoration;
  final Dress? dress;
  final Footwear? footwear;

  InitialForm({this.camera, this.decoration, this.dress, this.footwear});
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

