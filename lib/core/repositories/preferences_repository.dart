import 'package:serve_mate/core/data/local/preferences_data_source.dart';
import 'package:serve_mate/core/di/injector.dart';

class PreferencesRepository {
  final _preferencesDataSource = serviceLocator<PreferencesDataSource>();

  //-----------On-Boarding-Screen-----------------------------------------------
  Future<bool> hasSeenOnboarding() async {
    return _preferencesDataSource.getBool('hasSeenOnboarding');
  }

  Future<void> setHasSeenOnboarding(bool value) async {
    return _preferencesDataSource.setBool('hasSeenOnboarding', value);
  }

  //-----------Authentication---------------------------------------------------
  Future<bool> hasSeenHome() async {
    return _preferencesDataSource.getBool('hasSeenHome');
  }

  Future<void> setHasSeenHome(bool value) async {
    return _preferencesDataSource.setBool('hasSeenHome', value);
  }


/*
  //-----------Animation-Repeatation-avoid--------------------------------------
  Future<bool> hasShownAnimation() async {
    return _preferencesDataSource.getBool('hasShownAnimation');
  }

  Future<void> setHasShownAnimation(bool value) async {
    return _preferencesDataSource.setBool('hasShownAnimation', value);
  }
  */
}
