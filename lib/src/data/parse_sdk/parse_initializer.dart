import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'dto/quiz_answer_dto.dart';
import 'dto/quiz_category_dto.dart';
import 'dto/quiz_dto.dart';
import 'dto/quiz_question_dto.dart';

mixin ParseInitializer {
  static Future<void> init() async {
    await Parse().initialize(
      dotenv.env['PARSE_APP_ID']!,
      dotenv.env['PARSE_SERVER_URL']!,
      clientKey: dotenv.env['PARSE_CLIENT_KEY']!,
      debug: kDebugMode,
      registeredSubClassMap: <String, ParseObjectConstructor>{
        QuizDto.className: () => QuizDto(),
        QuizAnswerDto.className: () => QuizAnswerDto(),
        QuizCategoryDto.className: () => QuizCategoryDto(),
        QuizQuestionDto.className: () => QuizQuestionDto(),
      },
    );
  }
}
