import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';

import '../bloc/form_submission_bloc/form_submission_event.dart';

class SwitchTileScreen extends StatelessWidget {
  final String categoryName;
  final FormSubmissionBloc bloc;
  const SwitchTileScreen({
    Key? key,
    required this.categoryName,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableSwitchCubit, bool>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Available for Booking'),
          value: state,
          onChanged: (bool value) {
            context.read<AvailableSwitchCubit>().toggleAvailable(value);
            bloc.add(FormUpdateEvent(categoryName, 'available', value));
          },
        );
      },
    );
  }
}
