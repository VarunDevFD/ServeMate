

import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_form_event.dart';
import 'camera_form_state.dart';


class CameraVideographyFormBloc
    extends Bloc<CameraVideographyFormEvent, CameraVideographyFormState> {
  CameraVideographyFormBloc() : super(CameraVideographyFormInitial());

  Stream<CameraVideographyFormState> mapEventToState(
    CameraVideographyFormEvent event,
  ) async* {
    if (event is SubmitFormEvent) {
      // Handle form validation here
      if (_validateForm(event.formData)) {
        yield CameraVideographyFormSuccess();
      } else {
        yield CameraVideographyFormFailure("Validation failed");
      }
    }
  }

  bool _validateForm(Map<String, dynamic> formData) {
    // Perform custom validation logic
    // Example: Check if the fields are empty or have invalid values
    return formData["name"].isNotEmpty &&
        formData["rentalPrice"].isNotEmpty &&
        formData["securityDeposit"].isNotEmpty;
  }
}
