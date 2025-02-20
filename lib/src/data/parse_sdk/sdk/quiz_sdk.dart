import 'package:aks_internal/aks_internal.dart';

import '../dto/quiz_category_dto.dart';
import '../dto/quiz_dto.dart';

final class QuizSdk extends ParseSdkBase<QuizDto> {
  QuizSdk() : super(objectConstructor: () => QuizDto());

  Future<List<QuizDto>> fetchByCategory(QuizCategoryDto? category) async {
    final results = await fetchList(
      parseQueryBuilder: ParseQueryBuilder(
        equalsFilters: [if (category != null) EqualsFilter(column: QuizDto.keyCategory, value: category)],
      ),
    );

    return results;
  }
}
