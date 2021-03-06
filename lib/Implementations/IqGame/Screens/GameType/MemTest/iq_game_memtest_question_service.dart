import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';
import 'package:flutter_app_quiz_game/Game/Question/QuestionCategoryService/Base/question_service.dart';

class IqGameMemTestQuestionService extends QuestionService {
  static const int allAnswersPressedCorrectly = 1;
  static const int notAllAnswersPressedCorrectly = -1;

  static final IqGameMemTestQuestionService singleton =
      IqGameMemTestQuestionService.internal();

  factory IqGameMemTestQuestionService() {
    return singleton;
  }

  IqGameMemTestQuestionService.internal();

  @override
  String getQuestionToBeDisplayed(Question question) {
    throw UnimplementedError();
  }

  @override
  List<String> getCorrectAnswers(Question question) {
    return [allAnswersPressedCorrectly.toString()];
  }

  @override
  Set<String> getQuizAnswerOptions(Question question) {
    throw UnimplementedError();
  }
}
