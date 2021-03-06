import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_config.dart';
import 'package:flutter_app_quiz_game/Game/GameType/game_question_config.dart';
import 'package:flutter_app_quiz_game/Game/Question/all_questions_service.dart';
import 'package:flutter_app_quiz_game/Game/Question/question_collector_service.dart';
import 'package:flutter_app_quiz_game/Implementations/Anatomy/Service/anatomy_screen_manager.dart';
import 'package:flutter_app_quiz_game/Lib/Constants/language.dart';
import 'package:flutter_app_quiz_game/Lib/Screen/Game/game_screen_manager.dart';

import 'Constants/anatomy_game_question_config.dart';
import 'Questions/AllContent/anatomy_all_questions.dart';
import 'Questions/AllContent/anatomy_question_collector_service.dart';

class AnatomyGameConfig extends GameConfig {
  static final AnatomyGameConfig singleton = AnatomyGameConfig.internal();

  factory AnatomyGameConfig() {
    return singleton;
  }

  AnatomyGameConfig.internal();

  @override
  QuestionCollectorService get questionCollectorService =>
      AnatomyQuestionCollectorService();

  @override
  GameQuestionConfig get gameQuestionConfig => AnatomyGameQuestionConfig();

  @override
  AllQuestionsService get allQuestionsService => AnatomyAllQuestions();

  @override
  GameScreenManager get gameScreenManager =>
      AnatomyScreenManager(key: UniqueKey());

  @override
  ImageRepeat get backgroundTextureRepeat => ImageRepeat.noRepeat;

  @override
  Color get defaultScreenBackgroundColor => const Color.fromRGBO(198, 236, 255, 1);

  @override
  String get extraContentProductId {
    if (kIsWeb) {
      return "extraContent";
    } else if (Platform.isAndroid) {
      return "extracontent.anatomy";
    } else if (Platform.isIOS) {
      return "extraContentAnatomy";
    }
    throw UnsupportedError("Unsupported platform");
  }

  @override
  String getTitle(Language language) {
    switch (language) {
      case Language.ar:
        return "??????????";
      case Language.bg:
        return "????????????????";
      case Language.cs:
        return "Anatomie";
      case Language.da:
        return "Anatomi";
      case Language.de:
        return "Anatomie Spiel";
      case Language.el:
        return "????????????????";
      case Language.en:
        return "Anatomy Game";
      case Language.es:
        return "Anatom??a";
      case Language.fi:
        return "Anatomia";
      case Language.fr:
        return "Anatomie";
      case Language.he:
        return "????????????????????????";
      case Language.hi:
        return "?????????????????????";
      case Language.hr:
        return "Anatomija";
      case Language.hu:
        return "Anat??mia";
      case Language.id:
        return "Anatomi";
      case Language.it:
        return "Anatomia";
      case Language.ja:
        return "?????????";
      case Language.ko:
        return "?????????";
      case Language.ms:
        return "Anatomi";
      case Language.nl:
        return "Anatomie";
      case Language.nb:
        return "Anatomi-spill";
      case Language.pl:
        return "Anatomia";
      case Language.pt:
        return "Anatomia";
      case Language.ro:
        return "Anatomie";
      case Language.ru:
        return "???????? ????????????????";
      case Language.sk:
        return "Anat??mia";
      case Language.sl:
        return "Anatomija";
      case Language.sr:
        return "??????????????????";
      case Language.sv:
        return "Anatomi";
      case Language.th:
        return "??????????????????????????????????????????";
      case Language.tr:
        return "Anatomi Oyunu";
      case Language.uk:
        return "????????????????";
      case Language.vi:
        return "Gi???i ph???u h???c";
      case Language.zh:
        return "?????????";
      default:
        return "Anatomy Game";
    }
  }
}
