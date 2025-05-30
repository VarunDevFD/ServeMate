import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/dialog_utils.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_state.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_button.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/auth_field.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';

class ForgotPasswordpage extends StatelessWidget {
  final _emailController = TextEditingController();

  submitBtn(BuildContext context) {
    if (_emailController.text.isEmpty) {
      return DialogUtils.showInfoMessage(
        context,
        'Please enter your Email',
      );
    } else {
      String pattern = r'^[^@]+@[^@]+\.[^@]+';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(_emailController.text)) {
        return DialogUtils.showInfoMessage(
          context,
          'Please enter a valid Email',
        );
      } else {
        // context.read<ForgetPasswordBloc>().add(
        //       SendPasswordResetEmail(email: _emailController.text),
        //     );
      }
    }
  }

  ForgotPasswordpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pushReplacement('/sign-in'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            AuthField(
              hintText: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: 20.h),
            BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  // Show success message and navigate to sign-in screen
                  DialogUtils.showSuccessMessage(
                    context,
                    'Password reset email sent!',
                  );

                  context.go('/sign-in');
                } else if (state is ForgetPasswordFailure) {
                  // Show error message
                  DialogUtils.showErrorMessage(context, state.error.message);
                }
              },
              builder: (context, state) {
                if (state is ForgetPasswordLoading) {
                  LoadingDialog.show(context);
                } else {
                  LoadingDialog.hide(context);
                }
                return Center(
                  child: AuthButton(
                    onPressed: () {
                      submitBtn(context);
                      FocusScope.of(context).unfocus();
                    },
                    buttonText: "Rest Password",
                  ),
                );
              },
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
