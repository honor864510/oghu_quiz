import 'dart:async';
import 'dart:io';

import 'package:aks_internal/aks_internal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'generated/strings.g.dart';
import 'src/presentation/application.dart';
import 'src/service_locator/sl.dart';

void main() => runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await dotenv.load();
  HttpOverrides.global = MyHttpOverrides();

  // debugPaintSizeEnabled = kDebugMode;
  debugRepaintRainbowEnabled = kDebugMode;

  await configureDependencies();

  runApp(TranslationProvider(child: Application()));
}, AksLogger.logZoneError);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
