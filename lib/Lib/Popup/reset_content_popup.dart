import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Lib/Button/my_button.dart';
import 'package:flutter_app_quiz_game/Lib/Localization/label_mixin.dart';
import 'package:flutter_app_quiz_game/Lib/Text/my_text.dart';

import '../../main.dart';
import 'my_popup.dart';

class ResetContentPopup extends StatefulWidget {
  VoidCallback resetContent;

  ResetContentPopup(this.resetContent, {Key? key}) : super(key: key);

  @override
  State<ResetContentPopup> createState() => ResetContentPopupState();
}

class ResetContentPopupState extends State<ResetContentPopup>
    with MyPopup, LabelMixin {
  @override
  void initState() {
    initPopup();
    super.initState();
  }

  @override
  AlertDialog build(BuildContext context) {
    return createDialog(
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            margin,
            MyText(text: label.l_delete_all_progress),
            margin,
            MyButton(
              text: label.l_yes,
              backgroundColor: Colors.redAccent.shade200,
              onClick: () {
                MyApp.gameScreenManager.currentScreen!.gameScreenManagerState
                    .showMainScreen();
                widget.resetContent.call();
                closePopup(context);
              },
            ),
            margin,
            MyButton(
              text: label.l_no,
              backgroundColor: Colors.blue.shade300,
              onClick: () {
                closePopup(context);
              },
            ),
          ]),
      context: context,
    );
  }
}
