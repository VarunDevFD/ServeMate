import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/utils/theme/app_colors.dart';
import 'package:serve_mate/features/on_boarding/data/repositories/repo_onboarding_data.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/use_onboarding.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_event.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_state.dart';
import 'package:serve_mate/features/on_boarding/presentation/widget/w_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // Async function to set SharedPreferences outside of BuildContext usage
  Future<void> setOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (_) =>
          OnboardingBloc(GetOnboardingPagesUseCase(OnboardingRepositoryImpl()))
            ..add(LoadOnboarding()),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingLoaded) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: state.pages.length,
                        itemBuilder: (context, index) {
                          final page = state.pages[index];

                          // Define isLastPage inside itemBuilder
                          final bool isLastPage =
                              index == state.pages.length - 1;

                          return OnboardingPageWidget(
                            imagePath: page.imagePath,
                            text: page.text,
                            subText: page.subText,
                            onSkipPressed: () {
                              pageController.jumpToPage(state.pages.length - 1);
                            },
                            onContinuePressed: () async {
                              if (isLastPage) {
                                await setOnboardingCompleted();
                                // ignore: use_build_context_synchronously
                                context.go('/welcome');
                              } else {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 96),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                            isLastPage: isLastPage,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: state.pages.length,
                        effect: const JumpingDotEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          spacing: 16,
                          activeDotColor: AppColors.buttonTextColor,
                          dotColor: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
