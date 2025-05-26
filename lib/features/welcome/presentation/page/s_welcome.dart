import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/theme/app_text_style.dart';
import 'package:serve_mate/core/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pref = serviceLocator<PreferencesRepository>();
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Serve Mate',
              style: AppTextStyles.titleStyle.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                        text: 'Sign In',
                        onPressed: () => context.go('/sign-in'),
                        //----------Temp--------
                        onLongPress: () async {
                          await pref.setUSerId('vnqRS2iM2gXgc4MSuR4jlGAIkex2');
                          // await pref.setUSerId('dZ67hc6Jd8PWC2mpSrqYiULYfeE2');

                          // await pref.setUSerId('dZ67hc6Jd8PWC2mpSrqYiULYfeE3');
                          context.go('/selectCategory');
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: AppColors.background,
                      text: 'Sign Up',
                      textStyle: AppTextStyles.buttonTextStyleWelcomeBn2,
                      onPressed: () {
                        context.go('/sign-up');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
