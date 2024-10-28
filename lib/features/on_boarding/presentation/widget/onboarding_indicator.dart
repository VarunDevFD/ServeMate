import 'package:flutter/material.dart';
import 'package:serve_mate/core/widgets/custom_text.dart';
import 'package:serve_mate/features/on_boarding/domain/entities/on_boarding_entity.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageEntity pageData;

  const OnboardingPage({
    super.key,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(pageData.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: CustomText(
          text: pageData.text,
          styleType: TextStyleType.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
