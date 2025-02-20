import 'package:aks_internal/aks_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:turkmen_localization_support/turkmen_localization_support.dart';

import '../../generated/strings.g.dart';
import '../common/router/app_router.dart';
import '../common/theme/theme.dart';
import '../service_locator/sl.dart';
import 'settings/store/settings_store.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp.router(
          // Locale
          locale: sl<SettingsStore>().settings.locale.flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            ...TkDelegates.delegates,
          ],

          // Theme mode
          themeMode: sl<SettingsStore>().settings.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          // App router
          routerConfig: sl<AppRouter>().config(navigatorObservers: () => [AksRouteObserver()]),

          // Remove debug mode banner
          debugShowCheckedModeBanner: false,

          // Ensure consistent font sizes across platforms by disabling system font scaling.
          builder: (context, child) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;

            return AnnotatedRegion(
              value: SystemUiOverlayStyle(
                // For Android.
                statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
                // For iOS.
                statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
              ),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child ?? Space.empty,
              ),
            );
          },
        );
      },
    );
  }
}
