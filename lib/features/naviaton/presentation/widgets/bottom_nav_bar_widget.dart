import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/naviaton/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/home/presentation/widgets/form_submission_btn.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_state.dart';
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
  final int currentIndex;
  final String formName;
  final PageController pageController;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.formName,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormSubmissionBloc, FormMainState>(
      listener: (context, state) {
        if (state is Success) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Form successfuly saved!")));
        } else if (state is Failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final bloc = context.read<FormSubmissionBloc>();
        return CurvedNavigationBar(
          index: currentIndex,
          color: AppColors.orange1,
          backgroundColor: AppColors.white,
          buttonBackgroundColor:
              currentIndex == 2 ? AppColors.green : AppColors.orange1,
          height: 60,
          animationDuration: const Duration(milliseconds: 500),
          animationCurve: Curves.easeInOut,
          items: [
            const Icon(Icons.home, size: 33, color: AppColors.white),
            const Icon(Icons.event_note_outlined,
                size: 33, color: AppColors.white),
            Icon(currentIndex == 2 ? Icons.task_alt_rounded : Icons.add,
                size: currentIndex == 2 ? 38 : 33, color: AppColors.white),
            const Icon(Icons.chat_outlined, size: 33, color: AppColors.white),
            const Icon(Icons.person, size: 33, color: AppColors.white),
          ],
          onTap: (index) {
            if (index == 2 && currentIndex == 2) {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                if (imagesNotifier.value.isNotEmpty) {
                  submissionForm(formName: formName, bloc: bloc);
                  log('Form submitted successfully!');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Form Submitted Successfully'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill up Image')),
                  );
                }
              } else {
                log('Form validation failed!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please fill all required fields')),
                );
              }
            }

            // Animation Implemented
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeInOut,
            );
            context.read<BottomNavCubit>().updateIndex(index);
          },
        );
      },
    );
  }
}
