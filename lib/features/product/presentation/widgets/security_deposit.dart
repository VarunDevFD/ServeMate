import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_event.dart';

class SecurityDepositField extends StatelessWidget {
  const SecurityDepositField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        context
            .read<DressFormBloc>()
            .add(SecurityDepositChanged(double.tryParse(value) ?? 0));
      },
      decoration:
          InputDecorations.defaultDecoration(hintText: 'Security Deposit'),
    );
  }
}
