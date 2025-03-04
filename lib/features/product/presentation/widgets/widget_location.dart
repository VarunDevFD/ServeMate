// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

class LocationTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode locationFocusNode;
  final FocusNode? nextFocusNode;

  const LocationTextField({
    Key? key,
    required this.controller,
    required this.locationFocusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          controller.text = state.address;
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
        if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          focusNode: locationFocusNode,
          readOnly: true, // Prevent manual input
          decoration: InputDecoration(
            labelText: "Location",
            prefixIcon: const Icon(Icons.location_on_outlined),
            suffixIcon: IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                context.read<LocationBloc>().add(FetchLocation());
                FocusScope.of(context).requestFocus(nextFocusNode);
              },
            ),
          ),
        );
      },
    );
  }
}
