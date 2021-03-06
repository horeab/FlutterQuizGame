import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';
import 'package:flutter_app_quiz_game/Game/Question/QuestionCategoryService/Base/question_service.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Constants/geoquiz_game_question_config.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/string_extension.dart';

import '../../../../main.dart';
import '../geoquiz_country_utils.dart';
import 'geoquiz_options_question_parser.dart';

class GeoQuizOptionsQuestionService extends QuestionService {
  final GeoQuizCountryUtils _geoQuizCountryUtils = GeoQuizCountryUtils();
  final GeoQuizGameQuestionConfig _questionConfig = GeoQuizGameQuestionConfig();
  late GeoQuizOptionsQuestionParser questionParser;
  List<String>? questionCorrectAnswersCache;

  static final GeoQuizOptionsQuestionService singleton =
      GeoQuizOptionsQuestionService.internal();

  factory GeoQuizOptionsQuestionService(
      {required GeoQuizOptionsQuestionParser questionParser}) {
    singleton.questionParser = questionParser;
    return singleton;
  }

  GeoQuizOptionsQuestionService.internal();

  @override
  String getQuestionToBeDisplayed(Question question) {
    return questionParser.getQuestionToBeDisplayed(question);
  }

  @override
  int getPrefixCodeForQuestion(Question question) {
    if (_geoQuizCountryUtils
        .isCategoryWithMultipleCorrectAnswers(question.category)) {
      return questionParser.isCategoryFindAnswerByQuestionName(question)
          ? 2
          : getCorrectAnswers(question).length > 1
              ? 1
              : 0;
    } else {
      return 0;
    }
  }

  @override
  List<String> getCorrectAnswers(Question question) {
    questionCorrectAnswersCache ??=
        questionParser.getCorrectAnswersFromRawString(question);
    return questionCorrectAnswersCache!;
  }

  void clearCache() {
    questionCorrectAnswersCache = null;
  }

  @override
  Set<String> getQuizAnswerOptions(Question question) {
    if (_geoQuizCountryUtils.isStatsCategory(question.category)) {
      return _getStatsCategoryAnswerOptions(question);
    } else if (questionParser.isCategoryFindAnswerByQuestionName(question) &&
        _questionConfig.cat2 != question.category) {
      return questionParser.getDependentAnswerOptionsForQuestion(
          question, getCorrectAnswers(question).first, 4);
    } else {
      var correctAnswers = getCorrectAnswers(question);
      return _getCountriesInRangeAnswerOptions(question, correctAnswers);
    }
  }

  Set<String> _getCountriesInRangeAnswerOptions(
      Question question, List<String> correctAnswers) {
    String currentCountryToSearchRange =
        _getCurrentCountryToSearchRange(question);
    return questionParser.getAnswerOptionsInCountryRange(
        currentCountryToSearchRange,
        correctAnswers.toSet(),
        _geoQuizCountryUtils
                .isCategoryWithMultipleCorrectAnswers(question.category)
            ? questionParser
                .getCountryNamesFromQuestionOptions(question)
                .toSet()
            : {},
        correctAnswers.length,
        correctAnswers.length + 3);
  }

  Set<String> _getStatsCategoryAnswerOptions(Question question) {
    var countryNameForIndex = _geoQuizCountryUtils
        .getCountryNameForIndex(question.rawString.split(":")[0].parseToInt);
    return questionParser.getAnswerOptionsForStatisticsQuestion(
        question.category, countryNameForIndex, 4);
  }

  String _getCurrentCountryToSearchRange(Question question) {
    String currentCountryToSearchRange = _geoQuizCountryUtils
            .isGeographicalRegionOrEmpireCategory(question.category)
        ? questionParser
            .getCountryNamesFromQuestionOptions(question)
            .elementAt(0)
        : _geoQuizCountryUtils.getCountryNameForIndex(
            question.rawString.split(":")[0].parseToInt);
    return currentCountryToSearchRange;
  }

  @override
  String getPrefixToBeDisplayedForQuestion(Question question) {
    return MyApp.appId.gameConfig.gameQuestionConfig
        .getPrefixToBeDisplayedForQuestion(question.category,
            question.difficulty, getPrefixCodeForQuestion(question));
  }
}
