import 'package:aks_internal/aks_internal.dart';
import 'package:quiz/src/data/parse_sdk/dto/quiz_category_dto.dart';

final class QuizCategorySdk extends ParseSdkBase<QuizCategoryDto> {
  QuizCategorySdk() : super(objectConstructor: () => QuizCategoryDto());

  Future<List<QuizCategoryDto>> fetchCategories() async {
    final results = await fetchList(parseQueryBuilder: ParseQueryBuilder());

    return results;
  }
}
