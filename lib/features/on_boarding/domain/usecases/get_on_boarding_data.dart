import 'package:serve_mate/features/on_boarding/domain/entities/on_boarding_entity.dart';
import 'package:serve_mate/features/on_boarding/domain/repositories/repo_onboarding.dart';

class GetOnboardingPagesUseCase {
  final OnboardingRepository repository;

  GetOnboardingPagesUseCase(this.repository);

  Future<List<OnboardingPageEntity>> execute() {
    return repository.getOnboardingPages();
  }
}