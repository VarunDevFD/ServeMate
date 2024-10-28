import 'package:serve_mate/features/on_boarding/domain/entities/on_boarding_entity.dart';

class OnboardingState {
  final int currentPage;
  final List<OnboardingPageEntity> pages;
  final bool isLoading;
  final String? error;

  const OnboardingState({
    required this.currentPage,
    required this.pages,
    this.isLoading = false,
    this.error,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPageEntity>? pages,
    bool? isLoading,
    String? error,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}