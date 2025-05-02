import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/naviaton/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';

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
    // final bloc = context.read<AddProductBloc>();
    final stateIndex = pageController.initialPage;

    return CurvedNavigationBar(
      index: stateIndex,
      color: AppColors.orange1,
      backgroundColor: AppColors.white,
      buttonBackgroundColor: AppColors.orange1,
      height: 60,
      animationCurve: Curves.easeInOut,
      items: const [
        Icon(Icons.home, size: 33, color: AppColors.white),
        Icon(Icons.event_note_outlined, size: 33, color: AppColors.white),
        Icon(Icons.add, size: 33, color: AppColors.white),
        Icon(Icons.chat_outlined, size: 33, color: AppColors.white),
        Icon(Icons.person, size: 33, color: AppColors.white),
      ],
      onTap: (index) {
        context.read<BottomNavCubit>().updateIndex(index);

        // if (index == 2 && stateIndex == 2) {
        //   log(formName);
        //   if (formKey.currentState != null &&
        //       formKey.currentState!.validate()) {
        //     bloc.add(FormSubmitEvent(formName));
        //     formKey.currentState!.reset();
        //     log("Form submitted successfully Done");
        //   } else {
        //     AppSnackBar.show(
        //       context,
        //       content: 'Please fill all required fields',
        //       backgroundColor: AppColors.red,
        //     );
        //   }
        // }
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
// 120
