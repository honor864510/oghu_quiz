import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/presentation/settings/store/settings_store.dart';

import '../../../generated/assets/assets.gen.dart';
import '../../../generated/strings.g.dart';
import '../../service_locator/sl.dart';
import '../quiz_category/horizontal_category_list.dart';
import '../quiz/quiz_list_wrap.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
        title: AutoSizeText(
          context.t.interactivePractice,
          style: context.textTheme.displayMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                for (final locale in AppLocale.values)
                  _LanguageSwitcher(locale: locale),
              ],
            ),
          ),
        ],
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: EdgeInsets.all(AksInternal.constants.padding),
            child: Column(
              children: [
                const HorizontalCategoryList(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [QuizListWrap()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  final AppLocale locale;

  const _LanguageSwitcher({required this.locale});

  Widget _getFlagImage(AppLocale locale) {
    switch (locale) {
      case AppLocale.ru:
        return Assets.icons.flagRu.image(height: 30, fit: BoxFit.cover);
      case AppLocale.tk:
        return Assets.icons.flagTk.image(height: 30, fit: BoxFit.cover);
      case AppLocale.en:
        return Assets.icons.flagEn.image(height: 30, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final settingsStore = sl<SettingsStore>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => settingsStore.updateLocale(locale),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AksInternal.constants.borderRadius / 3,
                  ),
                  child: _getFlagImage(locale),
                ),
              ),
              Space.v5,
              AutoSizeText(
                locale.languageTag.toUpperCase(),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
