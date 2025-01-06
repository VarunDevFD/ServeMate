// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';

class CustomToggleButton extends StatelessWidget {
  final ValueChanged<String> onToggleSelected;
  final List<String> toggleList;

  final TabTogglCubit bloc;

  const CustomToggleButton({
    super.key,
    required this.onToggleSelected,
    required this.toggleList,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabTogglCubit, int>(
        bloc: bloc,
        builder: (context, selectedIndex) {
          // log('Selected Index: $selectedIndex');
          return Center(
            child: FlutterToggleTab(
              // Replace `labels` with `dataTabs`
              dataTabs: toggleList
                  .map((label) =>
                      DataTab(title: label)) // Map each string to DataTab
                  .toList(),
              isShadowEnable: true,
              isScroll: false,
              height: 18.h,
              width: 80.w, // Adjust width for better alignment
              borderRadius: 15.r,
              selectedIndex: selectedIndex,
              selectedBackgroundColors: [AppColors.orange1],
              selectedTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              unSelectedTextStyle: TextStyle(
                color: AppColors.grey,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
              selectedLabelIndex: (index) {
                bloc.selectTab(index); // Emit new index
                onToggleSelected(toggleList[index]);
              },
            ),
          );
        });
  }
}
