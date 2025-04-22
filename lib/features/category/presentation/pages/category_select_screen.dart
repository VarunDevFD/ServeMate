import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/category/presentation/widgets/cateory_grid_widget.dart';
import 'package:serve_mate/features/category/presentation/widgets/header_widget.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Header(),
              Expanded(child: CategoryGrid()),
            ],
          ),
        ),
      ),
    );
  }
}
