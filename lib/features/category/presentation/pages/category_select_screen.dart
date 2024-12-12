import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/category/presentation/widgets/cateory_grid_widget.dart';
import 'package:serve_mate/features/category/presentation/widgets/header_widget.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Header(),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      return CategoryGrid(categories: state.categories);
                    } else if (state is CategoryError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
