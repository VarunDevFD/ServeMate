import 'package:serve_mate/features/on_boarding/domain/entities/en_onboarding.dart';
import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';

class GetOnboardingPagesUseCase {
  final OnboardingRepository repository;

  GetOnboardingPagesUseCase(this.repository);

  Future<List<OnboardingPage>> call() {
    return repository.getOnboardingPages();
  }
}
