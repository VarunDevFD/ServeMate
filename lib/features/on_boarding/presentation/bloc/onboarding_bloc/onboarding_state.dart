// Defining the states
import 'package:serve_mate/features/on_boarding/domain/entities/en_onboarding.dart';

abstract class OnboardingState {
  const OnboardingState();
}

// Initial state
class OnboardingInitial extends OnboardingState {}

// Loading state
class OnboardingLoading extends OnboardingState {}

// Loaded state with the onboarding pages
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingPage> pages;

  const OnboardingLoaded(this.pages);
}

// Error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);
}
