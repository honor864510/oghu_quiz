part of '../quiz_screen.dart';

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
            // TODO Confirm button if it's placed
            // TOOD Show Space.empty if it's not placed yet
            Observer(
              builder: (_) {
                final isTargeted = sl<QuizStore>().targetingQuestion != null;

                if (isTargeted) {
                  return FilledButton(
                    onPressed: () => sl<QuizStore>().confirmAnswer(),
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: AksInternal.constants.padding * 3,
                        vertical: AksInternal.constants.padding * 1.4,
                      ),
                    ),
                    child: Text('Confirm'),
                  );
                }

                return Text(
                  'Drop text here',
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                );
              },
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
            title: Text(
              answer.title,
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
                if (!isQuestionVisible) {
                  return Space.empty;
                }

                return Draggable<QuizQuestionDto>(
                  data: currentQuestion,
                  childWhenDragging: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          (context.width * 0.5) *
                          (context.width < 1000 ? 1.0 : 1000 / context.width),
                    ),
                    child: Row(
                      children: [
                        _ImagePlaceholder(radius: context.height * 0.16),
                        Space.h20,
                        Expanded(child: Space.empty),
                      ],
                    ),
                  ),
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
