import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/strings.g.dart';

class SettingsEntity extends Equatable {
  final ThemeMode themeMode;
  final AppLocale locale;

  const SettingsEntity({required this.themeMode, required this.locale});

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    AppLocale? locale,
    bool? showTournaments,
    String? modificatorId,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.index, 'locale': locale.languageTag};
  }

  factory SettingsEntity.fromJson(Map<String, dynamic> json) {
    return SettingsEntity(
      themeMode:
          ThemeMode.values[json['themeMode'] as int? ?? ThemeMode.light.index],
      locale: AppLocale.values.firstWhere(
        (loc) => loc.languageTag == json['locale'],
        orElse: () => AppLocale.ru,
      ),
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
