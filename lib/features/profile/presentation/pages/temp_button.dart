import 'package:flutter/material.dart';
import 'package:serve_mate/features/profile/presentation/bloc/temp/model.dart';
import 'package:serve_mate/features/profile/presentation/bloc/temp/temp_bloc.dart';
import 'package:serve_mate/features/profile/presentation/bloc/temp/temp_event.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FormTempBloc bloc;
  final Map<String, TextEditingController> controllers;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.bloc,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          // If the form is valid, submit the form and reset the errors
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully!')),
          );
          final data = FormModel(
            name: controllers['name']!.text,
            email: controllers['email']!.text,
            phone: controllers['phone']!.text,
            address: controllers['address']!.text,
            description: controllers['description']!.text,
          );

          bloc.add(FormFieldChanged(data));
          formKey.currentState?.reset();
          controllers.forEach((_, controller) => controller.clear());
        } else {
          // If the form is not valid, show an error snack bar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill out all required fields!')),
          );
        }
      },
      child: const Text('Submit'),
    );
  }
}