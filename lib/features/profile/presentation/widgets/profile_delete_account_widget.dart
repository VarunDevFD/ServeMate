import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/check_box_selection/category_selection.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/profile/domain/usecase/get_user_details.dart';

class ProfileDeleteAccountWidget extends StatelessWidget {
  final pref = serviceLocator<PreferencesRepository>();

  ProfileDeleteAccountWidget({super.key});

  void _showDeleteAccountDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

  void showCategoryDialog(BuildContext context, List<String> categories) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Select Your Category"),
          content: SizedBox(
            width: double.maxFinite,
            child: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final name = categories[index];
                    final isSelected = state.selectedCategories.contains(name);

                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(name),
                      onChanged: (value) {
                        context.read<CategorySelectionBloc>().add(
                              ToggleCategory(name, value ?? false),
                            );
                      },
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                // final selected = context
                //     .read<CategorySelectionBloc>()
                //     .state
                //     .selectedCategories;

                // You can now save the selected categories to preferences or backend

                Navigator.pop(context);
                _showDeleteAccountDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final getUserDetails = serviceLocator<GetUserDetails>();
    return ListTile(
        leading: Icon(Icons.delete, color: AppColors.red),
        title: const Text('Delete Account'),
        onTap: () async {
          final uid = await pref.getUserId();
          final categories = await getUserDetails.list(uid);
          showCategoryDialog(context, categories);
        });
  }
}
