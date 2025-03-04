import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/home/presentation/widgets/search_field_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_category_data_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_image_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(top: 2.h, right: 1.w, left: 1.w, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimatedSearchBar(),
            SizedBox(height: 20.h),
            ImageCarousel(),
            SizedBox(height: 20.h),
            const HomeCategoryDataWidget(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
