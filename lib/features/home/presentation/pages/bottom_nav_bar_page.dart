import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_state.dart';
import 'package:serve_mate/features/home/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:serve_mate/features/home/presentation/pages/home_page.dart';
import 'package:serve_mate/features/product/presentation/controllers/form_controller.dart';
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
    return BlocBuilder<NavigationBloc, NavState>(
      builder: (context, state) {
        final currentIndex = state is NavigationState ? state.pageIndex : 0;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _appBarTitles[currentIndex],
              style: TextStyle(
                color: currentIndex == 0 ? AppColors.orange : AppColors.black,
                fontWeight:
                    currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
                fontStyle:
                    currentIndex == 0 ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            elevation: 0,
            // actions: currentIndex == 2
            //     ? [
            //         IconButton(
            //           icon: const Icon(Icons.check),
            //           onPressed: () {
            //             // context.go('/temp');
            //             if (formKey.currentState != null &&
            //                 formKey.currentState!.validate()) {
            //               log('Form submitted successfully!');
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 const SnackBar(
            //                     content: Text('Form Submitted Successfully')),
            //               );
            //             } else {
            //               log('Form validation failed!');
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 const SnackBar(
            //                     content:
            //                         Text('Please fill all required fields')),
            //               );
            //             }
            //           },
            //         ),
            //       ]
            //     : null,
            // backgroundColor: AppColors.dimOrange,
          ),
          body: PageView(
            controller: _pageController,
            children: const [
              HomePage(),
              ListPage(),
              AddPage(),
              NotificationsPage(),
              ProfilePage(),
            ],
            onPageChanged: (index) {
              context.read<NavigationBloc>().add(PageChangedEvent(index));
            },
          ),
          extendBody: true,
          bottomNavigationBar: BottomNavBar(
            pageController: _pageController,
          ),
        );
      },
    );
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
