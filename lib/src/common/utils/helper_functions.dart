import '../../../generated/strings.g.dart';
import '../../presentation/settings/store/settings_store.dart';
import '../../service_locator/sl.dart';

String getLocalizedText({
  required String ru,
  required String en,
  required String tk,
}) {
  final locale = sl<SettingsStore>().settings.locale;

  switch (locale) {
    case AppLocale.ru:
      return ru;
    case AppLocale.en:
      return en;
    case AppLocale.tk:
      return tk;
  }
}
