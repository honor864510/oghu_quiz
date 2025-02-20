import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../generated/strings.g.dart';
import '../../data/parse_sdk/dto/quiz_dto.dart';

@RoutePage()
class QuizInfoScreen extends StatelessWidget {
  const QuizInfoScreen({super.key, required this.quiz});

  final QuizDto quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.interactivePractice,
          style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Column(
          spacing: AksInternal.constants.padding,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space.v20,
            AksCachedImage(imageUrl: quiz.picture?.url, height: context.height * 0.6),
            Text(quiz.title, style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.primary)),
            FilledButton(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.05, vertical: context.height * 0.05),
              ),
              onPressed: () {},
              child: Text(
                context.t.start,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
