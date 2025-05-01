import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../generated/strings.g.dart';
import '../../common/router/app_router.gr.dart';
import '../../data/parse_sdk/dto/quiz_dto.dart';
import '../application.dart';

@RoutePage()
class QuizInfoScreen extends StatelessWidget {
  const QuizInfoScreen({super.key, required this.quiz});

  final QuizDto quiz;

  @override
  Widget build(BuildContext context) {
    return FixedWidthWindow(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            context.t.interactivePractice,
            style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.primary),
          ),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(AksInternal.constants.padding),
            child: Column(
              spacing: AksInternal.constants.padding,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Space.v20,
                AksCachedImage(imageUrl: quiz.picture?.url, height: context.height * 0.6),
                Expanded(
                  child: AutoSizeText(
                    quiz.title,
                    style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.primary),
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: context.width * 0.05, vertical: 12),
                  ),
                  onPressed: () => context.pushRoute(QuizRoute(quiz: quiz)),
                  child: AutoSizeText(
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
        ),
      ),
    );
  }
}
