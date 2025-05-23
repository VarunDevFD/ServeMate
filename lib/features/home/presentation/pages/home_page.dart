import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/widgets/sponsors_widget.dart';
import 'package:serve_mate/features/home/presentation/widgets/category_session_widget.dart';
import 'package:serve_mate/features/home/presentation/widgets/search_field_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_image_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(top: 2.h, right: 1.w, left: 1.w, bottom: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedSearchBar(),
              SizedBox(height: 20.h),
              ImageCarousel(),
              SizedBox(height: 20.h),
              FadeInUp(child: const SessionCategorys()),
              SizedBox(height: 20.h),
              FadeInUp(child: SponsorScroller()),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
