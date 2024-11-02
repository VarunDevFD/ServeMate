import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/product/presentation/widgets/camera_videography_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/catering_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/decoration_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/dress_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/footwear_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/jewelry_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/sound_dj_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/vehicle_form.dart';
import 'package:serve_mate/features/product/presentation/widgets/venue_form.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(state.message)),
          );
        } else if (state is CategoryLoaded && state.selectedCategory != null) {
          return Scaffold(
            appBar: AppBar(
                title: Text('${state.selectedCategory!.name} Rental Form')),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _getFormForCategory(state.selectedCategory!.name),
            ).animate().fadeIn(duration: 500.ms).slideY(),
          );
        }

        // Return statement added here
        return Scaffold(
          appBar: AppBar(
            title: const Text('No category selected'),
          ),
          body: const Center(child: Text('No category selected')),
        );
      },
    );
  }

  Widget _getFormForCategory(String? category) {
    switch (category) {
      case 'Dresses':
        return const DressForm();
      case 'Vehicles':
        return const VehicleForm();
      case 'Decoration':
        return const DecorationForm();
      case 'Jewelry':
        return const JewelryForm();
      case 'Venue':
        return const VenueForm();
      case 'Catering':
        return const CateringForm();
      case 'Footwear':
        return const FootwearForm();
      case 'Cameras':
        return const CameraVideographyForm();
      case 'Sound & DJ Systems':
        return const SoundDJForm();
      default:
        return const Center(child: Text('Invalid Category'));
    }
  }
}
