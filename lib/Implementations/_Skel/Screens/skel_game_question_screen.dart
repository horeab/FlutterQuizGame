import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Implementations/_Skel/Constants/skel_campaign_level_service.dart';
import 'package:flutter_app_quiz_game/Implementations/_Skel/Questions/skel_game_context.dart';
import 'package:flutter_app_quiz_game/Implementations/_Skel/Service/skel_game_screen_manager.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/quiz_question_game_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/screen_state.dart';

class SkelQuestionScreen
    extends GameScreen<SkelGameContext, SkelGameScreenManagerState> {
  SkelQuestionScreen(
    SkelGameScreenManagerState gameScreenManagerState, {
    Key? key,
    required QuestionDifficulty difficulty,
    required QuestionCategory category,
    required SkelGameContext gameContext,
  }) : super(
            gameScreenManagerState,
            SkelCampaignLevelService(),
            gameContext,
            difficulty,
            category,
            [gameContext.gameUser.getRandomQuestion(difficulty, category)],
            key: key);

  @override
  State<SkelQuestionScreen> createState() => SkelQuestionScreenState();

  @override
  int nrOfQuestionsToShowInterstitialAd() {
    return 8;
  }
}

class SkelQuestionScreenState extends State<SkelQuestionScreen>
    with ScreenState, QuizQuestionContainer {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void setStateCallback() {
    setState(() {});
  }
}