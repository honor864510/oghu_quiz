import 'package:flutter/material.dart';

import '../../../generated/assets/colors.gen.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,

    // Global font family
    // fontFamily: FontFamily.iBMPlexSans,

    // Colors
    colorScheme: const ColorScheme.light(
      primary: ColorName.primaryLight,
      onPrimary: ColorName.onPrimaryLight,
      surface: ColorName.surfaceLight,
      onSurface: ColorName.onSurfaceLight,
      secondary: ColorName.secondaryLight,
      onSecondary: ColorName.onSecondaryLight,
      error: ColorName.errorLight,
      onError: ColorName.onErrorLight,
      tertiary: ColorName.tertiaryLight,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,

    // Global font family
    // fontFamily: FontFamily.iBMPlexSans,

    // Colors
    colorScheme: const ColorScheme.dark(
      primary: ColorName.primaryDark,
      onPrimary: ColorName.onPrimaryDark,
      surface: ColorName.surfaceDark,
      onSurface: ColorName.onSurfaceDark,
      secondary: ColorName.secondaryDark,
      onSecondary: ColorName.onSecondaryDark,
      error: ColorName.errorDark,
      onError: ColorName.onErrorDark,
      tertiary: ColorName.tertiaryDark,
    ),
  );
}
