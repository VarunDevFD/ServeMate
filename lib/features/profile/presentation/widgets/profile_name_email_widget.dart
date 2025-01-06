import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameEmailProfile extends StatelessWidget {
  const NameEmailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Varun P C',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          const Text(
            'Varunrevathi6@gmail.com',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
