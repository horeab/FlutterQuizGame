import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/string_extension.dart';
import 'package:flutter_app_quiz_game/Lib/Storage/my_local_storage.dart';

import '../../main.dart';

abstract class QuizGameLocalStorage extends MyLocalStorage {
  List<QuestionKey> getWonQuestionsForDiff(QuestionDifficulty diff) {
    return decodeStringQuestionList(_getWonQuestionsFieldName(diff));
  }

  List<QuestionKey> getWonQuestionsForCat(QuestionCategory cat) {
    return MyApp.appId.gameConfig.gameQuestionConfig.difficulties
        .map((diff) => getWonQuestionsForDiffAndCat(diff, cat))
        .expand((i) => i)
        .toList();
  }

  List<QuestionKey> getWonQuestionsForDiffAndCat(
      QuestionDifficulty diff, QuestionCategory cat) {
    return getWonQuestionsForDiff(diff)
        .where((element) => element.cat == cat)
        .toList();
  }

  List<QuestionKey> decodeStringQuestionList(String fieldName) =>
      (localStorage.getStringList(fieldName) ?? [])
          .map((e) => QuestionKey.decode(e))
          .toList();

  List<QuestionKey> getLostQuestions(QuestionDifficulty diff) {
    return decodeStringQuestionList(_getLostQuestionsFieldName(diff));
  }

  int getRemainingHintsForCatDiff(
      QuestionCategory cat, QuestionDifficulty diff) {
    return localStorage
            .getInt(_getRemainingHintsForCatDiffFieldName(cat, diff)) ??
        -1;
  }

  void setRemainingHintsForCatDiff(
      QuestionCategory cat, QuestionDifficulty diff, int hints) {
    if (hints >= 0) {
      localStorage.setInt(
          _getRemainingHintsForCatDiffFieldName(cat, diff), hints);
    }
  }

  int getRemainingHintsForDiff(QuestionDifficulty diff) {
    return localStorage.getInt(_getRemainingHintsForDiffFieldName(diff)) ?? -1;
  }

  void setRemainingHintsForDiff(QuestionDifficulty diff, int hints) {
    if (hints >= 0) {
      localStorage.setInt(_getRemainingHintsForDiffFieldName(diff), hints);
    }
  }

  int getTotalWonQuestions(QuestionDifficulty diff) {
    return localStorage.getInt(_getTotalWonQuestionsFieldName(diff)) ?? 0;
  }

  void setTotalWonQuestions(QuestionDifficulty diff, int val) {
    localStorage.setInt(_getTotalWonQuestionsFieldName(diff), val);
  }

  void setLostQuestion(Question question) {
    updateList(
        question.difficulty,
        question.category,
        question.index,
        getLostQuestions(question.difficulty),
        _getLostQuestionsFieldName(question.difficulty));
  }

  void setWonQuestion(Question question) {
    List<QuestionKey> list = getWonQuestionsForDiff(question.difficulty);
    updateList(question.difficulty, question.category, question.index, list,
        _getWonQuestionsFieldName(question.difficulty));
    if (list.length > getTotalWonQuestions(question.difficulty)) {
      setTotalWonQuestions(question.difficulty, list.length);
    }
  }

  void updateList(QuestionDifficulty diff, QuestionCategory cat, int qIndex,
      List<QuestionKey> list, String fieldName) {
    var qKey = QuestionKey(cat, diff, qIndex);
    if (!list.contains(qKey)) {
      list.add(qKey);
      localStorage.setStringList(
          fieldName, list.map((e) => e.encode()).toList());
    }
  }

  String _getWonQuestionsFieldName(QuestionDifficulty difficulty) {
    return localStorageName + "_" + difficulty.name + "_finishedQ";
  }

  String _getLostQuestionsFieldName(QuestionDifficulty difficulty) {
    return localStorageName + "_" + difficulty.name + "_finishedLostQ";
  }

  String _getTotalWonQuestionsFieldName(QuestionDifficulty difficulty) {
    return localStorageName + "_" + difficulty.name + "_TotalWonQuestions";
  }

  String _getRemainingHintsForDiffFieldName(QuestionDifficulty difficulty) {
    return localStorageName + "_" + difficulty.name + "_RemainingHints";
  }

  String _getRemainingHintsForCatDiffFieldName(
      QuestionCategory cat, QuestionDifficulty difficulty) {
    return localStorageName +
        "_" +
        cat.name +
        "_" +
        difficulty.name +
        "_RemainingHints";
  }

  void clearAll() {
    for (var diff in MyApp.appId.gameConfig.questionDifficulties) {
      for (var cat in MyApp.appId.gameConfig.questionCategories) {
        resetHintsForCatDiff(cat, diff);
      }
      resetHintsForDiff(diff);
      resetLevelQuestions(diff);
      localStorage.setInt(_getTotalWonQuestionsFieldName(diff), 0);
    }
  }

  void resetHintsForCatDiff(QuestionCategory cat, QuestionDifficulty diff) {
    localStorage.setInt(_getRemainingHintsForCatDiffFieldName(cat, diff), -1);
  }

  void resetHintsForDiff(QuestionDifficulty diff) {
    localStorage.setInt(_getRemainingHintsForDiffFieldName(diff), -1);
  }

  void resetLevelQuestions(QuestionDifficulty diff) {
    localStorage.setStringList(_getWonQuestionsFieldName(diff), []);
  }
}

class QuestionKey {
  QuestionCategory cat;
  QuestionDifficulty diff;
  int index;

  QuestionKey(this.cat, this.diff, this.index);

  static QuestionKey decode(String encoded) {
    var split = encoded.split("_");
    var gameConfig = MyApp.appId.gameConfig;
    QuestionCategory cat =
        gameConfig.questionCategories.firstWhere((e) => e.name == split[0]);
    QuestionDifficulty diff =
        gameConfig.questionDifficulties.firstWhere((e) => e.name == split[1]);
    return QuestionKey(cat, diff, split[2].parseToInt);
  }

  String encode() {
    return cat.name + "_" + diff.name + "_" + index.toString();
  }

  @override
  String toString() {
    return cat.name + "_" + diff.name + "_" + index.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionKey &&
          runtimeType == other.runtimeType &&
          cat == other.cat &&
          diff == other.diff &&
          index == other.index;

  @override
  int get hashCode => cat.hashCode ^ diff.hashCode ^ index.hashCode;
}
