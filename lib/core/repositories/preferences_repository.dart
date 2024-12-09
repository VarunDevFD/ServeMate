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

  //-----------Home-Screen------------------------------------------------------
  Future<bool> hasSeenHome() async {
    return _preferencesDataSource.getBool('hasSeenHome');
  }

  Future<void> setHasSeenHome(bool value) async {
    return _preferencesDataSource.setBool('hasSeenHome', value);
  }

  //-----------After-Auth-Category-Selection------------------------------------
  Future<bool> hasSeenCategory() async {
    return _preferencesDataSource.getBool('hasSeenCategory');
  }

  Future<void> setHasSeenCategory(bool value) async {
    return _preferencesDataSource.setBool('hasSeenCategory', value);
  }

}
