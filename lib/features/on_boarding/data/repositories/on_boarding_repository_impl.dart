import 'package:serve_mate/features/on_boarding/domain/entities/on_boarding_entity.dart';
import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingPageEntity>> getOnboardingPages() async {
    // In a real app, this might come from a local storage or API
    return [
      const OnboardingPageEntity(
        imagePath: 'assets/images/on_boarding1.jpg',
        text: 'Welcome to Our Service',
      ),
      const OnboardingPageEntity(
        imagePath: 'assets/images/on_boarding2.jpg',
        text: 'Find the best options for you',
      ),
      const OnboardingPageEntity(
        imagePath: 'assets/images/on_boarding3.jpg',
        text: 'Get started and explore',
      ),
    ];
  }

  @override
  Future<void> setOnboardingComplete() async {
    // Implement storage logic
  }

  @override
  Future<bool> isOnboardingComplete() async {
    // Implement check logic
    return false;
  }
}