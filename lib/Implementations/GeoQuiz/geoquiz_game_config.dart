import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_config.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_question_config.dart';
import 'package:flutter_app_quiz_game/Game/Question/all_questions_service.dart';
import 'package:flutter_app_quiz_game/Game/Question/question_collector_service.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Constants/geoquiz_game_question_config.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Questions/AllContent/geoquiz_all_questions.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Questions/AllContent/geoquiz_question_collector_service.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Service/geoquiz_game_screen_manager.dart';
import 'package:flutter_app_quiz_game/Lib/Constants/language.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen_manager.dart';

class GeoQuizGameConfig extends GameConfig {
  static final GeoQuizGameConfig singleton = GeoQuizGameConfig.internal();

  factory GeoQuizGameConfig() {
    return singleton;
  }

  GeoQuizGameConfig.internal();

  @override
  QuestionCollectorService get questionCollectorService =>
      GeoQuizQuestionCollectorService();

  @override
  GameQuestionConfig get gameQuestionConfig => GeoQuizGameQuestionConfig();

  @override
  AllQuestionsService get allQuestionsService => GeoQuizAllQuestions();

  @override
  GameScreenManager get gameScreenManager =>
      GeoQuizGameScreenManager(key: UniqueKey());

  @override
  ImageRepeat get backgroundTextureRepeat => ImageRepeat.noRepeat;

  @override
  Color get defaultScreenBackgroundColor => const Color.fromRGBO(198, 236, 255, 1);

  @override
  String get extraContentProductId {
    if (kIsWeb) {
      return "extraContent";
    } else if (Platform.isAndroid) {
      return "extracontent.geoquiz";
    } else if (Platform.isIOS) {
      return "extraContent";
    }
    throw UnsupportedError("Unsupported platform");
  }

  @override
  String getTitle(Language language) {
    switch (language) {
      case Language.ar:
        return "?????????????? ????????????";
      case Language.bg:
        return "???????????????? ??????????????????";
      case Language.cs:
        return "Sv??tov?? geografie";
      case Language.da:
        return "Verdensgeografi";
      case Language.de:
        return "Weltgeografie";
      case Language.el:
        return "?????????????????? ??????????????????";
      case Language.en:
        return "World Geography";
      case Language.es:
        return "Geografia mundial";
      case Language.fi:
        return "Maailman maantiede";
      case Language.fr:
        return "G??ographie du monde";
      case Language.he:
        return "???????????????? ??????????";
      case Language.hi:
        return "??????????????? ?????? ???????????????";
      case Language.hr:
        return "Svjetska geografija";
      case Language.hu:
        return "Vil??gf??ldrajz";
      case Language.id:
        return "Geografi dunia";
      case Language.it:
        return "Geografia mondiale";
      case Language.ja:
        return "???????????????";
      case Language.ko:
        return "?????? ??????";
      case Language.ms:
        return "Geografi Dunia";
      case Language.nl:
        return "Wereld Aardrijkskunde";
      case Language.nb:
        return "Verdensgeografi";
      case Language.pl:
        return "Geografia ??wiata";
      case Language.pt:
        return "Geografia mundial";
      case Language.ro:
        return "Geografia lumii";
      case Language.ru:
        return "?????????????? ??????????????????";
      case Language.sk:
        return "Svetov?? geografia";
      case Language.sl:
        return "Svetovna geografija";
      case Language.sr:
        return "?????????????? ????????????????????";
      case Language.sv:
        return "V??rldsgeografi";
      case Language.th:
        return "???????????????????????????????????????";
      case Language.tr:
        return "D??nya co??rafyas??";
      case Language.uk:
        return "?????????????? ??????????????????";
      case Language.vi:
        return "?????a l?? th??? gi???i";
      case Language.zh:
        return "????????????";
      default:
        return "World Geography";
    }
  }
}
