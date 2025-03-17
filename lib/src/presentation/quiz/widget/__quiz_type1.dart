part of '../quiz_screen.dart';

class _QuizType1 extends StatelessWidget {
  _confirmAnswer(BuildContext context) async {
    final store = sl<QuizStore>();
    final isCorrect =
        store.currentQuestion?.correctAnswer?.objectId ==
        store.targetingQuestion?.correctAnswer?.objectId;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AksInternal.constants.padding,
              children: [
                Space.empty,
                AutoSizeText(
                  isCorrect ? context.t.correct : context.t.incorrect,
                ),
                AutoSizeText(
                  isCorrect
                      ? store.currentQuestion?.correctDescription ?? ''
                      : store.currentQuestion?.wrongDescription ?? '',
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).maybePop();
                    sl<QuizStore>().confirmAnswer();
                  },
                  child: AutoSizeText(context.t.next),
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
            Observer(
              builder: (context) {
                final isTargeted = sl<QuizStore>().targetingQuestion != null;

                return _QuizType1Header(
                  quiz: quiz,
                  currentQuestion: currentQuestion,
                  isQuestionVisible: !isTargeted,
                );
              },
            ),
            SizedBox(
              height: context.height * 0.1,
              child: Observer(
                builder: (_) {
                  final isTargeted = sl<QuizStore>().targetingQuestion != null;

                  if (isTargeted) {
                    return Align(
                      child: FilledButton(
                        onPressed: () => _confirmAnswer(context),
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: AksInternal.constants.padding * 3,
                            vertical: AksInternal.constants.padding * 1.4,
                          ),
                        ),
                        child: AutoSizeText(context.t.confirm),
                      ),
                    );
                  }

                  return _DropHereWidget();
                },
              ),
            ),
            _AnswerGroups(quiz: quiz),
          ],
        );
      },
    );
  }
}

class _AnswerGroups extends StatelessWidget {
  const _AnswerGroups({required this.quiz});

  final QuizDto? quiz;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AksInternal.constants.padding,
      runSpacing: AksInternal.constants.padding,
      children: [
        for (final answer in quiz?.answers ?? <QuizAnswerDto>[])
          _AnswersBox(
            title: AutoSizeText(
              answer.title,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Observer(
              builder: (_) {
                final thisAnswerQuestions =
                    quiz?.questions.where(
                      (e) => e.correctAnswer?.compareId(answer) ?? false,
                    ) ??
                    [];

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AksInternal.constants.padding,
                  runSpacing: AksInternal.constants.padding,
                  children: [
                    for (final question in thisAnswerQuestions)
                      _DragTarget(question: question),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}

class _DragTarget extends StatelessWidget {
  const _DragTarget({required this.question});

  final QuizQuestionDto question;

  @override
  Widget build(BuildContext context) {
    return DragTarget<QuizQuestionDto>(
      onAcceptWithDetails: (details) {
        sl<QuizStore>().setTargetingQuestion(question);
      },
      onWillAcceptWithDetails: (details) {
        return sl<QuizStore>().answeredQuestions[question] == null;
      },
      builder: (context, candidateData, rejectedData) {
        return Observer(
          builder: (_) {
            final answeredQuestions = sl<QuizStore>().answeredQuestions;
            final isAnswered = answeredQuestions[question] != null;
            final isTargeting =
                sl<QuizStore>().targetingQuestion?.compareId(question) ?? false;

            if (isAnswered || isTargeting) {
              return Draggable<QuizQuestionDto>(
                maxSimultaneousDrags: isAnswered ? 0 : 1,
                data: isTargeting ? sl<QuizStore>().currentQuestion : null,
                feedback: _QuestionTitleHeader(
                  isFeedback: true,
                  currentQuestion: sl<QuizStore>().currentQuestion,
                ),
                childWhenDragging: _ImagePlaceholder(),
                child: AksCachedImage(
                  imageUrl:
                      isAnswered
                          ? question.picture?.url
                          : isTargeting
                          ? sl<QuizStore>().currentQuestion?.picture?.url
                          : null,
                  height: context.height * 0.12,
                  width: context.height * 0.12,
                ),
              );
            }

            return _ImagePlaceholder();
          },
        );
      },
    );
  }
}

class _QuizType1Header extends StatelessWidget {
  const _QuizType1Header({
    required this.quiz,
    required this.currentQuestion,
    this.isQuestionVisible = true,
  });

  final QuizDto? quiz;
  final QuizQuestionDto? currentQuestion;
  final bool isQuestionVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.height * 0.16 + AksInternal.constants.padding,
      ),
      padding: EdgeInsets.symmetric(
        horizontal:
            (context.width > 1000
                ? (context.width - 1000) / 1.8
                : AksInternal.constants.padding),
      ),
      child: Row(
        children: [
          SizedBox(
            width:
                context.width * 0.5 -
                context.height * 0.16 / 2 -
                (context.width > 1000
                    ? (context.width - 1000) / 1.8
                    : AksInternal.constants.padding),
            child: AutoSizeText(
              quiz?.category?.title ?? '',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Flexible(
            child: Observer(
              builder: (_) {
                if (!isQuestionVisible) {
                  return Space.empty;
                }

                return Draggable<QuizQuestionDto>(
                  data: currentQuestion,
                  childWhenDragging: Row(
                    children: [
                      _ImagePlaceholder(radius: context.height * 0.16),
                      Space.h20,
                      Expanded(child: Space.empty),
                    ],
                  ),
                  feedback: _QuestionTitleHeader(
                    isFeedback: true,
                    currentQuestion: currentQuestion,
                  ),
                  child: _QuestionTitleHeader(
                    currentQuestion: currentQuestion,
                    isFeedback: false,
                  ),
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
  const _QuestionTitleHeader({
    required this.currentQuestion,
    required this.isFeedback,
  });

  final QuizQuestionDto? currentQuestion;
  final bool isFeedback;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          isFeedback
              ? BoxConstraints(maxWidth: context.width * 0.4, maxHeight: 200)
              : BoxConstraints(maxHeight: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AksCachedImage(
              imageUrl: currentQuestion?.picture?.url,
              height: context.height * 0.16,
              width: context.height * 0.16,
            ),
          ),
          Space.h20,
          Expanded(
            child: Observer(
              builder: (_) {
                // TODO Fix height
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentQuestion?.title.trim().isNotEmpty ?? true)
                      Flexible(
                        child: AutoSizeText(
                          currentQuestion?.title ?? '',
                          maxLines: isFeedback ? 4 : 6,
                          minFontSize: 8,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    if (currentQuestion?.description.trim().isNotEmpty ?? true)
                      Flexible(
                        child: AutoSizeText(
                          currentQuestion?.description ?? '',
                          maxLines: isFeedback ? 4 : 6,
                          minFontSize: 8,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (currentQuestion?.text.trim().isNotEmpty ?? true)
                      Flexible(
                        child: AutoSizeText(
                          currentQuestion?.text ?? '',
                          maxLines: isFeedback ? 4 : 6,
                          minFontSize: 8,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
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
