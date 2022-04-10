import 'package:flutter/cupertino.dart';
import 'package:flutter_app_quiz_game/Game/Game/campaign_level.dart';
import 'package:flutter_app_quiz_game/Game/Game/game_context.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_config.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/standard_screen.dart';

import 'game_screen.dart';

mixin GameScreenManagerState<TGameContext extends GameContext> {
  @protected
  StandardScreen createMainScreen();

  @protected
  void setCurrentScreenState(StandardScreen statefulWidget);

  @protected
  TGameContext createGameContext(CampaignLevel campaignLevel);

  @protected
  GameScreen getScreenForConfig(TGameContext gameContext,
      QuestionDifficulty difficulty, QuestionCategory category);

  bool goBack(StandardScreen standardScreen);

  void showMainScreen() {
    setCurrentScreenState(createMainScreen());
  }

  void showNewGameScreen(CampaignLevel campaignLevel) {
    TGameContext gameContext = createGameContext(campaignLevel);
    var notPlayedRandomQuestionCategory =
        gameContext.gameUser.getNotPlayedRandomQuestionCategory();
    showGameScreenWithConfig(
        campaignLevel.difficulty, notPlayedRandomQuestionCategory, gameContext);
  }

  void showNextGameScreen(
      CampaignLevel campaignLevel, TGameContext gameContext) {
    debugPrint("gggggxxx");
    showGameScreenWithConfig(campaignLevel.difficulty,
        gameContext.gameUser.getNotPlayedRandomQuestionCategory(), gameContext);
  }

  void showGameScreenWithConfig(QuestionDifficulty difficulty,
      QuestionCategory? category, TGameContext gameContext) {
    setCurrentScreenState(_getScreen(difficulty, category, gameContext));
    debugPrint("ggggg1");
  }

  @protected
  Widget showScreen(StandardScreen? currentScreen) {
    return currentScreen != null
        ? SafeArea(
            child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(child: child, opacity: animation);
            },
            child: currentScreen,
          ))
        : Container();
  }

  StandardScreen getScreenAfterGameOver(QuestionConfig questionConfig) {
    return createMainScreen();
  }

  StandardScreen _getScreen(QuestionDifficulty difficulty,
      QuestionCategory? category, TGameContext gameContext) {
    debugPrint("get screen for config " +
        difficulty.name +
        " " +
        (category?.name ?? "no category"));
    if (category == null) {
      return getScreenAfterGameOver(gameContext.questionConfig);
    } else {
      return getScreenForConfig(gameContext, difficulty, category);
    }
  }
}
