import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/get_on_boarding_data.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase = serviceLocator();
  final CompleteOnboardingUseCase completeOnboardingUseCase = serviceLocator();

  OnboardingCubit() : super(const OnboardingState(currentPage: 0, pages: [])) {
    loadOnboardingPages();
  }

  Future<void> loadOnboardingPages() async {
    emit(state.copyWith(isLoading: true));
    try {
      final pages = await getOnboardingPagesUseCase.execute();
      emit(state.copyWith(pages: pages, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void nextPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void skipToEnd() async {
    final lastPageIndex = state.pages.length - 1;
    emit(state.copyWith(currentPage: lastPageIndex));
    await completeOnboardingUseCase.execute();
  }
}
