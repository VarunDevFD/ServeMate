import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';

class SignInNavigation extends StatelessWidget {
  const SignInNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        GestureDetector(
          onTap: () => context.go('/sign-in'),
          child: Text(
            ' Sign In',
            style: TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
