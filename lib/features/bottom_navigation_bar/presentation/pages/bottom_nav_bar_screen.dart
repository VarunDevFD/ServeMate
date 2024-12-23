import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_event.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_state.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:serve_mate/features/product/presentation/pages/home_page_screen.dart';
import 'package:serve_mate/features/product/presentation/pages/product_add_screen.dart';

class BottomNavigationBar extends StatelessWidget {
  final String? categoryName;
  final PageController _pageController = PageController(initialPage: 0);

  BottomNavigationBar({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              const HomePage(),
              const ListPage(),
              AddPage(),
              const NotificationsPage(),
              const ProfilePage(),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
