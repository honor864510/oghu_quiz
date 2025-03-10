import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz/src/common/router/app_router.gr.dart';

import '../../service_locator/sl.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Text(
            //   '${sl<QuizStore>().correctAnswers.length} correct answers',
            //   style: context.textTheme.displayLarge?.copyWith(color: context.colorScheme.primary),
            // ),

            // Text(
            //   '${sl<QuizStore>().incorrectAnswers.length} incorrect answers answers',
            //   style: context.textTheme.displayLarge?.copyWith(color: context.colorScheme.primary),
            // ),
            ElevatedButton(
              onPressed: () => context.router.replaceAll([HomeRoute()]),
              child: const Text('Back to Categories'),
            ),
          ],
        ),
      ),
    );
  }
}
