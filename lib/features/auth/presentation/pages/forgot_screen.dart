import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/widgets/custom_button.dart';
import 'package:serve_mate/core/utils/widgets/text_field_decoration.dart';
import 'package:serve_mate/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:serve_mate/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_event.dart';
import 'package:serve_mate/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  // Email validation logic
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Email',
                  obscureText: false,
                  hintText: "Email",
                  controller: _emailController,
                  validator: _emailValidator,
                ),
                const SizedBox(height: 20),
                BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccessState) {
                      // Show success message and navigate to sign-in screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password reset email sent!"),
                        ),
                      );
                      context.go('/sign-in');
                    } else if (state is ForgetPasswordFailState) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: CustomElevatedButton(
                        text: "RESET PASSWORD",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgetPasswordBloc>().add(
                                  ForgetPasswordEvent(
                                      email: _emailController.text),
                                );
                          }
                        },
                      ),
                    );
                  },
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
