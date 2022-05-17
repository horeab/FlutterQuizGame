import 'package:flutter/cupertino.dart';
import 'package:flutter_app_quiz_game/Game/Game/campaign_level.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Questions/iq_game_context.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/GameType/IqTest/iq_game_iq_test_game_type_creator.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/GameType/Spatial/iq_game_spatial_game_type_creator.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/GameType/iq_game_game_type_creator.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/iq_game_game_over_screen.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/iq_game_main_menu_screen.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Screens/iq_game_question_screen.dart';
import 'package:flutter_app_quiz_game/Implementations/IqGame/Service/iq_game_gamecontext_service.dart';
import 'package:flutter_app_quiz_game/Lib/Popup/rate_app_popup.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen_manager.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen_manager_state.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/standard_screen.dart';

import '../Constants/iq_game_question_config.dart';

class IqGameScreenManager extends GameScreenManager {
  IqGameScreenManager({Key? key}) : super(key: key);

  @override
  State<IqGameScreenManager> createState() => IqGameScreenManagerState();
}

class IqGameScreenManagerState extends State<IqGameScreenManager>
    with GameScreenManagerState<IqGameContext> {
  @override
  void initState() {
    super.initState();
    RatePopupService ratePopupService = RatePopupService(buildContext: context);
    ratePopupService.showRateAppPopup();

    showMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return createScreen(widget.currentScreen);
  }

  @override
  bool goBack(StandardScreen standardScreen) {
    if (standardScreen.runtimeType == IqGameMainMenuScreen) {
      return true;
    } else {
      showMainScreen();
      return false;
    }
  }

  @override
  StandardScreen createMainScreen() {
    return IqGameMainMenuScreen(
      this,
      key: UniqueKey(),
    );
  }

  StandardScreen createGameOverScreen(IqGameContext gameContext) {
    return IqGameGameOverScreen(
        getGameTypeCreator(gameContext.questionConfig.categories.first),
        gameContext,
        this);
  }

  @override
  void setCurrentScreenState(StandardScreen statefulWidget) {
    setState(() {
      widget.currentScreen = statefulWidget;
    });
  }

  @override
  @protected
  GameScreen getScreenForConfig(
    IqGameContext gameContext,
    QuestionDifficulty difficulty,
    QuestionCategory category,
  ) {
    return IqGameQuestionScreen(getGameTypeCreator(category), this,
        key: UniqueKey(),
        gameContext: gameContext,
        category: category,
        difficulty: difficulty);
  }

  @override
  StandardScreen getScreenAfterGameOver(IqGameContext gameContext) {
    return createGameOverScreen(gameContext);
  }

  IqGameGameTypeCreator getGameTypeCreator(QuestionCategory category) {
    IqGameGameTypeCreator? creator;
    IqGameQuestionConfig questionConfig = IqGameQuestionConfig();
    if (category == questionConfig.cat0) {
      creator = IqGameIqTestGameTypeCreator();
    } else if (category == questionConfig.cat1) {
      creator = IqGameSpatialGameTypeCreator();
    }
    if (creator == null) {
      throw UnsupportedError(
          "Category " + category.name + " has no game creator configured!");
    }
    return creator;
  }

  @override
  @protected
  IqGameContext createGameContext(CampaignLevel campaignLevel) {
    return IqGameContextService().createGameContext(campaignLevel);
  }
}