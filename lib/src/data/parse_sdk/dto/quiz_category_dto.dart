import 'package:aks_internal/aks_internal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../common/utils/helper_functions.dart';

class QuizCategoryDto extends ParseObject with ParseObjectEqualityMixin implements ParseCloneable {
  QuizCategoryDto() : super(className);
  QuizCategoryDto.clone() : this();

  String get _titleRu => get<String?>(keyNameRu) ?? '';
  String get _titleTk => get<String?>(keyNameTk) ?? '';
  String get _titleEn => get<String?>(keyNameEn) ?? '';
  String get title => getLocalizedText(ru: _titleRu, tk: _titleTk, en: _titleEn);

  static const String className = 'QuizCategory';

  static const String keyNameRu = 'titleRu';
  static const String keyNameTk = 'titleTk';
  static const String keyNameEn = 'titleEn';

  @override
  clone(Map<String, dynamic> map) => QuizCategoryDto.clone()..fromJson(map);
}
