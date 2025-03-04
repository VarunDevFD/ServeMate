abstract class FormSubEvent {
  const FormSubEvent();
}

// class FormFieldChanged extends FormSubEvent {
//   final String key;
//   final dynamic value;

//   const FormFieldChanged({required this.key, required this.value});
// }

class ToggleAvailableEvent extends FormSubEvent {
  final bool isAvailable;
  ToggleAvailableEvent(this.isAvailable);
}

class FilterExpantionEvent extends FormSubEvent {
  final String widgetId;
  const FilterExpantionEvent(this.widgetId);
}

class AvailableCheckbox extends FormSubEvent {
  final bool isAvailableCheckbox;
  const AvailableCheckbox(this.isAvailableCheckbox);
}

class GenderChanged extends FormSubEvent {
  final String gender;
  const GenderChanged(this.gender);
}

class CameraSubmit extends FormSubEvent {}

class FormSubmitted extends FormSubEvent {}

class FormReset extends FormSubEvent {}
