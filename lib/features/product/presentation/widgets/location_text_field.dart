import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this for Bloc
import 'package:serve_mate/core/utils/theme/app_colors.dart';
import 'package:serve_mate/core/utils/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

Widget buildLocationTextField(BuildContext context, String hint) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return TextField(
          cursorColor: AppColors.balck1,
          decoration: InputDecorations.defaultDecoration(
            // Display place name if available, otherwise show the default hint
            hintText: state.placeName!.isNotEmpty
                ? state.placeName
                : (state.currentLocation ?? hint),
            suffixIcon: IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                // Trigger the CurrentLocation event to fetch the current location
                BlocProvider.of<LocationBloc>(context)
                    .add(FetchCurrentLocation());
              },
            ),
            errorText: state.locationError,
          ),
          readOnly:
              true, // The text field is read-only since it's just displaying the location
        );
      },
    ),
  );
}
