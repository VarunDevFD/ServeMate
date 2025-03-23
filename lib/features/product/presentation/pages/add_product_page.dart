 import 'package:flutter/material.dart';
 
import 'package:serve_mate/features/product/presentation/widgets/add_camera_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_decoration_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_dress_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_footwear_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_jewelry_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_sound_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_vehicle_form_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/add_venue_form_widget.dart';

class AddPage extends StatelessWidget {
  final String categoryName;

  const AddPage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
