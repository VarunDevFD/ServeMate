import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_event.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import '../cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';

// import 'package:cloudinary_url_gen/cloudinary.dart';

// void testCloudinary() {
//   final cloudinary = Cloudinary.fromCloudName(
//       cloudName: 'dwnoatc3h', apiKey: '387979586456272');
//   final url = cloudinary.image('sample').toString();
//   log(url); // Should print a valid Cloudinary URL
// }

class BottomNavBar extends StatelessWidget {
  final String formName;
  final PageController pageController;

  const BottomNavBar({
    super.key,
    required this.formName,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormSubmissionBloc>();
    final stateIndex = pageController.initialPage;

    return CurvedNavigationBar(
      index: stateIndex,
      color: AppColors.orange1,
      backgroundColor: AppColors.white,
      buttonBackgroundColor:
          stateIndex == 2 ? AppColors.green : AppColors.orange1,
      height: 60,
      animationCurve: Curves.easeInOut,
      items: [
        const Icon(Icons.home, size: 33, color: AppColors.white),
        const Icon(Icons.event_note_outlined, size: 33, color: AppColors.white),
        Icon(stateIndex == 2 ? Icons.task_alt_rounded : Icons.add,
            size: stateIndex == 2 ? 38 : 33, color: AppColors.white),
        const Icon(Icons.chat_outlined, size: 33, color: AppColors.white),
        const Icon(Icons.person, size: 33, color: AppColors.white),
      ],
      onTap: (index) {
        context.read<BottomNavCubit>().updateIndex(index);

        if (index == 2 && stateIndex == 2) {
          log(formName);
          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            switch (formName) {
              case 'cameras':
                bloc.add(CameraEvent());
                break;
              case 'Decoration':
                bloc.add(DecorationEvent());
                break;
              case 'Dresses':
                bloc.add(DressEvent());
                break;
              case 'Footwear':
                bloc.add(FootWearEvent());
                break;
              case 'Jewelry':
                bloc.add(JewelryEvent());
                break;
              case 'Sound & DJ Systems':
                bloc.add(SoundEvent());
                break;
              case 'Vehicles':
                bloc.add(VehicleEvent());
                break;
              case 'Venue':
                bloc.add(VenueEvent());
                break;
              default:
                log('Unknown form name: $formName');
            }
            formKey.currentState!.reset();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Form Submitted Successfully'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill all required fields')),
            );
          }
        }

        // Animation Implemented
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}
