import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../generated/strings.g.dart';
import '../../../domain/entity/settings_entity.dart';
import '../../../domain/repository/settings_repository.dart';

part '../../../../generated/src/presentation/settings/store/settings_store.g.dart';

@singleton
class SettingsStore = _SettingsStoreBase with _$SettingsStore;

abstract class _SettingsStoreBase with Store {
  final SettingsRepository _settingsRepository;

  _SettingsStoreBase({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository {
    _init();
  }

  @observable
  late SettingsEntity settings;

  _init() async {
    settings = await _settingsRepository.getSettings();

    // Set up locale-related functionality
    LocaleSettings.getLocaleStream().listen((event) {
      Intl.defaultLocale = event.flutterLocale.toLanguageTag();
    });

    LocaleSettings.setLocale(settings.locale);
  }

  @action
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    settings = settings.copyWith(themeMode: themeMode);
    await _settingsRepository.saveSettings(settings);
  }

  @action
  Future<void> updateLocale(AppLocale? locale) async {
    if (locale == null) return;

    settings = settings.copyWith(locale: locale);
    LocaleSettings.setLocale(locale);

    await _settingsRepository.saveSettings(settings);
  }
}
