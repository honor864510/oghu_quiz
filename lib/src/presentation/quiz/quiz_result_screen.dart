import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/router/app_router.gr.dart';
import '../../service_locator/sl.dart';
import '../application.dart';
import 'store/quiz_store.dart';

@RoutePage()
class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  void dispose() {
    sl<QuizStore>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FixedWidthWindow(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${sl<QuizStore>().correctCount} correct answers',
                style: context.textTheme.displayLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),

              Text(
                '${sl<QuizStore>().incorrectCount} incorrect answers answers',
                style: context.textTheme.displayLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              ElevatedButton(
                onPressed: () => context.router.replaceAll([HomeRoute()]),
                child: const Text('Back to Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
