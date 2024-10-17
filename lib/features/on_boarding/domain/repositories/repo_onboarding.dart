import 'package:serve_mate/features/on_boarding/domain/entities/en_onboarding.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingPage>> getOnboardingPages();
}
