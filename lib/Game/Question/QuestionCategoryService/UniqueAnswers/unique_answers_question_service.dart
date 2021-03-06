import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';
import 'package:flutter_app_quiz_game/Game/Question/QuestionCategoryService/UniqueAnswers/unique_answers_question_parser.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/string_extension.dart';

import '../Base/question_service.dart';

class UniqueAnswersQuestionService extends QuestionService {
  late UniqueAnswersQuestionParser questionParser;

  static final UniqueAnswersQuestionService singleton =
      UniqueAnswersQuestionService.internal();

  factory UniqueAnswersQuestionService(
      {required UniqueAnswersQuestionParser questionParser}) {
    singleton.questionParser = questionParser;
    return singleton;
  }

  UniqueAnswersQuestionService.internal();

  @override
  String getQuestionToBeDisplayed(Question question) {
    return questionParser.getQuestionToBeDisplayed(question);
  }

  @override
  List<String> getCorrectAnswers(Question question) {
    int correctAnswer = questionParser
        .getCorrectAnswersFromRawString(question)
        .first
        .parseToInt;
    List<String> answerOptions = getAllAnswerOptionsForQuestionAsList(question);
    return [answerOptions[correctAnswer]];
  }

  @override
  String getRandomUnpressedCorrectAnswerFromQuestion(
      Question question, Set<String> pressedAnswers) {
    return getUnpressedCorrectAnswers(question, pressedAnswers).first;
  }

  @override
  Set<String> getQuizAnswerOptions(Question question) {
    return getAllAnswerOptionsForQuestionAsList(question).toSet();
  }

  List<String> getAllAnswerOptionsForQuestionAsList(Question question) {
    return question.rawString
        .split("::")[1]
        .split("##")
        .map((e) => e.trim().capitalized)
        .where((element) => element.isNotEmpty)
        .toList();
  }
}
