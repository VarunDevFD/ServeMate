import 'package:flutter/material.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_camera_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_decoration_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_dress_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_footwear_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_jewelry_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_sound_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_vehicle_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_venue_form_widget.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getCategoryName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final categoryName = snapshot.data;

        if (categoryName == null) {
          return const Center(child: Text('Invalid Category'));
        }

        switch (categoryName) {
          case 'Cameras':
            return Cameras();
          case 'Decoration':
            return DecorationPage();
          case 'Dresses':
            return DressesPage();
          case 'Footwear':
            return FootwearPage();
          case 'Jewelry':
            return JewelryPage();
          case 'Sound & DJ Systems':
            return SoundDJPage();
          case 'Vehicles':
            return VehiclesPage();
          case 'Venue':
            return VenuePage();
          default:
            return const Center(child: Text('Invalid Category'));
        }
      },
    );
  }

  Future<String> getCategoryName() async {
    final prefs = serviceLocator<PreferencesRepository>();
    return await prefs.getDataFn() ?? ''; // Fetch categoryName from prefs
  }
}
