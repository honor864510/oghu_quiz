import 'package:aks_internal/aks_internal.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/assets/assets.gen.dart';
import '../data/parse_sdk/parse_initializer.dart';
import 'sl.config.dart';

part '__init_aks_internal.dart';

final sl = GetIt.instance;

const kAuthScope = 'auth';

@InjectableInit()
Future<void> configureDependencies() async {
  await ParseInitializer.init();

  _initAksInternal();

  sl.init();
  // await sl.init();
}

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
