import '../../data/parse_sdk/dto/quiz_category_dto.dart';
import '../../data/parse_sdk/dto/quiz_dto.dart';
import '../../data/parse_sdk/sdk/quiz_answer_sdk.dart';
import '../../data/parse_sdk/sdk/quiz_question_sdk.dart';
import '../../data/parse_sdk/sdk/quiz_sdk.dart';

class QuizRepository {
  final QuizSdk _quizSdk;
  final QuizQuestionSdk _questionSdk;
  final QuizAnswerSdk _answerSdk;

  QuizRepository({required QuizSdk quizSdk, required QuizQuestionSdk questionSdk, required QuizAnswerSdk answerSdk})
    : _quizSdk = quizSdk,
      _questionSdk = questionSdk,
      _answerSdk = answerSdk;

  Future<List<QuizDto>> fetchByCategory(QuizCategoryDto? category) async {
    final quizList = await _quizSdk.fetchByCategory(category);
    final answers = await _answerSdk.fetchByQuizList(quizList);
    final questions = await _questionSdk.fetchByQuizList(quizList);

    final fullQuiz =
        quizList
            .map((quiz) {
              final thisAnswers = answers.where((answer) => answer.quiz?.compareId(quiz) ?? false);

              if (thisAnswers.isNotEmpty) {
                quiz.answers = thisAnswers.toList();
              }

              return quiz;
            })
            .map((quiz) {
              final thisQuestions = questions.where((answer) => answer.quiz?.compareId(quiz) ?? false);

              if (thisQuestions.isNotEmpty) {
                quiz.questions = thisQuestions.toList();
              }

              return quiz;
            })
            .toList();

    return fullQuiz;
  }
}
