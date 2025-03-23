

abstract class CameraVideographyFormState {}

class CameraVideographyFormInitial extends CameraVideographyFormState {}

class CameraVideographyFormSuccess extends CameraVideographyFormState {}

class CameraVideographyFormFailure extends CameraVideographyFormState {
  final String errorMessage;

  CameraVideographyFormFailure(this.errorMessage);
}
