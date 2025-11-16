import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/product/presentation/widgets/filter_chip_widget.dart';

class FacilitiesSection extends StatelessWidget {
  final String id;
  final List<String>? previousFacilities;
  final List<String> chipOptions;

  const FacilitiesSection({
    super.key,
    required this.id,
    required this.previousFacilities,
    required this.chipOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data:\n${(previousFacilities?.isNotEmpty ?? false) ? previousFacilities!.join('\n') : 'No Facilities'}',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose the Data to Update',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        FilterChipScreen(id: id, categories: chipOptions),
      ],
    );
  }
}
