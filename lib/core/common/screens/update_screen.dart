 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/common/screens/venue_update_screen.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_state.dart';

import 'camera_update_screen.dart';
import 'decoration_update_screen.dart';
import 'dress_update_screen.dart';
import 'footwear_update_screen.dart';
import 'jewelry_update_screen.dart';
import 'sound_update_screen.dart';
import 'vehicle_update_screen.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<H2CategoryBloc, H2CategoryState>(
      builder: (context, state) {
        if (state is! UpdateScreen) {
          return const Scaffold(
            body: Center(child: Text('No item selected')),
          );
        }

        switch (state.name) {
          case Names.camera:
            return CameraUpdatePage(item: state.item);
          case Names.decoration:
            return DecorationUpdatePage(item: state.item);
          case Names.dress:
            return DressUpdatePage(item: state.item);
          case Names.footwear:
            return FootwearUpdatePage(item: state.item);
          case Names.jewelry:
            return JewelryUpdatePage(item: state.item);
          case Names.sound:
            return SoundUpdatePage(item: state.item);
          case Names.vehicle:
            return VehicleUpdatePage(item: state.item);
          case Names.venue:
            return VenueUpdatePage(item: state.item);
          default: 
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(child: Text('Invalid category')),
            );
        }
      },
    );
  }
}
