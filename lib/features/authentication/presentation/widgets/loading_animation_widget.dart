import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.dimBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: LoadingAnimationWidget.discreteCircle(
            color: AppColors.white,
            size: 100.r,
            secondRingColor: AppColors.grey,
            thirdRingColor: AppColors.orange,
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
