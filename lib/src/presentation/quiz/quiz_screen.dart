import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../data/parse_sdk/dto/quiz_dto.dart';
import '../../service_locator/sl.dart';
import 'store/quiz_store.dart';

@RoutePage()
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quiz});

  final QuizDto quiz;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    sl<QuizStore>().setQuiz(widget.quiz);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _QuizType1());
  }
}

class _QuizType1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final quiz = sl<QuizStore>().currentQuiz;

        return Column(
          spacing: AksInternal.constants.padding,
          children: [
            SizedBox(
              height: context.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      quiz?.category?.title ?? '',
                      style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  AksCachedImage(imageUrl: sl<QuizStore>().currentQuestion?.picture?.url),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          sl<QuizStore>().currentQuestion?.title ?? '',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        Text(
                          sl<QuizStore>().currentQuestion?.description ?? '',
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          sl<QuizStore>().currentQuestion?.text ?? '',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Drop text here',
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),

            Row(
              spacing: AksInternal.constants.padding,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: context.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(AksInternal.constants.borderRadius),
                      border: Border.all(color: context.colorScheme.primary, width: 3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Container(height: context.height * .1, color: context.colorScheme.primary)],
                    ),
                  ),
                ),
                Space.h20,
                Expanded(
                  child: Container(
                    height: context.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(AksInternal.constants.borderRadius),
                      border: Border.all(color: context.colorScheme.primary, width: 3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Container(height: context.height * .1, color: context.colorScheme.primary)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
