import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameEmailProfile extends StatelessWidget {
  final String? name;
  final String? email;
  NameEmailProfile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            name ?? 'User',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            email ?? 'Varunrevathi6@gmail.com',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
