import 'package:serve_mate/features/product/doamin/entities/camera.dart';

abstract class FormMainState {
  final Camera camera;

  FormMainState(this.camera);
}

class InitialForm extends FormMainState {
  InitialForm(Camera camera) : super(camera);
}

class LoadingForm extends FormMainState {
  LoadingForm(Camera camera) : super(camera);
}

class Submitting extends FormMainState {
  Submitting(Camera camera) : super(camera);
}

class Success extends FormMainState {
  Success(Camera camera) : super(camera);
}

class Failure extends FormMainState {
  final String message;

  Failure(Camera camera, this.message) : super(camera);
}
