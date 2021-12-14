import 'package:flutter/cupertino.dart';
import 'package:flutter_app_quiz_game/Game/Game/campaign_level.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Constants/history_game_question_config.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Questions/history_game_context.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Screens/history_game_question_screen.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Screens/history_game_timeline_screen.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Screens/history_main_menu_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/game_screen_manager.dart';

import 'history_gamecontext_service.dart';

class HistoryGameScreenManager extends GameScreenManager<HistoryGameContext> {
  static final HistoryGameScreenManager singleton =
      HistoryGameScreenManager.internal();

  factory HistoryGameScreenManager({required BuildContext buildContext}) {
    singleton.buildContext = buildContext;
    return singleton;
  }

  HistoryGameScreenManager.internal();

@override
  StatefulWidget getMainScreen() {
    return HistoryMainMenuScreen();
  }
  @override
  StatefulWidget getScreenForConfig(
      HistoryGameContext gameContext,
      QuestionDifficulty difficulty,
      QuestionCategory category,
      VoidCallback refreshMainScreenCallback) {
    StatefulWidget goToScreen;
    var questionConfig = HistoryGameQuestionConfig();
    //
    ////
    // category = questionConfig.cat1;
    ////
    //
    if ([questionConfig.cat0, questionConfig.cat1].contains(category)) {
      goToScreen = HistoryGameTimelineScreen(
        gameContext: gameContext,
        difficulty: difficulty,
        category: category,
        refreshMainScreenCallback: refreshMainScreenCallback,
      );
    } else {
      goToScreen = HistoryGameQuestionScreen(
        gameContext: gameContext,
        difficulty: difficulty,
        category: category,
        refreshMainScreenCallback: refreshMainScreenCallback,
      );
    }
    return goToScreen;
  }

  @override
  HistoryGameContext createGameContext(CampaignLevel campaignLevel) {
    return HistoryGameContextService().createGameContext(campaignLevel);
  }
}