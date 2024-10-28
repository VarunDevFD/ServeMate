// import 'dart:developer';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PreferencesRepository preferencesRepository =
      serviceLocator<PreferencesRepository>();

  SplashBloc() : super(SplashInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
  }

  void _onCheckOnboardingStatus(
      CheckOnboardingStatus event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 5));
    bool hasSeenHome = await preferencesRepository.hasSeenHome();
    log("$hasSeenHome");
    bool hasSeenOnboarding = await preferencesRepository.hasSeenOnboarding();

    if (hasSeenHome) {
      emit(GoToHome());
    } else if (hasSeenOnboarding) {
      emit(GoToWelcome());
    } else {
      emit(GoToOnboarding());
    }
  }
}