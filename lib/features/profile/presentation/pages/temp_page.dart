import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/temp/temp_bloc.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Form Validation with BLoC')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextField(fieldName: 'Name', hintText: 'Enter Field Name'),
              MyTextField(fieldName: 'Age', hintText: 'Enter Field 2'),
              MyTextField(fieldName: 'Brand', hintText: 'Enter Field 2'),
              MyTextField(fieldName: 'Model', hintText: 'Enter Field 2'),
              MyTextField(fieldName: 'Size', hintText: 'Enter Field 2'),
              MyTextField(fieldName: 'Height', hintText: 'Enter Field 2'),
              Spacer(),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;

  const MyTextField({Key? key, required this.fieldName, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            errorText: (state.fields[fieldName]?.isEmpty ?? true)
                ? 'Field is required'
                : null,
          ),
          controller: TextEditingController(
            text: state.fields[fieldName],
          ),
          onChanged: (value) {
            context.read<FormBloc>().add(TextFieldChanged(fieldName, value));
          },
        );
      },
    );
  }
}


//Botton
class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<FormBloc>().add(ValidateForm());

            if (state.isValid) {
              // All fields are valid; proceed with submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form is valid!')),
              );

              // Reset the form
              context.read<FormBloc>().add(ResetForm());
            } else {
              // Display error messages
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please fill all required fields')),
              );
            }
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}

