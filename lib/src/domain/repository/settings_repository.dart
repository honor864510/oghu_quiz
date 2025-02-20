import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../generated/strings.g.dart';
import '../../data/shared_preferences/shared_preferences_helper.dart';
import '../entity/settings_entity.dart';

class SettingsRepository {
  final SharedPreferencesHelper _preferencesHelper;

  SettingsRepository({required SharedPreferencesHelper preferencesHelper})
    : _preferencesHelper = preferencesHelper;

  Future<SettingsEntity> getSettings() async {
    final jsonString = _preferencesHelper.settings;

    if (jsonString == null) {
      return SettingsEntity(themeMode: ThemeMode.light, locale: AppLocale.ru);
    }

    return SettingsEntity.fromJson(json.decode(jsonString));
  }

  Future<void> saveSettings(SettingsEntity settings) async {
    final jsonString = json.encode(settings.toJson());

    await _preferencesHelper.setSettings(jsonString);
  }
}
