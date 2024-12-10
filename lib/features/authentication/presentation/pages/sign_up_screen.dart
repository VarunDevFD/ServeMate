// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';
import 'package:serve_mate/core/utils/validation_helper.dart';
import 'package:serve_mate/core/widgets/custom_elevated_button.dart';
import 'package:serve_mate/core/widgets/custom_text_form_field.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/confirm_password_field.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/custom_divider_widget.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/password_field.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/sign_in_nav_widget.dart';

class SignUpScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  void submitCredentials(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpEvent(
          email: emailController.text,
          password: newPasswordController.text,
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: BlocConsumer<AuthBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.go('/selectCategory'); // Navigate after success
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text("Create an Account",
                            style: AppTextStyles.titleSignIn),
                        const SizedBox(height: 50),
                        _buildTextField(
                            context, nameController, 'Name', 'Enter your Name'),
                        const SizedBox(height: 10),
                        _buildTextField(
                          context,
                          emailController,
                          'Email',
                          'Enter your email',
                          validateEmail: ValidationHelper.validateEmail,
                        ),
                        const SizedBox(height: 10),
                        PasswordField(
                          newPasswordController: newPasswordController,
                          newPasswordFocusNode: newPasswordFocusNode,
                          validatePassword: ValidationHelper.validatePassword,
                        ),
                        const SizedBox(height: 10),
                        ConfirmPasswordField(
                          confirmPasswordController: confirmPasswordController,
                          confirmPasswordFocusNode: confirmPasswordFocusNode,
                          newPasswordController: newPasswordController,
                        ),
                        const SizedBox(height: 30),
                        if (state is AuthLoading)
                          const CircularProgressIndicator() // Show loading indicator
                        else
                          CustomElevatedButton(
                            text: "SIGN UP",
                            onPressed: () => submitCredentials(context),
                            backgroundColor: AppColors.primary,
                          ),
                        const SizedBox(height: 20),
                        const OrDivider(),
                        const SizedBox(height: 30),
                        const SignInNavigation(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller,
      String label, String hintText,
      {String? Function(String?)? validateEmail}) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      labelText: label,
      obscureText: false,
      validator: validateEmail ??
          (value) => value == null || value.isEmpty
              ? 'Please enter your $label'
              : null,
      onSubmitted: (_) => FocusScope.of(context).requestFocus(emailFocusNode),
    );
  }
}
