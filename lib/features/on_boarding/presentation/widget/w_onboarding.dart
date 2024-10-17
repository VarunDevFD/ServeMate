import 'package:flutter/material.dart';
import 'package:serve_mate/core/utils/theme/app_text_style.dart';
import 'package:serve_mate/core/utils/widgets/custom_button.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final String subText;
  final VoidCallback onSkipPressed;
  final VoidCallback onContinuePressed;
  final bool isLastPage;

  const OnboardingPageWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.subText,
    required this.onSkipPressed,
    required this.onContinuePressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subText,
                      style: AppTextStyles.subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomElevatedButton(
                  text: isLastPage ? 'Get Started' : 'Continue',
                  onPressed: onContinuePressed,
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
        Positioned(
          top: 40,
          right: 20,
          child: isLastPage
              ? const SizedBox()
              : TextButton(
                  onPressed: onSkipPressed,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.buttonTextStyle,
                  ),
                ),
        ),
      ],
    );
  }
}
