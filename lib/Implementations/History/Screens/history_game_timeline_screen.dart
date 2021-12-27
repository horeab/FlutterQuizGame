import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_info.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_info_status.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Components/history_game_level_header.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Constants/history_campaign_level_service.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Constants/history_game_question_config.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Questions/history_game_context.dart';
import 'package:flutter_app_quiz_game/Implementations/History/Service/history_game_local_storage.dart';
import 'package:flutter_app_quiz_game/Lib/Animation/animation_zoom_in_zoom_out.dart';
import 'package:flutter_app_quiz_game/Lib/Button/my_button.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/int_extension.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/list_extension.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/map_extension.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/game_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/game_screen_manager_state.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/screen_state.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/standard_screen.dart';
import 'package:flutter_app_quiz_game/Lib/Text/my_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../Lib/Button/button_skin_config.dart';
import '../../../Lib/Font/font_config.dart';

class HistoryGameTimelineScreen extends StandardScreen
    with GameScreen<HistoryGameContext> {
  static final int show_interstitial_ad_every_n_questions = 5;
  static final int default_questions_to_play_until_next_category = 3;
  int questionsToPlayUntilNextCategory =
      default_questions_to_play_until_next_category;

  HistoryLocalStorage historyLocalStorage = HistoryLocalStorage();
  late QuestionInfo? currentQuestionInfo;

  Map<int, HistoryQuestion> questions = HashMap<int, HistoryQuestion>();
  bool correctAnswerPressed = false;
  bool alreadyWentToNextScreen = false;
  bool animateQuestionText = false;

  HistoryGameTimelineScreen(
    GameScreenManagerState gameScreenManagerState, {
    Key? key,
    required QuestionDifficulty difficulty,
    required QuestionCategory category,
    required HistoryGameContext gameContext,
  }) : super(gameScreenManagerState, key: key) {
    initScreen(
      HistoryCampaignLevelService(),
      gameContext,
      difficulty,
      category,
    );

    currentQuestionInfo =
        gameContext.gameUser.getRandomQuestion(difficulty, category);
    gameLocalStorage.incrementTotalPlayedQuestions();
  }

  @override
  State<HistoryGameTimelineScreen> createState() =>
      HistoryGameTimelineScreenState();
}

class HistoryQuestion {
  Image image;
  MyButton button;
  bool? correctAnswer;
  String question;
  int questionIndex;

  HistoryQuestion(this.image, this.button, this.correctAnswer, this.question,
      this.questionIndex);
}

class HistoryGameTimelineScreenState extends State<HistoryGameTimelineScreen>
    with ScreenState {
  ItemScrollController itemScrollController = ItemScrollController();
  late Image timelineOptUnknown;
  late Image histAnswWrong;
  late Image arrowRight;

  @override
  void initState() {
    super.initState();
    initScreen(onUserEarnedReward: () {
      onHintButtonClick();
    });

    timelineOptUnknown = imageService.getSpecificImage(
        maxWidth: getImageWidth(), imageName: "timeline_opt_unknown");
    histAnswWrong = imageService.getSpecificImage(
        maxWidth: getImageWidth(), imageName: "hist_answ_wrong");
    arrowRight = imageService.getSpecificImage(
        imageName: "arrow_right", maxWidth: screenDimensions.w(10));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(timelineOptUnknown.image, context);
    precacheImage(histAnswWrong.image, context);
    precacheImage(arrowRight.image, context);
  }

  @override
  Widget build(BuildContext context) {
    var allQuestionsForConfig = widget.gameContext.gameUser
        .getAllQuestionsForConfig(widget.difficulty, widget.category);
    allQuestionsForConfig
        .sort((a, b) => a.question.index.compareTo(b.question.index));
    var levelsWon = allQuestionsForConfig
        .where((element) => element.status == QuestionInfoStatus.WON)
        .map((e) => e.question.index)
        .toList();
    var levelsLost = allQuestionsForConfig
        .where((element) => element.status == QuestionInfoStatus.LOST)
        .map((e) => e.question.index)
        .toList();

    int zoomInZoomOutAnswerDuration = 500;
    Size answerBtnSize = getButtonSizeForCat();

    for (QuestionInfo qi in allQuestionsForConfig) {
      var disabled = false;

      bool? correctAnswer;
      Color enabledAnswerBtnBackgroundColor = Colors.lightBlueAccent;
      Color disabledAnswerBtnBackgroundColor = enabledAnswerBtnBackgroundColor;
      var qIndex = qi.question.index;
      if (levelsWon.contains(qIndex)) {
        correctAnswer = true;
        disabledAnswerBtnBackgroundColor = Colors.green.shade200;
        disabled = true;
      } else if (levelsLost.contains(qIndex)) {
        correctAnswer = false;
        disabledAnswerBtnBackgroundColor = Colors.red.shade300;
        disabled = true;
      }

      var questionAnswer = qi.question.rawString.split(":")[1];
      String? correctAnswerText =
          widget.currentQuestionInfo?.question.rawString.split(":")[1];

      if (shouldGoToNextGameScreen()) {
        disabled = true;
        if (!widget.alreadyWentToNextScreen) {
          widget.alreadyWentToNextScreen = true;
          Future.delayed(
              Duration(milliseconds: zoomInZoomOutAnswerDuration * 2),
              () => goToNextGameScreen(context));
        }
      }

      MyButton answerBtn = createAnswerButton(
          answerBtnSize,
          disabled,
          enabledAnswerBtnBackgroundColor,
          disabledAnswerBtnBackgroundColor,
          correctAnswerText == null ? "" : getOptionText(correctAnswerText),
          getOptionText(questionAnswer));
      var imgRatio = 1.3;
      var maxHeight = answerBtnSize.height * imgRatio;
      Image image = createImageForQuestion(qIndex, maxHeight, levelsLost);
      widget.questions[qIndex] = HistoryQuestion(
          image, answerBtn, correctAnswer, questionAnswer, qIndex);
    }

    HistoryGameLevelHeader header = createHeader(levelsWon, levelsLost);

    ScrollablePositionedList listView =
        createListView(answerBtnSize, zoomInZoomOutAnswerDuration);

    var mainColumn = Column(
      children: <Widget>[header, Expanded(child: listView)],
    );

    return mainColumn;
  }

  Image createImageForQuestion(
      int qIndex, double maxHeight, List<int> levelsLost) {
    Image image = widget.gameContext.shownImagesForTimeLineHints
            .getOrDefault<QuestionCategory, List<int>>(
                widget.category, []).contains(qIndex)
        ? imageService.getSpecificImage(
            maxWidth: getImageWidth(),
            maxHeight: maxHeight,
            imageName: "i" + qIndex.toString(),
            module: getQuestionImagePath(widget.difficulty, widget.category))
        : levelsLost.contains(qIndex)
            ? histAnswWrong
            : timelineOptUnknown;
    return image;
  }

  ScrollablePositionedList createListView(
      Size answerBtnSize, int zoomInZoomOutAnswerDuration) {
    ScrollablePositionedList listView = ScrollablePositionedList.builder(
      physics: ClampingScrollPhysics(),
      itemCount: widget.questions.length,
      itemScrollController: itemScrollController,
      itemBuilder: (BuildContext context, int index) {
        HistoryQuestion question =
            getSortedYearValues().elementAt(getRevertedIndex(index));

        if (widget.category == HistoryGameQuestionConfig().cat0) {
          return createOptionItemCat0(
              question.button,
              answerBtnSize,
              question.correctAnswer,
              question.image,
              question.questionIndex,
              zoomInZoomOutAnswerDuration);
        } else {
          return createOptionItemCat1(
              question.button,
              answerBtnSize,
              question.correctAnswer,
              question.image,
              question.questionIndex,
              zoomInZoomOutAnswerDuration);
        }
      },
    );
    return listView;
  }

  List<HistoryQuestion> getSortedYearValues() {
    List<HistoryQuestion> list = List.of(widget.questions.values);
    list.sort((a, b) => a.questionIndex.compareTo(b.questionIndex));
    return list;
  }

  int getRevertedIndex(int index) => widget.questions.length - index - 1;

  HistoryGameLevelHeader createHeader(
      List<int> levelsWon, List<int> levelsLost) {
    QuestionInfo? mostRecentQ = getMostRecentAnswered();

    var header = HistoryGameLevelHeader(
      onBackButtonClick: () {
        widget.gameScreenManagerState.goBack(widget);
      },
      campaignLevel: widget.campaignLevel,
      questionContainerHeight: screenDimensions.h(18),
      availableHints: widget.gameContext.amountAvailableHints,
      question: shouldGoToNextGameScreen()
          ? mostRecentQ?.question
          : widget.currentQuestionInfo?.question,
      animateScore: widget.correctAnswerPressed,
      animateQuestionText: widget.animateQuestionText &&
          widget.questionsToPlayUntilNextCategory != 0,
      score: formatTextWithOneParam(
          label.l_score_param0,
          widget.historyLocalStorage
                  .getWonQuestions(widget.difficulty)
                  .length
                  .toString() +
              "/" +
              widget.gameContext.totalNrOfQuestionsForCampaignLevel.toString()),
      hintButtonOnClick: () {
        if (widget.currentQuestionInfo != null) {
          onHintButtonClick();
        }
      },
    );
    return header;
  }

  bool shouldGoToNextGameScreen() {
    return widget.currentQuestionInfo == null ||
        widget.questionsToPlayUntilNextCategory == 0;
  }

  void goToNextGameScreen(BuildContext context) {
    var playedQ = widget.gameLocalStorage.getTotalPlayedQuestions();
    var showOnNrOfQ =
        HistoryGameTimelineScreen.show_interstitial_ad_every_n_questions;
    adService.showInterstitialAd(
        context, playedQ > 0 && playedQ % showOnNrOfQ == 0, () {
      widget.gameScreenManagerState
          .showNextGameScreen(widget.campaignLevel, widget.gameContext);
    });
  }

  MyButton createAnswerButton(
      Size answerBtnSize,
      bool disabled,
      Color enabledBackgroundColor,
      Color disabledBackgroundColor,
      String correctAnswerOptionText,
      String optionTextToDisplay) {
    var answerBtn = MyButton(
        size: answerBtnSize,
        disabled: disabled,
        disabledBackgroundColor: disabledBackgroundColor,
        onClick: () {
          if (widget.currentQuestionInfo != null) {
            var currentQuestionInfo = widget.currentQuestionInfo!;
            int questionIndex = currentQuestionInfo.question.index;
            setState(() {
              if (correctAnswerOptionText == optionTextToDisplay) {
                audioPlayer.playSuccess();
                var imagesForTimeLineHints =
                    widget.gameContext.shownImagesForTimeLineHints;
                imagesForTimeLineHints
                    .putIfAbsent(widget.category, () => [])
                    .add(questionIndex);
                widget.gameContext.gameUser.setWonQuestion(currentQuestionInfo);
                widget.correctAnswerPressed = true;
                widget.historyLocalStorage
                    .setWonQuestion(currentQuestionInfo.question);
              } else {
                audioPlayer.playFail();
                var values = getSortedYearValues();
                itemScrollController.scrollTo(
                    index: getRevertedIndex(values.toList().indexOf(
                        values.firstWhere((element) =>
                            element.questionIndex == questionIndex))),
                    duration: Duration(milliseconds: 600));
                widget.gameContext.gameUser
                    .setLostQuestion(currentQuestionInfo);
                widget.correctAnswerPressed = false;
              }
            });
            widget.animateQuestionText = true;
            widget.questionsToPlayUntilNextCategory--;
            widget.currentQuestionInfo = widget.gameContext.gameUser
                .getRandomQuestion(widget.difficulty, widget.category);
          }
        },
        buttonSkinConfig: ButtonSkinConfig(
            borderColor: Colors.blue.shade600,
            backgroundColor: enabledBackgroundColor),
        fontConfig: FontConfig(),
        customContent: getOptionContentCat(optionTextToDisplay));
    return answerBtn;
  }

  String getQuestionImagePath(
          QuestionDifficulty difficulty, QuestionCategory category) =>
      "questions/images/" + difficulty.name + "/" + category.name;

  double getImageWidth() {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      return screenDimensions.w(30);
    } else {
      return screenDimensions.w(20);
    }
  }

  int getHistoryEraYear(List<String> optionStrings, int index) {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      return int.parse(optionStrings[index]);
    } else {
      return getYear2ForCat1(optionStrings[index].split(",")[1]);
    }
  }

  Widget getOptionContentCat(String text) {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      return MyText(text: text);
    } else {
      var split = text.split("-");
      var v1 = split[0];
      var v2 = split[1];
      double textWidthPercent = 15;
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MyText(text: v1, width: screenDimensions.w(textWidthPercent)),
        Padding(
            padding: EdgeInsets.all(screenDimensions.w(1)), child: arrowRight),
        MyText(text: v2, width: screenDimensions.w(textWidthPercent))
      ]);
    }
  }

  Size getButtonSizeForCat() {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      return Size(screenDimensions.w(30), screenDimensions.h(9));
    } else {
      return Size(screenDimensions.w(60), screenDimensions.h(10));
    }
  }

  void onHintButtonClick() {
    var currentQuestionInfo = widget.currentQuestionInfo;

    if (currentQuestionInfo != null) {
      widget.correctAnswerPressed = false;

      widget.gameContext.amountAvailableHints--;
      widget.historyLocalStorage.setRemainingHints(
          widget.difficulty, widget.gameContext.amountAvailableHints);

      List<int> availableQuestionsToShowImages = widget.gameContext.gameUser
          .getOpenQuestionsForConfig(widget.difficulty, widget.category)
          .map((e) => e.question.index)
          .toList();
      availableQuestionsToShowImages.shuffle();
      availableQuestionsToShowImages.remove(currentQuestionInfo.question.index);
      availableQuestionsToShowImages.removeAll(widget
          .gameContext.shownImagesForTimeLineHints
          .getOrDefault(widget.category, List.empty()));
      Set<int> imagesToShow = Set();
      imagesToShow.add(currentQuestionInfo.question.index);
      var imagesToShowForHint = 3;
      while (imagesToShow.length < imagesToShowForHint &&
          availableQuestionsToShowImages.isNotEmpty) {
        imagesToShow.add(availableQuestionsToShowImages[0]);
        availableQuestionsToShowImages.removeAt(0);
      }
      widget.gameContext.shownImagesForTimeLineHints
          .putIfAbsent(widget.category, () => [])
          .addAll(imagesToShow);
      for (int qImgToShowIndex in imagesToShow) {
        widget.historyLocalStorage.setTimelineShownImagesQuestion(
            widget.difficulty, widget.category, qImgToShowIndex);
      }
      setState(() {
        widget.animateQuestionText = false;
      });
    }
  }

  Widget createOptionItemCat0(
      MyButton answerBtn,
      Size answerBtnSize,
      bool? correctAnswer,
      Image questionImg,
      int index,
      int millisForZoomInZoomOut) {
    var mostRecentAnswered = getMostRecentAnswered();
    Widget answerPart = createBtnAnswerWithAnimation(mostRecentAnswered, index,
        millisForZoomInZoomOut, answerBtnSize, answerBtn);

    var item = Row(children: <Widget>[
      Spacer(),
      Padding(
          padding: EdgeInsets.all(screenDimensions.w(3)), child: answerPart),
      getQuestionSeparator(answerBtnSize, correctAnswer),
      questionImg,
      Spacer()
    ]);

    Color color = getColorForAnswerStatus(correctAnswer);
    return Container(
        child: item, color: getColorOpacityForItemRowNr(index, color));
  }

  Color getColorOpacityForItemRowNr(int index, Color color) =>
      index % 2 == 0 ? color.withOpacity(0.5) : color.withOpacity(0.8);

  Color getColorForAnswerStatus(bool? correctAnswer) {
    var color = correctAnswer == null
        ? Colors.yellow.shade500
        : correctAnswer
            ? Colors.green.shade200
            : Colors.red.shade200;
    return color;
  }

  Widget getQuestionSeparator(Size answerBtnSize, bool? correctAnswer) {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      return Container(
          child: Row(children: <Widget>[
        SizedBox(
          width: screenDimensions.w(2),
        ),
        Container(
            width: screenDimensions.w(2),
            height: answerBtnSize.height * 2,
            color: correctAnswer == null
                ? Colors.blueGrey
                : correctAnswer
                    ? Colors.green
                    : Colors.red),
        SizedBox(
          width: screenDimensions.w(2),
        ),
      ]));
    } else {
      return Container();
    }
  }

  QuestionInfo? getMostRecentAnswered() {
    return widget.gameContext.gameUser.getMostRecentAnsweredQuestion(
        questionInfoStatus: [QuestionInfoStatus.LOST, QuestionInfoStatus.WON],
        difficulty: widget.difficulty,
        category: widget.category);
  }

  Widget createOptionItemCat1(
      MyButton answerBtn,
      Size answerBtnSize,
      bool? correctAnswer,
      Image questionImg,
      int index,
      int millisForZoomInZoomOut) {
    var mostRecentAnswered = getMostRecentAnswered();
    Widget answerPart = createBtnAnswerWithAnimation(mostRecentAnswered, index,
        millisForZoomInZoomOut, answerBtnSize, answerBtn);

    var item = Row(children: <Widget>[
      Spacer(),
      Padding(
          padding: EdgeInsets.all(screenDimensions.w(3)), child: answerPart),
      getQuestionSeparator(answerBtnSize, correctAnswer),
      questionImg,
      Spacer()
    ]);

    Color color = getColorForAnswerStatus(correctAnswer);
    return Container(
        child: item, color: getColorOpacityForItemRowNr(index, color));
  }

  Widget createBtnAnswerWithAnimation(
      QuestionInfo? mostRecentAnswered,
      int index,
      int millisForZoomInZoomOut,
      Size answerBtnSize,
      MyButton answerBtn) {
    Widget answerPart = (mostRecentAnswered != null &&
            mostRecentAnswered.question.index == index &&
            widget.questionsToPlayUntilNextCategory !=
                HistoryGameTimelineScreen
                    .default_questions_to_play_until_next_category)
        ? AnimateZoomInZoomOut(
            zoomInZoomOutOnce: true,
            duration: Duration(milliseconds: millisForZoomInZoomOut),
            toAnimateWidgetSize: answerBtnSize,
            toAnimateWidget: answerBtn,
          )
        : answerBtn;
    return answerPart;
  }

  String getOptionText(String yearString) {
    if (widget.category == HistoryGameQuestionConfig().cat0) {
      int year = int.parse(yearString);
      String val =
          year < 0 ? year.abs().formatIntEveryChars(4) : year.toString();
      val = year < 0 ? formatTextWithOneParam(label.l_param0_bc, val) : val;
      return val;
    } else {
      var split = yearString.split(",");
      var split2 = split[1];
      int year1 = int.parse(split[0]);
      int year2 = getYear2ForCat1(split2);
      String val1 =
          year1 < 0 ? year1.abs().formatIntEveryChars(4) : year1.toString();
      val1 = year1 < 0 ? formatTextWithOneParam(label.l_param0_bc, val1) : val1;
      String val2 =
          year2 < 0 ? year2.abs().formatIntEveryChars(4) : year2.toString();
      val2 = year2 < 0 ? formatTextWithOneParam(label.l_param0_bc, val2) : val2;
      return val1 + "-" + val2;
    }
  }

  int getYear2ForCat1(String yearString) {
    return yearString == "x" ? DateTime.now().year : int.parse(yearString);
  }
}
