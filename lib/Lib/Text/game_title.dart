import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Lib/Font/font_config.dart';
import 'package:flutter_app_quiz_game/Lib/ScreenDimensions/screen_dimensions_service.dart';

import 'my_text.dart';

class GameTitle extends StatelessWidget {
  late double backgroundImageWidth;
  FontConfig fontConfig;
  String text;
  String backgroundImagePath;

  GameTitle({
    Key? key,
    required this.fontConfig,
    required this.text,
    required this.backgroundImagePath,
    double? backgroundImageWidth,
  }) : super(key: key) {
    this.backgroundImageWidth =
        backgroundImageWidth ?? ScreenDimensionsService().w(85);
  }

  @override
  Widget build(BuildContext context) {
    var imageWithText =
        Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Image.asset(
        backgroundImagePath,
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
        width: backgroundImageWidth,
      ),
      MyText(
        text: text,
        width: backgroundImageWidth / 1.4,
        maxLines: text.contains(" ") ? 2 : 1,
        fontConfig: fontConfig,
      ),
    ]);

    return imageWithText;
  }
}
