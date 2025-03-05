import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
    return Scaffold(
      body: ListView(
        children: [if (widget.quiz.type == QuizType.yesNo) _QuizType1()],
      ),
    );
  }
}

class _QuizType1 extends StatefulWidget {
  @override
  State<_QuizType1> createState() => _QuizType1State();
}

class _QuizType1State extends State<_QuizType1> {
  _showNextQuestion() async {
    await Navigator.of(context).maybePop();
    sl<QuizStore>().setSelectedAnswer(null);
    sl<QuizStore>().nextQuestion();
  }

  _submitAnswer() async {
    final store = sl<QuizStore>();
    // Check correctness and update store
    store.setAnswer(store.selectedAnswer);

    final isCorrect =
        store.currentQuestion?.correctAnswer?.compareId(store.selectedAnswer) ??
        false;

    // TODO Show correct/incorrect dialog?
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AksInternal.constants.padding,
              children: [
                Space.empty,
                Text(isCorrect ? 'Correct!' : 'Wrong!'),
                Text(
                  isCorrect
                      ? store.currentQuestion?.correctDescription ?? ''
                      : store.currentQuestion?.wrongDescription ?? '',
                ),
                ElevatedButton(
                  onPressed: _showNextQuestion,
                  child: const Text('Next'),
                ),
                Space.empty,
              ],
            ),
          ),
    );
  }

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
            SizedBox(
              height: context.height * 0.1,
              child: Observer(
                builder: (_) {
                  return SizedBox(
                    height: context.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Space.h20,
                        Space.h20,
                        FilledButton(
                          onPressed:
                              sl<QuizStore>().selectedAnswer == null
                                  ? null
                                  : _submitAnswer,
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: AksInternal.constants.padding * 3,
                              vertical: AksInternal.constants.padding * 1.4,
                            ),
                          ),
                          child: Text('Confirm'),
                        ),
                        Space.h10,
                        AnimatedOpacity(
                          duration: AksInternal.constants.animationDuration,
                          opacity:
                              sl<QuizStore>().selectedAnswer != null ? 1 : 0,
                          child: IconButton.filled(
                            style: IconButton.styleFrom(
                              shape: CircleBorder(),
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              backgroundColor: context.colorScheme.error,
                            ),
                            onPressed:
                                sl<QuizStore>().selectedAnswer == null
                                    ? null
                                    : () =>
                                        sl<QuizStore>().setSelectedAnswer(null),
                            icon: Center(child: Icon(Icons.cancel_outlined)),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
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
                        children: [
                          Container(
                            width: double.infinity,
                            height: context.height * 0.12,
                            padding: EdgeInsets.only(
                              top: context.height * 0.04,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AksInternal.constants.borderRadius,
                              ),
                              color: context.colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                answer.title,
                                style: context.textTheme.titleLarge?.copyWith(
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          _DragTarget(quiz: quiz, answer: answer),
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
  const _DragTarget({required this.quiz, required this.answer});

  final QuizDto? quiz;
  final QuizAnswerDto answer;

  @override
  State<_DragTarget> createState() => _DragTargetState();
}

class _DragTargetState extends State<_DragTarget> {
  bool isTargeting = false;

  @override
  void initState() {
    reaction((_) => sl<QuizStore>().selectedAnswer, (selectedAnswer) {
      if (selectedAnswer == null) {
        isTargeting = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = sl<QuizStore>();
    return DragTarget<QuizQuestionDto>(
      onLeave: (data) {
        setState(() {
          isTargeting = false;
        });
      },
      onAcceptWithDetails: (details) {
        store.setSelectedAnswer(widget.answer);
      },
      onWillAcceptWithDetails: (details) {
        setState(() {
          isTargeting = true;
        });
        return true;
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: AksInternal.constants.animationDuration,
          padding: EdgeInsets.only(top: AksInternal.constants.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AksInternal.constants.borderRadius,
            ),
            color: isTargeting ? context.colorScheme.secondary : null,
          ),
          child: Wrap(
            spacing: AksInternal.constants.padding,
            runSpacing: AksInternal.constants.padding,
            children: [
              for (final question
                  in widget.quiz?.questions ?? <QuizQuestionDto>[])
                if (question.correctAnswer?.compareId(widget.answer) ?? false)
                  Observer(
                    builder: (_) {
                      final isAnswered =
                          store.correctAnswers.contains(question) ||
                          store.incorrectAnswers.contains(question);

                      return Container(
                        height: context.height * 0.12,
                        width: context.height * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colorScheme.primary,
                            style:
                                isAnswered
                                    ? BorderStyle.solid
                                    : BorderStyle.solid,
                          ),
                        ),
                        child:
                            isAnswered
                                ? AksCachedImage(
                                  imageUrl: question.picture?.url,
                                  fit: BoxFit.cover,
                                )
                                : null,
                      );
                    },
                  ),
            ],
          ),
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
                (context.width * 0.5 -
                    context.height * 0.12 / 2 -
                    AksInternal.constants.padding * 2) *
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
            child: Observer(
              builder: (_) {
                return Draggable<QuizQuestionDto>(
                  data: currentQuestion,
                  childWhenDragging: Space.empty,
                  maxSimultaneousDrags:
                      sl<QuizStore>().selectedAnswer == null ? 1 : 0,
                  feedback: _QuestionTitleHeader(
                    currentQuestion: currentQuestion,
                  ),
                  child: _QuestionTitleHeader(currentQuestion: currentQuestion),
                );
              },
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
        maxWidth:
            (context.width * 0.5) *
            (context.width < 1000 ? 1.0 : 1000 / context.width),
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
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
