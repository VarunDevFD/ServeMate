import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/category/domain/entities/category.dart';
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
      padding: const EdgeInsets.all(10.0),
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
          onTap: () {
            _handleCategorySelection(context, category);
          },
          child: CategoryItem(category: category),
        );
      },
    );
  }

  void _handleCategorySelection(BuildContext context, Category category) async {
    final shouldNavigate = await _showConfirmationDialog(context, category);

    // Check if the widget is still mounted
    if (shouldNavigate && context.mounted) {
      context.read<CategoryBloc>().add(SelectCategoryEvent(category));
      context.go('/bottomNavBar');
    }
  }

  /// Method to show a confirmation dialog
  Future<bool> _showConfirmationDialog(
      BuildContext context, Category category) async {
    return await showDialog<bool>(
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
                    Navigator.of(context).pop(true); // Confirm
                    await pref.setHasSeenHome(true);
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
