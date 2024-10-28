import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase(this.repository);

  Future<void> execute() {
    return repository.setOnboardingComplete();
  }
}