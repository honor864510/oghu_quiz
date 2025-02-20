import 'package:aks_internal/aks_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../generated/strings.g.dart';
import '../../service_locator/sl.dart';
import 'store/quiz_category_store.dart';

class HorizontalCategoryList extends StatelessWidget {
  const HorizontalCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<QuizCategoryStore>().categoryFetcherStore;

    return Observer(
      builder: (_) {
        return Skeletonizer(
          enabled: store.isLoading,
          child: ListView.separated(
            itemCount: store.items.length + 1,
            separatorBuilder: (context, index) => Space.h10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Align(
                  child: TextButton(onPressed: () {}, child: Text(context.t.all, style: context.textTheme.titleLarge)),
                );
              }

              final category = store.items[index - 1];
              return Align(
                child: TextButton(onPressed: () {}, child: Text(category.title, style: context.textTheme.titleLarge)),
              );
            },
          ),
        );
      },
    );
  }
}
