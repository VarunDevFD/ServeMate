import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_event.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the event when the widget is built
    context.read<SplashBloc>().add(CheckOnboardingStatus());

    return Scaffold(
      backgroundColor: const Color(0xFFEAE4DD),
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          // Handle navigation based on state
          if (state is GoToHome) {
            context.go('/bottomNavBar');
          } else if (state is GoToCategory) {
            context.go('/selectCategory');
          } else if (state is GoToWelcome) {
            context.go('/welcome');
          } else if (state is GoToOnboarding) {
            // log("Navigating to Onboarding");
            context.go('/onboarding');
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 500,
            height: 400,
          ),
        ),
      ),
    );
  }
}
