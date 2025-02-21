import 'package:aks_internal/aks_internal.dart';

import '../dto/quiz_answer_dto.dart';
import '../dto/quiz_dto.dart';

final class QuizAnswerSdk extends ParseSdkBase<QuizAnswerDto> {
  QuizAnswerSdk() : super(objectConstructor: () => QuizAnswerDto());

  Future<List<QuizAnswerDto>> fetchByQuizList(List<QuizDto>? quizList) async {
    final results = await fetchList(
      parseQueryBuilder: ParseQueryBuilder(
        containedInFilters: [if (quizList != null) ContainedInFilter(column: QuizAnswerDto.keyQuiz, value: quizList)],
      ),
    );

    return results;
  }
}
