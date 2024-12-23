import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';
import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(category.imageUrl!),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              imageUrl: category.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: ((context, url) => Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: AppColors.orange,
                      size: 50.r,
                      secondRingColor: AppColors.grey,
                      thirdRingColor: AppColors.white,
                    ),
                  )),
              errorWidget: (context, url, error) => Center(
                child: Icon(
                  Icons.broken_image,
                  color: AppColors.grey,
                  size: 50.r,
                ),
              ),
            ),
          ),
          // Text overlay at the bottom
          Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              color: AppColors.balck4.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 6.w, bottom: 6.h),
                child: CustomText(
                  text: category.name.toUpperCase(),
                  styleType: TextStyleType.body,
                  customStyle: const TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
