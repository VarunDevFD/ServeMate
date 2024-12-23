import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/widgets/category_item_widget.dart';

class CategoryGrid extends StatelessWidget {
  final pref = serviceLocator<PreferencesRepository>();
  final List<Category> categories;

  CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.all(10.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 3 / 2,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () => _handleCategorySelection(context, category.name),
          child: CategoryItem(category: category),
        );
      },
    );
  }

  void _handleCategorySelection(BuildContext context, String category) async {
    final shouldNavigate = await _showConfirmationDialog(context, category);

    if (shouldNavigate && context.mounted) {
      context.read<CategoryBloc>().add(SelectCategoryEvent(category));
      context.go('/bottomNavBar', extra: category);
      await pref.setHasSeenHome(true);
    }
  }

  /// Method to show a confirmation dialog
  Future<bool> _showConfirmationDialog(
    BuildContext context,
    String category,
  ) async {
    const TextStyle colorWhite = TextStyle(color: AppColors.white);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.orange4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              title: const Text(
                'Confirm Selection',
                style: colorWhite,
              ),
              content: Text(
                'Do you want to proceed with "$category"?\n If you choose one category form here only use that in this app',
                style: colorWhite,
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel', style: colorWhite),
                  // onPressed: () => SystemNavigator.pop(),
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      context.pop();
                    } else {
                      log('Cannot pop the last page in the stack');
                    }
                  }, // Cancel
                  // onPressed: () => context.pop(false), // Cancel
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    fixedSize: Size(50.w, 25.h),
                  ),
                  onPressed: () async {
                    context.pop(true); // Confirm
                    // await pref.setHasSeenHome(true);
                    await pref.setHasSeenUserId([category]);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed without an action
  }
}
