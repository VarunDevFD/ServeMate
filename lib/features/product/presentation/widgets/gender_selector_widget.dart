import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';

class GenderSelectionWidget extends StatelessWidget {
  const GenderSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (context, state) {
        final bloc = context.read<CommonBloc>();
        final String gender;
        if (state is InitialState) {
          gender = '';
        } else if (state is SuccessState) {
          gender = state.type;
        } else if (state is ErrorState) {
          gender = '';
        } else {
          gender = '';
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) => bloc.add(GenderChanged(value!)),
                ),
                const Text('Male'),
                SizedBox(width: 16.w),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) => bloc.add(GenderChanged(value!)),
                ),
                const Text('Female'),
                SizedBox(width: 16.w),
                Radio<String>(
                  value: 'Unisex',
                  groupValue: gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) => bloc.add(GenderChanged(value!)),
                ),
                const Text('Unisex'),
              ],
            ),
          ],
        );
      },
    );
  }
}
