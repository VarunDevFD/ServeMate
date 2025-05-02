import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';

class SectionFiveDressCard extends StatelessWidget {
  const SectionFiveDressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.photo_library,
                  color: AppColors.orange1,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Product Images',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const ImagePickerPage()
          ],
        ),
      ),
    );
  }
}
