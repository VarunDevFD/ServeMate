import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';

class GenderSelectionWidget extends StatelessWidget {
  final  Function(String? value) onValue;
  const GenderSelectionWidget({
    Key? key,
    required this.onValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormSubBloc, FormSubState>(
      builder: (context, state) {
        final bloc = context.read<FormSubBloc>();
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
                  groupValue: state.gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) {
                    onValue(value);
                    bloc.add(GenderChanged(value!));
                  },
                ),
                const Text('Male'),
                SizedBox(width: 16.w),
                Radio<String>(
                  value: 'Female',
                  groupValue: state.gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) {
                    onValue(value);
                    bloc.add(GenderChanged(value!));
                  },
                ),
                const Text('Female'),
                SizedBox(width: 16.w),
                Radio<String>(
                  value: 'Unisex',
                  groupValue: state.gender,
                  activeColor: Colors.orange[800],
                  onChanged: (String? value) {
                    onValue(value);
                    bloc.add(GenderChanged(value!));
                  },
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
