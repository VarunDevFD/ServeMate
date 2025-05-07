import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;
  final double size;
  final Color secondRingColor;
  final Color thirdRingColor;

  const CustomLoading({
    super.key,
    this.color,
    this.size = 50,
    this.secondRingColor = Colors.grey,
    this.thirdRingColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: color ?? AppColors.orange,
        size: size.h,
        secondRingColor: secondRingColor,
        thirdRingColor: thirdRingColor,
      ),
    );
  }
}
