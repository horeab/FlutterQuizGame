import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/Game/campaign_level.dart';
import 'package:flutter_app_quiz_game/Game/Game/campaign_level_service.dart';
import 'package:flutter_app_quiz_game/Game/Game/game_context.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Lib/Ads/ad_service.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/standard_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Storage/game_local_storage.dart';

import 'game_screen_manager_state.dart';

abstract class GameScreen<TGameContext extends GameContext>
    extends StandardScreen {
  GameLocalStorage gameLocalStorage = GameLocalStorage();
  AdService adService = AdService();
  late CampaignLevel campaignLevel;
  TGameContext gameContext;
  QuestionDifficulty difficulty;
  QuestionCategory category;

  GameScreen(
      GameScreenManagerState gameScreenManagerState,
      CampaignLevelService campaignLevelService,
      this.gameContext,
      this.difficulty,
      this.category,
      {Key? key})
      : super(gameScreenManagerState, key: key) {
    this.campaignLevel =
        campaignLevelService.campaignLevel(difficulty, category);
    gameLocalStorage.incrementTotalPlayedQuestions();
  }

  int nrOfQuestionsToShowInterstitialAd();

  void goToNextGameScreen(BuildContext context) {
    var playedQ = gameLocalStorage.getTotalPlayedQuestions();
    var showOnNrOfQ = nrOfQuestionsToShowInterstitialAd();
    adService.showInterstitialAd(
        context, playedQ > 0 && playedQ % showOnNrOfQ == 0, () {
      gameScreenManagerState.showNextGameScreen(campaignLevel, gameContext);
    });
  }

  VoidCallback goToNextGameScreenCallBack(BuildContext context) {
    return () {
      goToNextGameScreen(context);
    };
  }
}
