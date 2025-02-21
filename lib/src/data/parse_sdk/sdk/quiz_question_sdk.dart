import 'package:aks_internal/aks_internal.dart';

import '../dto/quiz_dto.dart';
import '../dto/quiz_question_dto.dart';

final class QuizQuestionSdk extends ParseSdkBase<QuizQuestionDto> {
  QuizQuestionSdk() : super(objectConstructor: () => QuizQuestionDto());

  Future<List<QuizQuestionDto>> fetchByQuizList(List<QuizDto>? quizList) async {
    final results = await fetchList(
      parseQueryBuilder: ParseQueryBuilder(
        containedInFilters: [if (quizList != null) ContainedInFilter(column: QuizQuestionDto.keyQuiz, value: quizList)],
        keysToInclude: [QuizQuestionDto.keyCorrectAnswer],
      ),
    );

    return results;
  }
}
