import 'package:aks_internal/aks_internal.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:quiz/src/data/parse_sdk/dto/quiz_category_dto.dart';

import '../../../data/parse_sdk/sdk/quiz_category_sdk.dart';

part '../../../../generated/src/presentation/quiz_category/store/quiz_category_store.g.dart';

@singleton
class QuizCategoryStore = _QuizCategoryStoreBase with _$QuizCategoryStore;

abstract class _QuizCategoryStoreBase with Store {
  _QuizCategoryStoreBase({required QuizCategorySdk categorySdk}) : _categorySdk = categorySdk {
    categoryFetcherStore = DataFetcherStore(dataFetcher: _categorySdk.fetchCategories);
    categoryFetcherStore.fetch();
  }

  final QuizCategorySdk _categorySdk;
  late final DataFetcherStore<QuizCategoryDto> categoryFetcherStore;

  @observable
  QuizCategoryDto? selectedCategory;

  @action
  setSelectedCategory(QuizCategoryDto? value) => selectedCategory = value;
}
