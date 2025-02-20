import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../common/router/app_router.gr.dart';
import '../../service_locator/sl.dart';
import 'store/quiz_store.dart';

class QuizListWrap extends StatelessWidget {
  const QuizListWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: sl<QuizStore>().quizFetcherStore.isLoading ? 0.2 : 1,
          child: IgnorePointer(
            ignoring: sl<QuizStore>().quizFetcherStore.isLoading,
            child: Wrap(
              spacing: AksInternal.constants.padding,
              runSpacing: AksInternal.constants.padding,
              children:
                  sl<QuizStore>().quizFetcherStore.items
                      .map<Widget>(
                        (item) => InkWell(
                          onTap: () => context.pushRoute(QuizInfoRoute(quiz: item)),
                          child: SizedBox(
                            width: context.width * 0.22,
                            child: Column(
                              spacing: AksInternal.constants.padding,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AksCachedImage(imageUrl: item.picture?.url),
                                Text(
                                  item.title,
                                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        );
      },
    );
  }
}
