import 'package:aks_internal/aks_internal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quiz/src/data/parse_sdk/dto/quiz_answer_dto.dart';
import 'package:quiz/src/data/parse_sdk/dto/quiz_dto.dart';

import '../../../common/utils/helper_functions.dart';

class QuizQuestionDto extends ParseObject with ParseObjectEqualityMixin implements ParseCloneable {
  QuizQuestionDto() : super(className);
  QuizQuestionDto.clone() : this();

  String get _titleRu => get<String?>(keyNameRu) ?? '';
  String get _titleTk => get<String?>(keyNameTk) ?? '';
  String get _titleEn => get<String?>(keyNameEn) ?? '';
  String get title => getLocalizedText(ru: _titleRu, tk: _titleTk, en: _titleEn);

  String get _descriptionRu => get<String?>(keyDescriptionRu) ?? '';
  String get _descriptionTk => get<String?>(keyDescriptionTk) ?? '';
  String get _descriptionEn => get<String?>(keyDescriptionEn) ?? '';
  String get description => getLocalizedText(ru: _descriptionRu, tk: _descriptionTk, en: _descriptionEn);

  String get _textRu => get<String?>(keyTextRu) ?? '';
  String get _textTk => get<String?>(keyTextTk) ?? '';
  String get _textEn => get<String?>(keyTextEn) ?? '';
  String get text => getLocalizedText(ru: _textRu, tk: _textTk, en: _textEn);

  QuizAnswerDto? get correctAnswer => get<QuizAnswerDto>(keyCorrectAnswer);
  QuizDto? get quiz => get<QuizDto>(keyQuiz);
  ParseFile? get picture => get<ParseFile?>(keyPicture);

  static const String className = 'QuizQuestion';

  static const String keyNameRu = 'titleRu';
  static const String keyNameTk = 'titleTk';
  static const String keyNameEn = 'titleEn';

  static const String keyDescriptionRu = 'descriptionRu';
  static const String keyDescriptionTk = 'descriptionTk';
  static const String keyDescriptionEn = 'descriptionEn';

  static const String keyTextRu = 'textRu';
  static const String keyTextTk = 'textTk';
  static const String keyTextEn = 'textEn';

  static const String keyPicture = 'picture';
  static const String keyCorrectAnswer = 'correctAnswer';
  static const String keyQuiz = 'quiz';

  @override
  clone(Map<String, dynamic> map) => QuizQuestionDto.clone()..fromJson(map);
}
