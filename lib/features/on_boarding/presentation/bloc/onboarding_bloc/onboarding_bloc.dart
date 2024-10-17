import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/on_boarding/domain/usecases/use_onboarding.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase;

  OnboardingBloc(this.getOnboardingPagesUseCase) : super(OnboardingInitial()) {
    // Handling the event to load onboarding pages
    on<LoadOnboarding>((event, emit) async {
      emit(OnboardingLoading()); // Emit loading state
      try {
        final pages = await getOnboardingPagesUseCase();
        emit(OnboardingLoaded(pages));
      } catch (error) {
        emit(const OnboardingError('Failed to load onboarding pages'));
      }
    });
  }
}
