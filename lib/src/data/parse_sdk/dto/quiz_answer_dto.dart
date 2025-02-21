import 'package:aks_internal/aks_internal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../common/utils/helper_functions.dart';
import 'quiz_dto.dart';

class QuizAnswerDto extends ParseObject with ParseObjectEqualityMixin implements ParseCloneable {
  QuizAnswerDto() : super(className);
  QuizAnswerDto.clone() : this();

  String get _titleRu => get<String?>(keyNameRu) ?? '';
  String get _titleTk => get<String?>(keyNameTk) ?? '';
  String get _titleEn => get<String?>(keyNameEn) ?? '';
  String get title => getLocalizedText(ru: _titleRu, tk: _titleTk, en: _titleEn);

  bool get isYes => get<bool?>(keyIsYes) ?? false;

  QuizDto? get quiz => get<QuizDto>(keyQuiz);

  static const String className = 'QuizAnswer';

  static const String keyNameRu = 'titleRu';
  static const String keyNameTk = 'titleTk';
  static const String keyNameEn = 'titleEn';
  static const String keyQuiz = 'quiz';

  static const String keyIsYes = 'isYes';

  @override
  clone(Map<String, dynamic> map) => QuizAnswerDto.clone()..fromJson(map);
}
