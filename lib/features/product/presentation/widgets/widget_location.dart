import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/common_snackbar.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_event.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_state.dart';

class LocationTextField extends StatelessWidget {
  LocationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationError) {
          AppSnackBar.show(
            context,
            content: state.message,
            backgroundColor: AppColors.red,
          );
        }
      },
      builder: (context, state) {
        final location = context.read<LocationBloc>();
        final TextEditingController currentLocation = TextEditingController();

        if (state is LocationInitial) {
          currentLocation.text = "Choose the location";
        } else if (state is LocationLoaded) {
          currentLocation.text = state.location[0];
        } else if (state is LocationError) {
          currentLocation.text = state.message;
        } else {
          currentLocation.text =
              "Unknown address"; // or handle other states as needed
        }
        return TextFormField(
          controller: currentLocation,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Location",
            prefixIcon: const Icon(Icons.location_on_outlined),
            suffixIcon: IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () => location.add(FetchLocation()),
            ),
          ),
        );
      },
    );
  }
}
