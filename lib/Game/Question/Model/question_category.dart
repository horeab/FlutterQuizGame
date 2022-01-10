import 'package:flutter_app_quiz_game/Game/Question/Model/question_difficulty.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/map_extension.dart';

import '../QuestionCategoryService/Base/question_category_service.dart';

class QuestionCategory {
  int index;
  late Map<QuestionDifficulty, QuestionCategoryService>
      _questionCategoryServiceMap;
  QuestionCategoryService? _questionCategoryService;

  QuestionCategory(
      {required this.index,
      QuestionCategoryService? questionCategoryService,
      Map<QuestionDifficulty, QuestionCategoryService>?
          questionCategoryServiceMap}) {
    assert(questionCategoryService != null ||
        questionCategoryServiceMap != null &&
            questionCategoryServiceMap.isNotEmpty);
    _questionCategoryService = questionCategoryService;
    _questionCategoryServiceMap = questionCategoryServiceMap ?? {};
  }

  QuestionCategoryService getQuestionCategoryService(QuestionDifficulty diff) {
    return _questionCategoryServiceMap
        .getOrDefault<QuestionDifficulty, QuestionCategoryService>(
            diff, _questionCategoryService!);
  }

  String get name {
    return "cat" + index.toString();
  }

  @override
  String toString() {
    return 'QuestionCategory{name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionCategory && index == other.index && name == other.name;

  @override
  int get hashCode => index.hashCode ^ name.hashCode;
}
