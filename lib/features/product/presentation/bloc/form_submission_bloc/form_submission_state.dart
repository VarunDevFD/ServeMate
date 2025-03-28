import 'package:serve_mate/features/product/doamin/entities/camera.dart';
import 'package:serve_mate/features/product/doamin/entities/decoration.dart';
import 'package:serve_mate/features/product/doamin/entities/dress_entity.dart';

abstract class FormMainState {}

class InitialForm extends FormMainState {
  final Camera? camera;
  final Decoration? decoration;
  final Dress? dress;

  InitialForm({this.camera, this.decoration, this.dress});
}

class UpdatedForm extends FormMainState {
  final Camera camera;
  UpdatedForm(this.camera);
}

class UpdatedDecorationForm extends FormMainState {
  final Decoration decoration;
  UpdatedDecorationForm(this.decoration);
}

class UpdatedDressForm extends FormMainState {
  final Dress dress;
  UpdatedDressForm(this.dress);
}

class CameraSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  CameraSuccess({this.isAnimating = true});
}
class DecorationSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  DecorationSuccess({this.isAnimating = true});
}
class DressSuccess extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  DressSuccess({this.isAnimating = true});
}
 

class Failure extends FormMainState {
  final String message;
  Failure(this.message);
}
