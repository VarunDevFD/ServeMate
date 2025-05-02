import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';

class SwitchTileScreen extends StatelessWidget {
  const SwitchTileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableSwitchCubit, bool>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Available for Booking'),
          value: state,
          onChanged: (bool value) {
            context.read<AvailableSwitchCubit>().toggleAvailable(value);
          },
        );
      },
    );
  }
}
