
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/widgets/custom_loading_animation.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/category/presentation/widgets/category_item_widget.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategorySelected) {
          context.go('/bottomNavBar');
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return  const CustomLoading();
        } else if (state is CategoryLoaded) {
          return GridView.builder(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.all(10.r),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: state.categories.length,
            itemBuilder: (BuildContext context, int index) {
              final category = state.categories[index];
              return GestureDetector(
                onTap: () {
                  _showConfirmationDialog(context, category);
                },
                child: CategoryItem(category: category),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Method to show a confirmation dialog
  Future<void> _showConfirmationDialog(
    BuildContext context,
    Category category,
  ) async {
    final pref = serviceLocator<PreferencesRepository>();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Selection'),
          content: Text('Do you want to proceed with "${category.name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                context
                    .read<CategoryBloc>()
                    .add(SelectCategoryEvent(category.name));
                Navigator.of(context).pop(true); // Confirm
                await pref.setHasSeenHome(true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
