 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_state.dart';

class SwitchTileScreen extends StatelessWidget {
  const SwitchTileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormSubBloc, FormSubState>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Available for Booking'),
          value: state.isAvailable,
          onChanged: (bool value) {
            context.read<FormSubBloc>().add(ToggleAvailableEvent(value));
          },
        );
      },
    );
  }
}
