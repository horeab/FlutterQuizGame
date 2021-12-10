import 'dart:core';

import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';

import '../question_collector_service.dart';

abstract class QuestionParser {
  final QuestionCollectorService questionCollectorService =
      QuestionCollectorService();

  //We return a list in case of multiple correct answers
  List<String> getCorrectAnswersFromRawString(String questionString);

  String getQuestionToBeDisplayed(String questionRawString);

  bool isQuestionValid(Question question) {
    return true;
  }
}
