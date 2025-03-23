import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_state.dart';

class AnimatedSearchBar extends StatelessWidget {
  const AnimatedSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBarBloc, SearchBarState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(153),
                        blurRadius: 5.0.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: TextField(
                    autofocus:
                        false, // Ensure the keyboard doesn't pop up immediately
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 12.w,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.black,
                      ),
                      hintText: state.hintText,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.sp,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      // Close the keyboard after submission
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
              ),
              SizedBox(width: 8.0.w),
              Container(
                height: 38.0.h,
                width: 38.0.w,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(22.0.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 6.0.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.image, color: Colors.white, size: 20.sp),
                  onPressed: () {
                    // Close the keyboard when this button is pressed
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
