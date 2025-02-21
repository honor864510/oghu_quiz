import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: HomeRoute.page),
    AutoRoute(page: QuizInfoRoute.page),
    AutoRoute(page: QuizRoute.page),
  ];
}
