import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator/sl.dart';

@singleton
class SharedPreferencesHelper {
  static const String _namespace = 'vertera__';

  // Keys
  static const String keySettings = 'settings';
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keySelectedClubId = 'selectedClubId';

  SharedPreferences get _preferences => sl<SharedPreferences>();

  // Helper method to prepend the namespace to keys
  String _getKey(String key) {
    return '$_namespace$key';
  }

  Future<void> clear() async => await _preferences.clear();

  // IsLoggedIn
  bool get isLoggedIn => _preferences.getBool(_getKey(keyIsLoggedIn)) ?? false;
  Future<bool> setIsLoggedIn(bool value) async =>
      await _preferences.setBool(_getKey(keyIsLoggedIn), value);

  // Settings
  String? get settings => _preferences.getString(_getKey(keySettings));
  Future<void> setSettings(String value) async =>
      await _preferences.setString(_getKey(keySettings), value);

  // SelectedClubId
  String? get selectedClubId =>
      _preferences.getString(_getKey(keySelectedClubId));
  Future<void> setSelectedClubId(String? value) async =>
      await _preferences.setString(_getKey(keySelectedClubId), value ?? '');
}
