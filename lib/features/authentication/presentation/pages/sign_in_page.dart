import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
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
  final loginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  SignInPage({super.key});

  void submitCredentials(
      BuildContext context, Function onSuccess, Function onError) {
    if (loginKey.currentState?.validate() == true) {
      final password = passwordController.text;

      // Password validation
      if (password.length < 6) {
        onError("Password must be at least 6 characters long.");
        return;
      }

      final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)');
      if (!regex.hasMatch(password)) {
        onError("Password must contain at least one letter and one number.");
        return;
      }

      // Dispatch the AuthBloc event
      BlocProvider.of<AuthBloc>(context).add(
        SignInEvent(
          email: emailController.text,
          password: password,
          role: "ServiceProvider",
        ),
      );

      // Handle async completion after event is dispatched
      _handleAuthSuccess(context, onSuccess, onError);
    }
  }

  // Async completion handler
  Future<void> _handleAuthSuccess(
      BuildContext context, Function onSuccess, Function onError) async {
    try {
      final preferences = serviceLocator<PreferencesRepository>();
      final hasSeenHome = await preferences.hasSeenHome();

      if (!context.mounted) return;

      // Perform navigation based on the result
      if (!hasSeenHome) {
        onSuccess(() => context.go('/bottomNavBar'));
      } else {
        onSuccess(() => context.go('/selectCategory'));
      }
    } catch (e) {
      onError("An error occurred while navigating.");
    }
  }

  // Show error message
  void showErrorDialog(BuildContext context, String message) {
    DialogUtils.showErrorMessage(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(
              const Duration(milliseconds: 20),
              () => LoadingDialog.show(context),
            );
          } else if (state is AuthError) {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => DialogUtils.showErrorMessage(context, state.message),
            );
          }
          LoadingDialog.hide(context);
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: loginKey,
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
                        submitCredentials(
                          context,
                          (navigationCallback) {
                            // If success, navigate using callback
                            navigationCallback();
                          },
                          (errorMessage) {
                            // If error occurs, show error dialog
                            showErrorDialog(context, errorMessage);
                          },
                        );
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
