import 'package:flutter_app_quiz_game/Game/Question/Model/question_category.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';

abstract class GameQuestionConfig {
  List<QuestionCategory> get categories;

  List<QuestionDifficulty> get difficulties;

  Map<QuestionCategoryWithPrefixCode, String> get prefixLabelForCode;

  AppLocalizations get label => MyApp.appLocalizations;
}

class QuestionCategoryWithPrefixCode {

  QuestionCategory category;
  int prefixCode;

  QuestionCategoryWithPrefixCode(this.category, this.prefixCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionCategoryWithPrefixCode &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          prefixCode == other.prefixCode;

  @override
  int get hashCode => category.hashCode ^ prefixCode.hashCode;
}
