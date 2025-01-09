import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_event.dart';

class ProfileSignOutWidget extends StatelessWidget {
  const ProfileSignOutWidget({super.key});
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final pref = serviceLocator<PreferencesRepository>();
        const String title = "Sign Out";
        return AlertDialog(
          title: const Text(title),
          content: const Text('Are you sure you want to $title?'),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.balck4),
              ),
            ),
            TextButton(
              onPressed: () {
                pref.setHasSeenHome(false);
                context.read<NavigationBloc>().add(RestBottomNavBarEvent());
                context.pop();
                context.go('/sign-in');
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: AppColors.red),
      title: const Text('Sign Out'),
      onTap: () => _showSignOutDialog(context),
    );
  }
}
