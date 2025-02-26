import 'package:aks_internal/aks_internal.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../data/parse_sdk/dto/quiz_answer_dto.dart';
import '../../../data/parse_sdk/dto/quiz_dto.dart';
import '../../../data/parse_sdk/dto/quiz_question_dto.dart';
import '../../../domain/repository/quiz_repository.dart';
import '../../../service_locator/sl.dart';
import '../../quiz_category/store/quiz_category_store.dart';

part '../../../../generated/src/presentation/quiz/store/quiz_store.g.dart';

@singleton
class QuizStore = _QuizStoreBase with _$QuizStore;

abstract class _QuizStoreBase with Store {
  _QuizStoreBase({required QuizRepository quizRepository}) : _quizRepository = quizRepository {
    quizFetcherStore = DataFetcherStore(
      dataFetcher: () {
        final category = sl<QuizCategoryStore>().selectedCategory;

        return _quizRepository.fetchByCategory(category);
      },
    );

    quizFetcherStore.fetch();

    reaction((_) => currentQuiz, (value) {
      if (value == null) {
        setCurrentQuestion(null);
        return;
      }

      setCurrentQuestion(value.questions.firstOrNull);
    });
  }

  final QuizRepository _quizRepository;
  late final DataFetcherStore<QuizDto> quizFetcherStore;

  @observable
  QuizDto? currentQuiz;

  @action
  setQuiz(QuizDto? value) => currentQuiz = value;

  @observable
  QuizQuestionDto? currentQuestion;

  @action
  setCurrentQuestion(QuizQuestionDto? value) => currentQuestion = value;

  @action
  nextQuestion() {
    if (currentQuestion == null) return;

    final idx = currentQuiz?.questions.indexOf(currentQuestion!) ?? -1;

    if (idx != -1) {
      currentQuestion = currentQuiz?.questions[idx];
    }
  }

  @observable
  List<QuizAnswerDto> correctAnswers = <QuizAnswerDto>[];

  @observable
  List<QuizAnswerDto> incorrectAnswers = <QuizAnswerDto>[];

  @action
  setAnswer(QuizAnswerDto? answer) {
    if (answer == null) return;

    if (currentQuestion?.correctAnswer?.compareId(answer) ?? false) {
      correctAnswers.add(answer);
    } else {
      incorrectAnswers.add(answer);
    }
  }
}
