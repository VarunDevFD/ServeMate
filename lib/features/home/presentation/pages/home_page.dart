import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_category_data_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_image_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/search_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              const AnimatedSearchBar(),
              SizedBox(height: 20.h),
              ImageCarousel(),
              SizedBox(height: 20.h),
              const HomeCategoryDataWidget(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
