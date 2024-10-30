import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/category/domain/entities/category.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/widgets/category_item_widget.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics:
          const ClampingScrollPhysics(), // Change to your desired scrolling behavior
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 12.0, // Horizontal space between grid items
        mainAxisSpacing: 12.0, // Vertical space between grid items
        childAspectRatio: 3 / 2, // Aspect ratio for grid items
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            context.read<CategoryBloc>().add(SelectCategory(category.name));
            context.go('/home');
          },
          child: CategoryItem(category: category),
        );
      },
    );
  }
}