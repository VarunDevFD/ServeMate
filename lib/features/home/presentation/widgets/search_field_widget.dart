import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_state.dart';

class AnimatedSearchBar extends StatelessWidget {
  const AnimatedSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMain(context);
  }

  Widget _buildMain(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.0.h),
      child: Row(
        children: [
          Expanded(child: _buildSession1Search(context)),
          SizedBox(width: 8.0.w),
          _buildSession2Profile(context),
        ],
      ),
    );
  }

  Widget _buildSession1Search(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 20.0.r,
            offset: Offset(1, 2.h),
          ),
        ],
      ),
      child: BlocBuilder<SearchBarBloc, SearchBarState>(
        builder: (context, state) {
          return TextField(
            readOnly: true,
            autofocus: false,
            onTap: () {
              context.push('/search');
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 12.w,
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.black),
              hintText: state.hintText,
              hintStyle: TextStyle(
                color: AppColors.grey,
                fontSize: 12.sp,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSession2Profile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/bottomNavBar');
      },
      child: Container(
        height: 38.0.h,
        width: 38.0.w,
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(22.0.r),
        ),
        child: Icon(Icons.image, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
