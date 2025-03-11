part of '../quiz_screen.dart';

/// {@template _Drop_here_widget}
/// _DropHereWidget widget.
/// {@endtemplate}
class _DropHereWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Observer(
    builder: (_) {
      final locale = sl<SettingsStore>().settings.locale;

      switch (locale) {
        case AppLocale.en:
          return Assets.images.dropHereEn.image(
            color: context.colorScheme.primary,
          );
        case AppLocale.ru:
          return Assets.images.dropHereRu.image(
            color: context.colorScheme.primary,
          );
        case AppLocale.tk:
          return Assets.images.dropHereTk.image(
            color: context.colorScheme.primary,
          );
      }
    },
  );
}
