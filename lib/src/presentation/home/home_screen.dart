import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../generated/strings.g.dart';
import '../quiz_category/horizontal_category_list.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.1 + kToolbarHeight),
        child: Column(
          children: [
            Space.v10,
            Text(
              context.t.interactivePractice,
              style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.primary),
            ),
            Expanded(child: HorizontalCategoryList()),
          ],
        ),
      ),
    );
  }
}
