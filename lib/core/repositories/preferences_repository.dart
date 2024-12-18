import 'dart:developer';

import 'package:serve_mate/core/data/local/preferences_data_source.dart';
import 'package:serve_mate/core/di/injector.dart';

class PreferencesRepository {
  final _preferencesDataSource = serviceLocator<PreferencesDataSource>();

  //-------------------------Bool-----------------------------------------------
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

  //-------------------------List-----------------------------------------------
  Future<List<String>> hasSeenUserId() async {
    return _preferencesDataSource.getList('selectUser');
  }

  Future<void> setHasSeenUserId(List<String> value) async {
    /*
    log("Start- shared");
    if (value.isNotEmpty) {
      for (int i = 0; i < value.length; i++) {
        log(value[i]);
      }
    }
    log("End- shared");
    */

    return _preferencesDataSource.setList('selectUser', []);
  }
}


/*
final updatedList = List<String>.from(seenUserIds)..add(newUserId);
      await _userRepository.setHasSeenUserId(updatedList);
*/