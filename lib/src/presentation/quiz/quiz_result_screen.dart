import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/common/router/app_router.gr.dart';

@RoutePage()
class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.router.replaceAll([HomeRoute()]),
          child: const Text('Back to Categories'),
        ),
      ),
    );
  }
}
