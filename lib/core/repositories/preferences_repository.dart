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

  Future<void> removeHasSeenOnboarding() async {
    return _preferencesDataSource.remove('hasSeenOnboarding');
  }

  //-----------Home-Screen------------------------------------------------------
  Future<bool> hasSeenHome() async {
    return _preferencesDataSource.getBool('hasSeenHome');
  }

  Future<void> setHasSeenHome(bool value) async {
    return _preferencesDataSource.setBool('hasSeenHome', value);
  }

  Future<void> removeHasSeenHome() async {
    return _preferencesDataSource.remove('hasSeenHome');
  }

  //-----------Category-Screen--------------------------------------------------
  Future<bool> getCategoryScreen() async {
    return _preferencesDataSource.getBool('hasSeenCategory');
  }

  Future<void> setCategoryScreen(bool value) async {
    return _preferencesDataSource.setBool('hasSeenCategory', value);
  }

  Future<void> removeCategoryScreen() async {
    return _preferencesDataSource.remove('hasSeenCategory');
  }

  //-----------Auth-User-Properties------------------------------------------------------
  Future<String> getUserId() async {
    return _preferencesDataSource.getString('uId');
  }

  Future<void> setUSerId(String userId) async {
    return _preferencesDataSource.setString('uId', userId);
  }

  Future<void> removeUserId() async {
    return _preferencesDataSource.remove('uId');
  }

  // UserCategory
  Future<String> getCategoryName() async {
    return _preferencesDataSource.getString('categoryName');
  }

  Future<void> setCategoryName(String category) async {
    return _preferencesDataSource.setString('categoryName', category);
  }

  Future<void> removeCategoryName() async {
    return _preferencesDataSource.remove('categoryName');
  }

  // UserName
  Future<String> getName() async {
    return _preferencesDataSource.getString('uId');
  }

  Future<void> setName(String userId) async {
    return _preferencesDataSource.setString('uId', userId);
  }

  Future<void> removeName() async {
    return _preferencesDataSource.remove('uId');
  }

  // UserEmail
  Future<String> getEmail() async {
    return _preferencesDataSource.getString('email');
  }

  Future<void> setEmail(String email) async {
    return _preferencesDataSource.setString('email', email);
  }

  Future<void> removeEmail() async {
    return _preferencesDataSource.remove('email');
  }

  // UserPhotoUrl
  Future<String> getPhotoUrl() async {
    return _preferencesDataSource.getString('photoUrl');
  }

  Future<void> setPhotoUrl(String photoUrl) async {
    return _preferencesDataSource.setString('photoUrl', photoUrl);
  }

  Future<void> removePhotoUrl() async {
    return _preferencesDataSource.remove('photoUrl');
  }

  // UserSignIn
  Future<bool> getSignIn() async {
    return _preferencesDataSource.getBool('googleSignIn');
  }

  Future<void> setSignIn(bool value) async {
    return _preferencesDataSource.setBool('googleSignIn', value);
  }

  Future<void> removeSignIn() async {
    return _preferencesDataSource.remove('googleSignIn');
  }
}
