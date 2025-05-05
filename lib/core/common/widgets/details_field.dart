import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDetailField(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Text(
      '$label: $value',
      style: TextStyle(fontSize: 16.sp),
    ),
  );
}