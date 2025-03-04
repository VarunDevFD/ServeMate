import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_event.dart';

class AuthGoogleButton extends StatelessWidget {
  const AuthGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.background,
        padding: EdgeInsets.symmetric(vertical: 10.h),
      ),
      onPressed: () => context.read<AuthBloc>().add(GoogleSignInEvent()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            child: Image.asset('assets/images/google.png'),
          ),
          SizedBox(width: 10.w),
          const Text('Sign in with Google'),
        ],
      ),
    );
  }
}
