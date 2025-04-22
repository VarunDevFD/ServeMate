import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final preferencesRepository = serviceLocator<PreferencesRepository>();

  SplashBloc() : super(SplashInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
  }

  void _onCheckOnboardingStatus(
      CheckOnboardingStatus event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 5));
    bool hasSeenHome = await preferencesRepository.hasSeenHome();
    bool hasSeenOnboarding = await preferencesRepository.hasSeenOnboarding();
    bool categoryScreen = await preferencesRepository.getCategoryScreen();
    String userCategory = await preferencesRepository.getCategoryName();
    log("-----$userCategory");

    if (hasSeenHome == true && userCategory.isNotEmpty) {
      emit(GoToHome());
    } else if (categoryScreen == true) {
      emit(GoToCategory());
    } else if (hasSeenOnboarding == true) {
      emit(GoToWelcome());
    } else {
      emit(GoToOnboarding());
    }
  }
}
