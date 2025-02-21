import 'package:aks_internal/aks_internal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../common/utils/helper_functions.dart';
import 'quiz_answer_dto.dart';
import 'quiz_category_dto.dart';
import 'quiz_question_dto.dart';

class QuizDto extends ParseObject with ParseObjectEqualityMixin implements ParseCloneable {
  QuizDto() : super(className);
  QuizDto.clone() : this();

  String get _titleRu => get<String?>(keyNameRu) ?? '';
  String get _titleTk => get<String?>(keyNameTk) ?? '';
  String get _titleEn => get<String?>(keyNameEn) ?? '';
  String get title => getLocalizedText(ru: _titleRu, tk: _titleTk, en: _titleEn);

  QuizType get type => QuizType.values.elementAtOrNull(get<int>(keyType) ?? 0) ?? QuizType.yesNo;

  QuizCategoryDto? get category => get<QuizCategoryDto>(keyCategory);
  ParseFileBase? get picture => get<ParseFileBase?>(keyPicture);

  List<QuizQuestionDto> get questions => get<List<QuizQuestionDto>?>(keyQuestions) ?? [];
  set questions(List<QuizQuestionDto>? value) => set<List<QuizQuestionDto>?>(keyQuestions, value);

  List<QuizAnswerDto> get answers => get<List<QuizAnswerDto>?>(keyAnswers) ?? [];
  set answers(List<QuizAnswerDto>? value) => set<List<QuizAnswerDto>?>(keyAnswers, value);

  static const String className = 'Quiz';

  static const String keyNameRu = 'titleRu';
  static const String keyNameTk = 'titleTk';
  static const String keyNameEn = 'titleEn';

  static const String keyCategory = 'category';
  static const String keyPicture = 'picture';
  static const String keyType = 'type';
  static const String keyQuestions = 'questions';
  static const String keyAnswers = 'answers';

  @override
  clone(Map<String, dynamic> map) => QuizDto.clone()..fromJson(map);
}

enum QuizType { yesNo }
