import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_button.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_field.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_divider_widget.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';

class SignUpPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  SignUpPage({super.key});

  void submitCredentials(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      final newPassword = newPasswordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (newPassword.length < 6) {
        FocusScope.of(context).unfocus();
        // Show error if password is too short
        DialogUtils.showErrorMessage(
          context,
          "Please ensure your password is at least 6 characters long. Thank you!",
        );
        return;
      }

      // Check if the password contains at least one letter and one number
      final RegExp regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)');
      if (!regex.hasMatch(newPassword)) {
        FocusScope.of(context).unfocus();
        // Show error if password doesn't contain both letters and numbers
        DialogUtils.showErrorMessage(
          context,
          "Your password must contain at least one letter and one number.",
        );
        return;
      }

      if (newPassword != confirmPassword) {
        FocusScope.of(context).unfocus();
        // Show error if passwords do not match
        DialogUtils.showErrorMessage(
          context,
          "Oops! Your passwords don't match. Please try again.",
        );
        return;
      } else {
        // If validation passes, proceed with sign-up event
        BlocProvider.of<AuthBloc>(context).add(
          SignUpEvent(
            name: nameController.text,
            email: emailController.text,
            password: newPasswordController.text,
          ),
        );
        context.go('/selectCategory'); // Navigate after success
      }
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: BlocConsumer<AuthBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                LoadingDialog.show(context);
              } else if (state is Authenticated) {
                LoadingDialog.hide(context);
              } else if (state is AuthError) {
                LoadingDialog.hide(context);
                DialogUtils.showErrorMessage(context, state.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Text("Create an Account",
                            style: AppTextStyles.titleSignIn),
                        SizedBox(height: 30.h),
                        AuthField(
                          hintText: "Name",
                          controller: nameController,
                        ),
                        SizedBox(height: 16.h),
                        AuthField(
                          hintText: "Email",
                          controller: emailController,
                        ),
                        SizedBox(height: 16.h),
                        AuthField(
                          hintText: "Password",
                          controller: newPasswordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 16.h),
                        AuthField(
                          hintText: "Confirm Password",
                          controller: confirmPasswordController,
                          obscureText: true,
                          isConfirmPassword: true,
                        ),
                        SizedBox(height: 26.h),
                        AuthButton(
                          buttonText: "Sign Up",
                          onPressed: () => submitCredentials(context),
                        ),
                        SizedBox(height: 26.h),
                        const OrDivider(),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () => context.go('/sign-in'),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: ' Sign In',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppColors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
}
