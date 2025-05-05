import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/common/screens/camera_details.dart';
import 'package:serve_mate/core/common/screens/decoration_details.dart';
import 'package:serve_mate/core/common/screens/dress_details.dart';
import 'package:serve_mate/core/common/screens/footwear_details.dart';
import 'package:serve_mate/core/common/screens/jewelry_details.dart';
import 'package:serve_mate/core/common/screens/sound_details.dart';
import 'package:serve_mate/core/common/screens/vehicle_details.dart';
import 'package:serve_mate/core/common/screens/venue_details.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_state.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<H2CategoryBloc, H2CategoryState>(
      builder: (context, state) {
        Widget content;
        String titleLarge;
        if (state is CameraCategoryLoaded && state.selectedItem != null) {
          content = CameraDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is DecorationCategoryLoaded &&
            state.selectedItem != null) {
          content = DecorationDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is DressCategoryLoaded && state.selectedItem != null) {
          content = DressDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is FootwearCategoryLoaded &&
            state.selectedItem != null) {
          content = FootwearDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is JewelryCategoryLoaded &&
            state.selectedItem != null) {
          content = JewelryDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name!;
        } else if (state is SoundCategoryLoaded && state.selectedItem != null) {
          content = SoundDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is VehiclesCategoryLoaded &&
            state.selectedItem != null) {
          content = VehicleDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else if (state is VenuesCategoryLoaded &&
            state.selectedItem != null) {
          content = VenueDetails(item: state.selectedItem!);
          titleLarge = state.selectedItem!.name;
        } else {
          content = const Center(child: Text('No item selected'));
          titleLarge = 'Error';
        }

        return Scaffold(
          appBar: AppBar(title: Text(titleLarge)),
          body: content,
        );
      },
    );
  }
}
