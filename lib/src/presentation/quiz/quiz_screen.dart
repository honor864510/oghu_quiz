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
        final currentQuestion = sl<QuizStore>().currentQuestion;

        return Column(
          spacing: AksInternal.constants.padding,
          children: [
            _QuizType1Header(quiz: quiz, currentQuestion: currentQuestion),
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
                                if (question.correctAnswer?.compareId(answer) ?? false) _DragTarget(answer: answer),
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

class _DragTarget extends StatefulWidget {
  const _DragTarget({required this.answer});

  final QuizAnswerDto answer;

  @override
  State<_DragTarget> createState() => _DragTargetState();
}

class _DragTargetState extends State<_DragTarget> {
  String? pictureUrl;

  @override
  Widget build(BuildContext context) {
    return DragTarget<QuizQuestionDto>(
      onWillAcceptWithDetails: (details) {
        // TODO Show error message
        return pictureUrl == null;
      },
      onAcceptWithDetails: (details) {
        setState(() {
          pictureUrl = details.data.picture?.url;
        });

        sl<QuizStore>().setAnswer(widget.answer);
        sl<QuizStore>().nextQuestion();
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: context.height * 0.12,
          width: context.height * 0.12,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary)),
          child: AksCachedImage(imageUrl: pictureUrl),
        );
      },
    );
  }
}

class _QuizType1Header extends StatelessWidget {
  const _QuizType1Header({required this.quiz, required this.currentQuestion});

  final QuizDto? quiz;
  final QuizQuestionDto? currentQuestion;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width:
                (context.width * 0.5 - context.height * 0.12 / 2 - AksInternal.constants.padding * 2) *
                (context.width < 1000 ? 1.0 : 1000 / context.width),
            child: Text(
              quiz?.category?.title ?? '',
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: Draggable<QuizQuestionDto>(
              data: currentQuestion,
              childWhenDragging: Space.empty,
              feedback: _QuestionTitleHeader(currentQuestion: currentQuestion),
              child: _QuestionTitleHeader(currentQuestion: currentQuestion),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionTitleHeader extends StatelessWidget {
  const _QuestionTitleHeader({required this.currentQuestion});

  final QuizQuestionDto? currentQuestion;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: (context.width * 0.5) * (context.width < 1000 ? 1.0 : 1000 / context.width),
      ),
      child: Row(
        children: [
          AksCachedImage(
            imageUrl: currentQuestion?.picture?.url,
            height: context.height * 0.16,
            width: context.height * 0.16,
          ),
          Space.h20,

          Expanded(
            child: Observer(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Space.v15,
                    Text(
                      currentQuestion?.title ?? '',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    Text(
                      currentQuestion?.description ?? '',
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentQuestion?.text ?? '',
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
