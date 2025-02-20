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
    final categoryFetcherStore = sl<QuizCategoryStore>().categoryFetcherStore;

    return Observer(
      builder: (_) {
        return Center(
          child: Skeletonizer(
            enabled: categoryFetcherStore.isLoading,
            child: ListView.separated(
              itemCount: categoryFetcherStore.items.length + 1,
              separatorBuilder: (context, index) => Space.h10,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => _CategoryItem(index),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final int index;

  const _CategoryItem(this.index);

  @override
  Widget build(BuildContext context) {
    final categoryFetcherStore = sl<QuizCategoryStore>().categoryFetcherStore;

    return Observer(
      builder: (context) {
        if (index == 0) {
          final isSelected = sl<QuizCategoryStore>().selectedCategory == null;

          return Align(
            child: TextButton(
              onPressed: () => sl<QuizCategoryStore>().setSelectedCategory(null),
              style: TextButton.styleFrom(backgroundColor: isSelected ? context.colorScheme.primary : null),
              child: Text(
                context.t.all,
                style: context.textTheme.titleLarge?.copyWith(color: isSelected ? context.colorScheme.onPrimary : null),
              ),
            ),
          );
        }

        final category = categoryFetcherStore.items[index - 1];
        final isSelected = sl<QuizCategoryStore>().selectedCategory == category;

        return Align(
          child: TextButton(
            onPressed: () => sl<QuizCategoryStore>().setSelectedCategory(category),
            style: TextButton.styleFrom(backgroundColor: isSelected ? context.colorScheme.primary : null),
            child: Text(
              category.title,
              style: context.textTheme.titleLarge?.copyWith(color: isSelected ? context.colorScheme.onPrimary : null),
            ),
          ),
        );
      },
    );
  }
}
