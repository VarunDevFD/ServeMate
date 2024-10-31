import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_event.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_state.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';

class BottomNavigationBar extends StatelessWidget {
  BottomNavigationBar({super.key});
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: const [
              HomePage(),
              SearchPage(),
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
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page'));
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Page'));
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Add Page'));
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
