import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/presentation/settings/store/settings_store.dart';

import '../../../generated/assets/assets.gen.dart';
import '../../../generated/strings.g.dart';
import '../../service_locator/sl.dart';
import '../application.dart';
import '../quiz_category/horizontal_category_list.dart';
import '../quiz/quiz_list_wrap.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedWidthWindow(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.height * 0.1 + kToolbarHeight),
          child: Column(
            children: [
              Space.v10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Space.empty),
                  Expanded(
                    flex: 3,
                    child: Text(
                      context.t.interactivePractice,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: AksInternal.constants.padding,
                      children: [
                        for (final locale in AppLocale.values)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (locale == AppLocale.ru)
                                InkWell(
                                  onTap:
                                      () => sl<SettingsStore>().updateLocale(
                                        locale,
                                      ),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Assets.icons.flagRu.image(
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              else if (locale == AppLocale.tk)
                                InkWell(
                                  onTap:
                                      () => sl<SettingsStore>().updateLocale(
                                        locale,
                                      ),
                                  child: Assets.icons.flagTk.image(
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else if (locale == AppLocale.en)
                                InkWell(
                                  onTap:
                                      () => sl<SettingsStore>().updateLocale(
                                        locale,
                                      ),
                                  child: Assets.icons.flagEn.image(
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Space.v5,
                              Text(locale.languageTag.toUpperCase()),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: HorizontalCategoryList()),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(AksInternal.constants.padding),
          children: [QuizListWrap()],
        ),
      ),
    );
  }
}
