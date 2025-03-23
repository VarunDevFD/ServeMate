import 'package:serve_mate/features/product/doamin/entities/camera.dart';

abstract class FormMainState {}
 
class InitialForm extends FormMainState {
  final Camera camera;

  InitialForm(this.camera);
}

class UpdatedForm extends FormMainState {
  final Camera camera;
  UpdatedForm(this.camera);
}

class Success extends FormMainState {
  final bool isAnimating; // Indicates if animation is active
  Success({this.isAnimating = true});
}

class Failure extends FormMainState {
  final String message;
  Failure(this.message);
}
