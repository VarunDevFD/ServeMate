import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/constants.dart'; 
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
      case Names.camera:
        return Cameras();
      case Names.decoration:
        return DecorationPage();
      case  Names.dress:
        return DressesPage();
      case  Names.footwear:
        return FootwearPage();
      case  Names.jewelry:
        return JewelryPage();
      case  Names.sound:
        return SoundDJPage();
      case  Names.vehicle:
        return VehiclesPage();
      case  Names.venue:
        return VenuePage();
      default:
        return const Center(child: Text('Invalid Category'));
    }
  }
}
