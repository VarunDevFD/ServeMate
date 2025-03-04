import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/profile/presentation/bloc/temp/temp_bloc.dart';
import 'package:serve_mate/features/profile/presentation/bloc/temp/temp_state.dart';

import 'temp_button.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController description = TextEditingController();

    return BlocProvider(
      create: (_) => FormTempBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Form Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FormTempBloc, FormTempState>(
            builder: (context, state) {
              final bloc = context.read<FormTempBloc>();

              return Form(
                key: formKey,
                child: Column(
                  children: [
                    _buildTextFormField(
                      label: 'Name',
                      controller: name,
                    ),
                    _buildTextFormField(
                      label: 'Email',
                      controller: email,
                    ),
                    _buildTextFormField(
                      label: 'Phone',
                      controller: phone,
                    ),
                    _buildTextFormField(
                      label: 'Address',
                      controller: address,
                    ),
                    _buildTextFormField(
                      label: 'Description',
                      controller: description,
                      isOptional: true,
                    ),
                    const SizedBox(height: 20),
                    SubmitButton(
                      formKey: formKey,
                      bloc: bloc,
                      controllers: {
                        'name': name,
                        'email': email,
                        'phone': phone,
                        'address': address,
                        'description': description,
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    bool isOptional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
        ),
        validator: (value) {
          if (isOptional && (value?.isEmpty ?? true)) {
            return null; // Don't validate if empty for optional field
          }
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
