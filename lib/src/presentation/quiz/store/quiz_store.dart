import 'package:aks_internal/aks_internal.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../data/parse_sdk/dto/quiz_dto.dart';
import '../../../data/parse_sdk/sdk/quiz_sdk.dart';
import '../../../service_locator/sl.dart';
import '../../quiz_category/store/quiz_category_store.dart';

part '../../../../generated/src/presentation/quiz/store/quiz_store.g.dart';

@singleton
class QuizStore = _QuizStoreBase with _$QuizStore;

abstract class _QuizStoreBase with Store {
  _QuizStoreBase({required QuizSdk quizSdk}) : _quizSdk = quizSdk {
    quizFetcherStore = DataFetcherStore(
      dataFetcher: () {
        final category = sl<QuizCategoryStore>().selectedCategory;

        return _quizSdk.fetchByCategory(category);
      },
    );

    quizFetcherStore.fetch();
  }

  final QuizSdk _quizSdk;
  late final DataFetcherStore<QuizDto> quizFetcherStore;
}
