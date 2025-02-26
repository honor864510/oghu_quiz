import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/parse_sdk/dto/quiz_answer_dto.dart';
import '../../data/parse_sdk/dto/quiz_dto.dart';
import '../../data/parse_sdk/dto/quiz_question_dto.dart';
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
    return Scaffold(body: ListView(children: [if (widget.quiz.type == QuizType.yesNo) _QuizType1()]));
  }
}

class _QuizType1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final quiz = sl<QuizStore>().currentQuiz;

        return Column(
          spacing: AksInternal.constants.padding,
          children: [
            _QuizType1Header(quiz: quiz),
            Text(
              'Drop text here',
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),

            Wrap(
              spacing: AksInternal.constants.padding,
              runSpacing: AksInternal.constants.padding,
              children: [
                for (final answer in quiz?.answers ?? <QuizAnswerDto>[])
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          context.width < 1000
                              ? 1.0 * context.width * 0.4
                              : (1000 / context.width) * context.width * 0.4,
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: AksInternal.constants.padding,
                        children: [
                          Container(
                            width: double.infinity,
                            height: context.height * 0.12,
                            padding: EdgeInsets.only(top: context.height * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AksInternal.constants.borderRadius),
                              color: context.colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                answer.title,
                                style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: AksInternal.constants.padding,
                            runSpacing: AksInternal.constants.padding,
                            children: [
                              for (final question in quiz?.questions ?? <QuizQuestionDto>[])
                                if (question.correctAnswer?.compareId(answer) ?? false)
                                  DragTarget<QuizQuestionDto>(
                                    onWillAcceptWithDetails: (details) {
                                      return true;
                                    },
                                    onAcceptWithDetails: (details) {
                                      sl<QuizStore>().setAnswer(answer);
                                      sl<QuizStore>().nextQuestion();
                                    },
                                    builder: (context, candidateData, rejectedData) {
                                      return Container(
                                        height: context.height * 0.16,
                                        width: context.height * 0.16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: context.colorScheme.primary),
                                        ),
                                        child: AksCachedImage(imageUrl: candidateData.firstOrNull?.picture?.url),
                                      );
                                    },
                                  ),
                            ],
                          ),

                          Space.empty,
                        ],
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

class _QuizType1Header extends StatelessWidget {
  const _QuizType1Header({required this.quiz});

  final QuizDto? quiz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          Draggable<QuizQuestionDto>(
            data: sl<QuizStore>().currentQuestion,
            feedback: AksCachedImage(
              imageUrl: sl<QuizStore>().currentQuestion?.picture?.url,
              height: context.height * 0.16,
              width: context.height * 0.16,
            ),
            childWhenDragging: Container(
              decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), shape: BoxShape.circle),
              height: context.height * 0.16,
              width: context.height * 0.16,
            ),
            child: AksCachedImage(
              imageUrl: sl<QuizStore>().currentQuestion?.picture?.url,
              height: context.height * 0.16,
              width: context.height * 0.16,
            ),
          ),
          Space.h20,
          Expanded(
            child: Observer(
              builder: (_) {
                return Column(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
