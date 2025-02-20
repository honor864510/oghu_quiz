import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../quiz_category/horizontal_category_list.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.1 + kToolbarHeight),
        child: HorizontalCategoryList(),
      ),
    );
  }
}
