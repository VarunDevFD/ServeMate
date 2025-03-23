abstract class FormSubmissionEvent {}

class UpdateField extends FormSubmissionEvent {
  final String field;
  final dynamic value;

  UpdateField(this.field, this.value);
}

class CameraEvent extends FormSubmissionEvent {}
