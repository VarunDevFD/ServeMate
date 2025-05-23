import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/constants_list.dart';
import 'package:serve_mate/core/widgets/custom_loading_animation.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/category_list/presentation/pages/main_screen.dart';
import 'package:serve_mate/features/naviaton/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:serve_mate/features/naviaton/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:serve_mate/features/home/presentation/pages/home_page.dart';
import 'package:serve_mate/features/product/presentation/pages/add_product_page.dart';
import 'package:serve_mate/features/profile/presentation/pages/profile_page.dart';

class BottomNavigationBar extends StatelessWidget {
  BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoryName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final formName = snapshot.data ?? "Invalid Category";
          return BlocListener<BottomNavCubit, int>(
            listener: (context, index) {
              if (index == 1) {
                // Trigger H2LoadCategories event when index is 1
                context.read<H2CategoryBloc>().add(H2LoadCategories());
              }
            },
            child: BlocBuilder<BottomNavCubit, int>(builder: (context, index) {
              final pageController = PageController(initialPage: index);
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    index == 2 ? "$formName Form" : appBarTitles[index],
                    style: TextStyle(
                      color: index == 0 ? AppColors.orange : AppColors.black,
                      fontWeight:
                          index == 0 ? FontWeight.bold : FontWeight.normal,
                      fontStyle:
                          index == 0 ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.black,
                  elevation: 0,
                ),
                body: PageView(
                  controller: pageController,
                  onPageChanged: (index) =>
                      context.read<BottomNavCubit>().updateIndex(index),
                  children: [
                    const HomePage(),
                    ListPage(type: formName),
                    AddPage(categoryName: formName),
                    const NotificationsPage(),
                    const ProfilePage(),
                  ],
                ),
                extendBody: true,
                bottomNavigationBar: BottomNavBar(
                  formName: formName.toLowerCase(),
                  pageController: pageController,
                ),
              );
            }),
          );
        });
  }

  Future<String> getCategoryName() async {
    final prefs = serviceLocator<PreferencesRepository>();
    return await prefs.getCategoryName() ?? ''; // Fetch categoryName from prefs
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications Page'));
  }
}
