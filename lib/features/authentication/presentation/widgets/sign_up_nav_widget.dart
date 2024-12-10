import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class SignUpNavigation extends StatelessWidget {
  const SignUpNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        GestureDetector(
          onTap: () => context.go('/sign-up'),
          child: Text(
            ' Sign Up',
            style: TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
