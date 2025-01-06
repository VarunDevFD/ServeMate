
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/widgets/category_item_widget.dart';

class CategoryGrid extends StatelessWidget {
  final PreferencesRepository pref = serviceLocator<PreferencesRepository>();
  final List<Category> categories;

  CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      LoadingDialog.show(context);
    }
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.all(10.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: ScreenUtil().screenWidth > 600 ? 4 / 3 : 3 / 2,
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

    if (shouldNavigate == true) {
      context.read<CategoryBloc>().add(SelectCategoryEvent(category));
      context.go('/bottomNavBar');
      await pref.setHasSeenHome(true);
      await pref.setHasSeenUserId([category]);
    }
  }

  Future<bool?> _showConfirmationDialog(BuildContext context, String category) {
    const TextStyle colorWhite = TextStyle(color: AppColors.white);
    return showDialog<bool>(
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Do you want to proceed with "$category"?\nIf you choose one category from here, only use that in this app.',
                style: colorWhite,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: colorWhite),
              onPressed: () {
                context.pop(false); // Return false for cancel
              },
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
                context.pop(true); // Return true for OK
                context.read<CategoryBloc>().add(SelectCategoryEvent(category));
                context.go('/bottomNavBar');

                // Save Preferences
                await pref.setHasSeenHome(true);
                await pref.setHasSeenUserId([category]);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
