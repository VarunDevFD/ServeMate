import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
      bool hasSeenHome = prefs.getBool('hasSeenHome') ?? false;

      Future.delayed(const Duration(seconds: 3), () {
        if (hasSeenHome) {
          context.go('/home');
        } else if (hasSeenOnboarding) {
          // If onboarding has been seen, go to the home screen
          context.go('/welcome');
        } else {
          // If onboarding hasn't been seen, go to the onboarding screen
          context.go('/onboarding');
        }
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEAE4DD),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
