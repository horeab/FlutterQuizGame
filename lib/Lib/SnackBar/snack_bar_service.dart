import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Lib/ScreenDimensions/screen_dimensions_service.dart';
import 'package:flutter_app_quiz_game/Lib/Text/my_text.dart';

class SnackBarService {

  ScreenDimensionsService screenDimensions = ScreenDimensionsService();

  void showSnackBar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: SizedBox(
        height: screenDimensions.dimen(12),
        child: Center(
            child: MyText(
              text: message,
              width: screenDimensions.dimen(99),
              maxLines: 1,
            )),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}