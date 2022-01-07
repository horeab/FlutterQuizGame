import 'package:flutter_app_quiz_game/Game/Question/QuestionCategoryService/question_service.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';

class Question {
  int index;
  QuestionDifficulty difficulty;
  QuestionCategory category;
  String rawString;

  Question(this.index, this.difficulty, this.category, this.rawString);

  QuestionService get questionService =>
      category.questionCategoryService.getQuestionService();

  String get questionToBeDisplayed =>
      questionService.getQuestionToBeDisplayed(this);

  String get correctAnswer =>
      questionService.getCorrectAnswer(this);

  String get questionPrefixToBeDisplayed =>
      questionService.getPrefixToBeDisplayedForQuestion(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          difficulty == other.difficulty &&
          category == other.category &&
          rawString == other.rawString;

  @override
  int get hashCode =>
      index.hashCode ^
      difficulty.hashCode ^
      category.hashCode ^
      rawString.hashCode;

  @override
  String toString() {
    return 'Question{lineInFile: $index, difficulty: $difficulty, category: $category, rawString: $rawString}';
  }
}
