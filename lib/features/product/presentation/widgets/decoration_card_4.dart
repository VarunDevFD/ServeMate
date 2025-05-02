import 'package:flutter/material.dart'; 
import 'package:serve_mate/core/utils/constants.dart'; 
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/card_constant.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionFourDecorationCard extends StatelessWidget {
  const SectionFourDecorationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CardProperties.cardShape,
      child: Padding(
        padding: AppPadding.paddingEdgesAll,
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
            const ImagePickerPage(),
          ],
        ),
      ),
    );
  }
}
