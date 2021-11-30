import 'package:flutter_app_quiz_game/Game/Game/game_level.dart';
import 'package:flutter_app_quiz_game/Game/my_app_context.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Constants/history_question_config.dart';

class HistoryGameLevel {
  late GameLevel level_0_0;

  late GameLevel level_0_1;

  static final HistoryGameLevel singleton = HistoryGameLevel.internal();

  factory HistoryGameLevel({required MyAppContext myAppContext}) {
    var questionConfig = HistoryGameQuestionConfig();
    singleton.level_0_0 = GameLevel(
        index: 0,
        name: "level_0_0",
        category: questionConfig.cat0,
        difficulty: questionConfig.diff0);
    singleton.level_0_1 = GameLevel(
        index: 1,
        name: "level_0_1",
        category: questionConfig.cat1,
        difficulty: questionConfig.diff0);
    return singleton;
  }

  HistoryGameLevel.internal();
}