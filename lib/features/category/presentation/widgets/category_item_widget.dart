import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';
import 'package:serve_mate/features/category/domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage(category.imageUrl), // Set the image from the category
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.balck4, // Dark overlay for better text visibility
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: Alignment.bottomLeft, // Align text to bottom left
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, bottom: 8.0), // Add padding for spacing
            child: CustomText(
              text: category.name.toUpperCase(), // Display the category name
              styleType: TextStyleType.body,
            ),
          ),
        ),
      ),
    );
  }
}
