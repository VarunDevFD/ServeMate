import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_state.dart';
import 'package:serve_mate/features/home/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
import '../bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final PageController pageController;

  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationState) {
          currentIndex = state.pageIndex;
        }

        return CurvedNavigationBar(
          index: currentIndex,
          color: AppColors.orange1,
          backgroundColor: AppColors.white,
          buttonBackgroundColor: AppColors.orange1,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          items: const <Widget>[
            Icon(Icons.home, size: 33, color: AppColors.white),
            Icon(Icons.event_note_outlined, size: 33, color: AppColors.white),
            Icon(Icons.add, size: 33, color: AppColors.white),
            Icon(Icons.chat_outlined, size: 33, color: AppColors.white),
            Icon(Icons.person, size: 33, color: AppColors.white),
          ],
          onTap: (index) {
            if (index == 2 && currentIndex == 2) {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                if (imagesNotifier.value.isNotEmpty) {
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
            } else {
              // Update the Bloc and animate the page view to the selected index
              context.read<NavigationBloc>().add(PageTappedEvent(index));
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        );
      },
    );
  }
}
