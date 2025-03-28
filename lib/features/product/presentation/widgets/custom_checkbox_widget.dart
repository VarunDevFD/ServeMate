import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final void Function(bool?)? onChanged;
  const TermsAndConditionsScreen({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: BlocBuilder<AvailableSwitchCubit, bool>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Terms and Conditions'),
                        content: const Text(
                          'Here are the detailed terms and conditions:\n\n'
                          '1. You must be at least 18 years old to use this service.\n'
                          '2. You agree to abide by all applicable laws and regulations.\n'
                          '3. We reserve the right to modify these terms at any time.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'I accept the terms and conditions',
                  style: TextStyle(
                    color: AppColors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Checkbox(
                value: state,
                onChanged: onChanged,
              ),
            ],
          );
        },
      ),
    );
  }
}
