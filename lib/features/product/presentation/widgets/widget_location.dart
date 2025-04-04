import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

class LocationTextField extends StatelessWidget {
  final dynamic onFieldSubmitted;
  final TextEditingController locationController;

  LocationTextField({
    Key? key,
    required this.locationController,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          locationController.text = state.location[0];
          onFieldSubmitted(state.location);
        }
        if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: locationController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Location", 
            prefixIcon: const Icon(Icons.location_on_outlined),
            suffixIcon: IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () =>
                  context.read<LocationBloc>().add(FetchLocation()),
            ),
          ),
        );
      },
    );
  }
}
