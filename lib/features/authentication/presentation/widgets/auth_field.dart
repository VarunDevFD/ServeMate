import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_event.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_state.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool isConfirmPassword;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.labelText,
    this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.isConfirmPassword = false,
  });

  String get label => labelText ?? hintText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TogglePasswordBloc, TogglePasswordState>(
        builder: (context, state) {
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: (hintText == "Password" || hintText == "Confirm Password")
            ? isConfirmPassword
                ? !state.confirmPasswordVisible
                : !state.passwordVisible
            : false,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    isConfirmPassword
                        ? (state.confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off)
                        : (state.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                  ),
                  onPressed: () {
                    if (isConfirmPassword) {
                      context
                          .read<TogglePasswordBloc>()
                          .add(ToggleConfirmPasswordVisibility());
                    } else {
                      context
                          .read<TogglePasswordBloc>()
                          .add(TogglePasswordVisibility());
                    }
                  },
                )
              : suffixIcon, // If not obscureText, use the provided suffixIcon or null
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hintText';
          }
          if (hintText == "Email") {
            String pattern = r'^[^@]+@[^@]+\.[^@]+';
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)) {
              return 'Please enter a valid $hintText';
            }
          }

          return null;
        },
      );
    });
  }
}
