import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/widgets/widget_custom_calender.dart';

Widget buildCalender(
  BuildContext context,
  onDateSelected,
) {
  return Padding(
    padding: EdgeInsets.only(top: 8.0.h),
    child: CalendarPickerWidget(
      onDateSelected: onDateSelected,
    ),
  );
}
