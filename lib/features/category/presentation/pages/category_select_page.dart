import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/authentication/presentation/widgets/loading_animation_widget.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/category/presentation/widgets/cateory_grid_widget.dart';
import 'package:serve_mate/features/category/presentation/widgets/header_widget.dart';

class CategorySelectionPage extends StatelessWidget {
  const CategorySelectionPage({super.key});

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
                child: BlocConsumer<CategoryBloc, CategoryState>(
                  listener: (context, state) {
                    if (state is CategoryInitial) {
                      LoadingDialog.show(context);
                    } else if (state is CategoryLoaded ||
                        state is CategoryError) {
                      LoadingDialog.hide(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      if (state.categories != null) {
                        return CategoryGrid(categories: state.categories!);
                      } else {
                        return const Center(
                            child: Text('No categories found.'));
                      }
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
