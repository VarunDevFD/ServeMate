import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

import '../bloc/dress_bloc/dress_bloc.dart';
import '../bloc/dress_bloc/dress_event.dart';
import '../bloc/dress_bloc/dress_state.dart';

class CustomGenderWidget extends StatelessWidget {
  final ValueChanged<TextEditingController> onGenderSelected;
  const CustomGenderWidget({super.key, required this.onGenderSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DressFormBloc, DressFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Men'),
                  value: 'Men',
                  groupValue: state.selectedGender,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    final controller = TextEditingController(text: value);
                    context
                        .read<DressFormBloc>()
                        .add(GenderSelected(controller.text));
                    onGenderSelected(controller);
                  },
                  secondary: Icon(Icons.man_2_rounded,
                      color: state.selectedGender == 'Men'
                          ? AppColors.primary
                          : AppColors.grey),
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Girls'),
                  value: 'Girls',
                  groupValue: state.selectedGender,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    final controller = TextEditingController(text: value);

                    context.read<DressFormBloc>().add(GenderSelected(controller.text));
                    onGenderSelected(controller);
                  },
                  secondary: Icon(Icons.girl_rounded,
                      color: state.selectedGender == 'Girls'
                          ? AppColors.primary
                          : AppColors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
