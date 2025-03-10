import 'package:aks_internal/aks_internal.dart';
import 'package:auto_route/annotations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/parse_sdk/dto/quiz_answer_dto.dart';
import '../../data/parse_sdk/dto/quiz_dto.dart';
import '../../data/parse_sdk/dto/quiz_question_dto.dart';
import '../../service_locator/sl.dart';
import 'store/quiz_store.dart';

part 'widget/__answers_box.dart';
part 'widget/__image_placeholder.dart';
part 'widget/__quiz_type1.dart';

@RoutePage()
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quiz});

  final QuizDto quiz;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    sl<QuizStore>().setQuiz(widget.quiz);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [if (widget.quiz.type == QuizType.yesNo) _QuizType1()],
      ),
    );
  }
}
