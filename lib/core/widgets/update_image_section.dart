import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/common/bloc/switch_button_bloc/common_access_bloc/common_access_cubit.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/helper/image_helper.dart';
import 'package:serve_mate/features/product/presentation/widgets/image_widgets.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Images',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Previous Data',
          style: TextStyle(fontSize: 14.sp),
        ),
        BlocBuilder<CommonCubit, List<String>>(
          builder: (context, imageUrls) {
            if (imageUrls.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Icon(Icons.image_not_supported,
                        size: 50.sp, color: AppColors.grey),
                    SizedBox(height: 10.h),
                    Text(
                      'No images available Add Images',
                      style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              );
            }
            return SizedBox(
              height: 180.h,
              width: 350.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  final bloc = context.read<CommonCubit>();
                  return Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageHelper.updateCachedNetworkImage(
                            imageUrl: imageUrls[index],
                          ),
                        ),
                        Positioned(
                          top: 4.h,
                          right: 4.w,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.close,
                                  color: AppColors.white, size: 18.sp),
                              onPressed: () => bloc.removeImage(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        const ImagePickerPage(),
      ],
    );
  }
}
