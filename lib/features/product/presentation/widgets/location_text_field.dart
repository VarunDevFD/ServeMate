import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this for Bloc
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/input_decoration.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

Widget buildLocationTextField(
    BuildContext context, String hint, locationController) {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
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
                locationController(state.placeName);
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
