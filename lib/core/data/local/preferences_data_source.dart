import 'package:shared_preferences/shared_preferences.dart';

class PreferencesDataSource {
  //-------------------------Bool-----------------------------------------------
  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  //-------------------------List-----------------------------------------------

  Future<void> saveList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  Future<List<String>> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  //-------------------------String-----------------------------------------------

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //-------------------------Clear----------------------------------------------
  Future<void> removeData() async {
  final prefs = await SharedPreferences.getInstance();

  // Remove specific key
  await prefs.remove('username');

  // Clear all data
  await prefs.clear();
}

}
