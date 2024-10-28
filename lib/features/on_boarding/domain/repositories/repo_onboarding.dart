import 'package:serve_mate/features/on_boarding/domain/entities/on_boarding_entity.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingPageEntity>> getOnboardingPages();
  Future<void> setOnboardingComplete();
  Future<bool> isOnboardingComplete();
}