import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
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
  ImageRepeat get backgroundTextureRepeat => ImageRepeat.repeat;

  @override
  ScreenOrientation get screenOrientation => ScreenOrientation.landscape;

  @override
  Color get defaultScreenBackgroundColor => const Color.fromRGBO(198, 236, 255, 1);

  @override
  String get extraContentProductId {
    if (kIsWeb) {
      return "extraContent";
    } else if (Platform.isAndroid) {
      return "extracontent.perstest";
    } else if (Platform.isIOS) {
      return "extracontent.persontest";
    }
    throw UnsupportedError("Unsupported platform");
  }

  @override
  String getTitle(Language language) {
    switch (language) {
      case Language.ar:
        return "???????????? ??????????????";
      case Language.bg:
        return "?????????????????? ????????";
      case Language.cs:
        return "Osobnostn?? test";
      case Language.da:
        return "Personlighedstest";
      case Language.de:
        return "Pers??nlichkeitstest";
      case Language.el:
        return "???????? ????????????????????????????";
      case Language.en:
        // return "The Big Five Personality Test";
        return "The Personality Test";
      case Language.es:
        return "La prueba de personalidad";
      case Language.fi:
        return "Persoonallisuustesti";
      case Language.fr:
        return "Test de personnalit??";
      case Language.he:
        return "???????? ????????????";
      case Language.hi:
        return "?????????????????????????????? ?????????????????????";
      case Language.hr:
        return "Test osobnosti";
      case Language.hu:
        return "Szem??lyis??gteszt";
      case Language.id:
        return "Tes Kepribadian";
      case Language.it:
        return "Il test della personalit??";
      case Language.ja:
        return "????????????";
      case Language.ko:
        return "?????? ??????";
      case Language.ms:
        return "Ujian Keperibadian";
      case Language.nl:
        return "Persoonlijkheidstest";
      case Language.nb:
        return "Personlighetstest";
      case Language.pl:
        return "Kwestionariusz osobowo??ci";
      case Language.pt:
        return "O teste de personalidade";
      case Language.ro:
        return "Test de personalitate";
      case Language.ru:
        return "???????????????????? ????????";
      case Language.sk:
        return "Test osobnosti";
      case Language.sl:
        return "Test osebnosti";
      case Language.sr:
        return "???????? ????????????????";
      case Language.sv:
        return "Personlighetstest";
      case Language.th:
        return "???????????????????????????????????????????????????";
      case Language.tr:
        return "Ki??ilik testi";
      case Language.uk:
        return "???????? ??????????????????????";
      case Language.vi:
        return "Tr???c nghi???m t??nh c??ch";
      case Language.zh:
        return "????????????";
      default:
        return "The Personality Test";
    }
  }
}
