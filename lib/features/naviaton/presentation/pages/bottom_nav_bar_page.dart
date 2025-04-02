import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/naviaton/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:serve_mate/features/naviaton/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:serve_mate/features/home/presentation/pages/home_page.dart';
import 'package:serve_mate/features/product/presentation/pages/add_product_page.dart';
import 'package:serve_mate/features/profile/presentation/pages/profile_page.dart';

final ValueNotifier<List<File>> imagesNotifier = ValueNotifier<List<File>>([]);

class BottomNavigationBar extends StatelessWidget {
  final String? categoryName;
  final PageController _pageController = PageController(initialPage: 0);

  BottomNavigationBar({super.key, this.categoryName});
  final List<String> _appBarTitles = [
    "SERVEMATE",
    "List",
    "Add List",
    "Notifications",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoryName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final formName = snapshot.data ?? "Invalid Category";
          return BlocBuilder<BottomNavCubit, int>(
            builder: (context, index) => Scaffold(
              appBar: AppBar(
                title: Text(
                  _appBarTitles[index],
                  style: TextStyle(
                    color: index == 0 ? AppColors.orange : AppColors.black,
                    fontWeight:
                        index == 0 ? FontWeight.bold : FontWeight.normal,
                    fontStyle: index == 0 ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                elevation: 0,
              ),
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<BottomNavCubit>().updateIndex(index);
                },
                children: [
                  const HomePage(),
                  const ListPage(),
                  AddPage(categoryName: formName),
                  const NotificationsPage(),
                  const ProfilePage(),
                ],
              ),
              extendBody: true,
              bottomNavigationBar: BottomNavBar(
                // currentIndex: index,
                formName: formName,
                pageController: _pageController,
              ),
            ),
          );
        });
  }

  Future<String> getCategoryName() async {
    final prefs = serviceLocator<PreferencesRepository>();
    return await prefs.getDataFn() ?? ''; // Fetch categoryName from prefs
  }
}

// Individual pages
class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Page'));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications Page'));
  }
}
