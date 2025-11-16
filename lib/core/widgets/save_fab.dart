import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: FloatingActionButton(
        onPressed: onPressed,
        elevation: 0,
        highlightElevation: 0,
        mini: false,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        shape: const CircleBorder(),
        heroTag: 'venueUpdateFab',
        child: Icon(
          Icons.save,
          size: 26.sp,
        ),
      ),
    );
  }
}
