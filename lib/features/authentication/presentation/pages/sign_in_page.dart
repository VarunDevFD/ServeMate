import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/snackbar_utils.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_button.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_field.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_google_button.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_divider_widget.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_forgot_password_bn_widget.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  SignInPage({super.key});

  void submitCredentials(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validation checks
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      SnackBarUtils.showSnackBar(
        context,
        'Please enter a valid email address.',
      );
      return;
    }

    if (password.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Password cannot be empty.');
      return;
    }

    // Dispatch login event to AuthBloc
    BlocProvider.of<AuthBloc>(context).add(
      SignInEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            LoadingDialog.show(context);
          } else if (state is Authenticated) {
            LoadingDialog.hide(context);
            Navigator.of(context).maybePop(); // Remove the dialog
            context.go('/selectCategory'); // Navigate to home on success
          } else if (state is AuthError) {
            LoadingDialog.hide(context);
            Navigator.of(context).maybePop(); // Remove loading indicator
            Future.delayed(
              const Duration(milliseconds: 200),
              () => SnackBarUtils.showSnackBar(context, state.message),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _buildWelcomeText(),
                  SizedBox(height: 30.h),
                  AuthField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  SizedBox(height: 16.h),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const ForgotPasswordBn(),
                  SizedBox(height: 5.h),
                  AuthButton(
                    buttonText: "Sign In",
                    onPressed: () async {
                      submitCredentials(context);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 26.h),
                  const OrDivider(),
                  SizedBox(height: 20.h),
                  const AuthGoogleButton(),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => context.go('/sign-up'),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: ' Sign Up',
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
        ),
      ),
    );
  }
}

Widget _buildWelcomeText() {
  return const Column(
    children: [
      Text('Let\'s Sign You In', style: TextStyle(fontSize: 30)),
      Text('Welcome back.', style: TextStyle(fontSize: 18)),
      Text('You\'ve been missed!', style: TextStyle(fontSize: 18)),
    ],
  );
}
