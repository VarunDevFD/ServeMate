import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class ProfileDeleteAccountWidget extends StatelessWidget {
  const ProfileDeleteAccountWidget({super.key});

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final pref = serviceLocator<PreferencesRepository>();

        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.balck4),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                pref.setHasSeenHome(false);
                pref.clearCategoryName();
                pref.clearAllPref(); // Delete all pref
                context.push('/welcome');
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
      leading: Icon(Icons.delete, color: AppColors.red),
      title: const Text('Delete Account'),
      onTap: () => _showDeleteAccountDialog(context),
    );
  }
}
