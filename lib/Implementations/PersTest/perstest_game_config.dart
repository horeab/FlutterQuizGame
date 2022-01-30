import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_config.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_question_config.dart';
import 'package:flutter_app_quiz_game/Game/Question/all_questions_service.dart';
import 'package:flutter_app_quiz_game/Game/Question/question_collector_service.dart';
import 'package:flutter_app_quiz_game/Lib/Constants/language.dart';
import 'package:flutter_app_quiz_game/Lib/Constants/screen_orientation.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen_manager.dart';

import 'Constants/perstest_game_question_config.dart';
import 'Questions/AllContent/perstest_all_questions.dart';
import 'Questions/AllContent/perstest_question_collector_service.dart';
import 'Service/perstest_game_screen_manager.dart';

class PersTestGameConfig extends GameConfig {
  static final PersTestGameConfig singleton = PersTestGameConfig.internal();

  factory PersTestGameConfig() {
    return singleton;
  }

  PersTestGameConfig.internal();

  @override
  QuestionCollectorService get questionCollectorService =>
      PersTestQuestionCollectorService();

  @override
  GameQuestionConfig get gameQuestionConfig => PersTestGameQuestionConfig();

  @override
  AllQuestionsService get allQuestionsService => PersTestAllQuestions();

  @override
  GameScreenManager get gameScreenManager =>
      PersTestGameScreenManager(key: UniqueKey());

  @override
  ImageRepeat get backgroundTextureRepeat => ImageRepeat.noRepeat;

  @override
  ScreenOrientation get screenOrientation => ScreenOrientation.landscape;

  @override
  Color get screenBackgroundColor => const Color.fromRGBO(198, 236, 255, 1);

  @override
  String get extraContentProductId => "extracontent.perstest";

  @override
  String getTitle(Language language) {
    switch (language) {
      case Language.ar:
        return "جغرافيا العالم";
      case Language.bg:
        return "Световна география";
      case Language.cs:
        return "Světová geografie";
      case Language.da:
        return "Verdensgeografi";
      case Language.de:
        return "Weltgeografie";
      case Language.el:
        return "Παγκόσμια γεωγραφία";
      case Language.en:
        return "World Geography";
      case Language.es:
        return "Geografia mundial";
      case Language.fi:
        return "Maailman maantiede";
      case Language.fr:
        return "Géographie du monde";
      case Language.he:
        return "גאוגרפית העולם";
      case Language.hi:
        return "विश्व का भूगोल";
      case Language.hr:
        return "Svjetska geografija";
      case Language.hu:
        return "Világföldrajz";
      case Language.id:
        return "Geografi dunia";
      case Language.it:
        return "Geografia mondiale";
      case Language.ja:
        return "世界の地理";
      case Language.ko:
        return "세계 지리";
      case Language.ms:
        return "Geografi Dunia";
      case Language.nl:
        return "Wereld Aardrijkskunde";
      case Language.nb:
        return "Verdensgeografi";
      case Language.pl:
        return "Geografia świata";
      case Language.pt:
        return "Geografia mundial";
      case Language.ro:
        return "Geografia lumii";
      case Language.ru:
        return "Мировая география";
      case Language.sk:
        return "Svetová geografia";
      case Language.sl:
        return "Svetovna geografija";
      case Language.sr:
        return "Светска географија";
      case Language.sv:
        return "Världsgeografi";
      case Language.th:
        return "ภูมิศาสตร์โลก";
      case Language.tr:
        return "Dünya coğrafyası";
      case Language.uk:
        return "Світова географія";
      case Language.vi:
        return "Địa lý thế giới";
      case Language.zh:
        return "世界地理";
      default:
        return "World Geography";
    }
  }
}
