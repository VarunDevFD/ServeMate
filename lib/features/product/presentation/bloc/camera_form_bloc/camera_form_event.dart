
abstract class CameraVideographyFormEvent {}

class SubmitFormEvent extends CameraVideographyFormEvent {
  final Map<String, dynamic> formData;

  SubmitFormEvent(this.formData);
}
