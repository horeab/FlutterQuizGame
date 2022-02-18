import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Implementations/DopeWars/Constants/dopewars_location.dart';
import 'package:flutter_app_quiz_game/Implementations/DopeWars/Constants/dopewars_resource_type.dart';
import 'package:flutter_app_quiz_game/Implementations/DopeWars/Questions/dopewars_game_context.dart';
import 'package:flutter_app_quiz_game/Implementations/DopeWars/Service/dopewars_game_local_storage.dart';
import 'package:flutter_app_quiz_game/Implementations/DopeWars/Service/dopewars_resource_transaction_service.dart';
import 'package:flutter_app_quiz_game/Lib/Button/button_skin_config.dart';
import 'package:flutter_app_quiz_game/Lib/Button/my_button.dart';
import 'package:flutter_app_quiz_game/Lib/Font/font_config.dart';
import 'package:flutter_app_quiz_game/Lib/Popup/my_popup.dart';
import 'package:flutter_app_quiz_game/Lib/Text/my_text.dart';

class DopeWarsLocationMovePopup extends StatefulWidget with MyPopup {
  final DopeWarsLocalStorage _dopeWarsLocalStorage = DopeWarsLocalStorage();
  final DopeWarsGameContext _dopeWarsGameContext;
  final VoidCallback _refreshStateCallback;
  late DopeWarsResourceTransactionService _dopeWarsResourceTransactionService;

  DopeWarsLocationMovePopup(
      this._refreshStateCallback, this._dopeWarsGameContext) {
    _dopeWarsResourceTransactionService =
        DopeWarsResourceTransactionService(_dopeWarsGameContext);
  }

  @override
  State<DopeWarsLocationMovePopup> createState() =>
      DopeWarsLocationMovePopupState();
}

class DopeWarsLocationMovePopupState extends State<DopeWarsLocationMovePopup>
    with MyPopup {
  @override
  void initState() {
    super.initState();
    initPopup();
  }

  @override
  AlertDialog build(BuildContext context) {
    return createDialog(
      createLocations(),
      context: context,
    );
  }

  Widget createLocations() {
    List<Widget> items = [];
    var locations = DopeWarsLocation.locations;
    for (DopeWarsLocation l in locations) {
      items.add(createLocationRow(l));
      if (l.index != locations.last.index) {
        items.add(Padding(
            padding: EdgeInsets.all(screenDimensions.dimen(2.5)),
            child: Divider(
              height: screenDimensions.dimen(0.1),
              thickness: screenDimensions.dimen(0.1),
              color: Colors.grey,
            )));
      }
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items);
  }

  Widget createLocationRow(DopeWarsLocation location) {
    bool isCurrentLocation = location.index ==
        widget._dopeWarsGameContext.market.currentLocation.index;
    bool isDisabled = isCurrentLocation;
    String priceInfo = "";
    String reputationInfo = "";
    var btnColor = Colors.green.shade300;
    Color? disabledColor;
    var budget = widget._dopeWarsGameContext.inventory.budget;
    if (!widget._dopeWarsLocalStorage.isLocationUnlocked(location)) {
      priceInfo = "Unlock " +
          DopeWarsResourceTransactionService.formatCurrency(
              location.unlockPrice);
      reputationInfo = "Reputation +" +
          DopeWarsResourceTransactionService.reputationForLocationUnlock
              .toString() ;
      isDisabled = location.unlockPrice > budget;
      btnColor = Colors.orange.shade300;
    } else if (!isCurrentLocation) {
      var travelPrice =
          location.getTravelPrice(widget._dopeWarsGameContext.daysPassed);
      priceInfo = "Travel " +
          DopeWarsResourceTransactionService.formatCurrency(travelPrice);
      isDisabled = travelPrice > budget;
      btnColor = Colors.lightGreen.shade300;
    } else if (isCurrentLocation) {
      disabledColor = Colors.white;
    }
    var btnSize = Size(screenDimensions.w(33), screenDimensions.dimen(14));
    List<Widget> items = [];
    List<Widget> locBtnItems = [];
    locBtnItems.add(MyButton(
      disabled: isDisabled,
      disabledBackgroundColor: disabledColor,
      text: location.locationLabel,
      fontSize: FontConfig.getCustomFontSize(0.9),
      size: btnSize,
      buttonSkinConfig: ButtonSkinConfig(
          borderWidth: FontConfig.standardBorderWidth / 2,
          backgroundColor: btnColor),
      onClick: () {
        widget._dopeWarsResourceTransactionService.dopeWarsLocationMoveService
            .passDayAndMoveLocation(context, location);
        widget._refreshStateCallback.call();
        closePopup(context);
      },
    ));
    if (priceInfo.isNotEmpty || reputationInfo.isNotEmpty) {
      var infoFontSize = FontConfig.getCustomFontSize(0.8);
      if (priceInfo.isNotEmpty) {
        locBtnItems.add(MyText(
          textAllPadding: screenDimensions.dimen(0.2),
          maxLines: 1,
          fontConfig: FontConfig(
              fontWeight: isDisabled ? FontWeight.w500 : FontWeight.w800,
              fontSize: infoFontSize,
              fontColor: isDisabled ? Colors.grey : Colors.green.shade900),
          text: priceInfo,
        ));
      }
      if (reputationInfo.isNotEmpty) {
        locBtnItems.add(MyText(
          textAllPadding: screenDimensions.dimen(0.2),
          maxLines: 1,
          text: reputationInfo,
          fontConfig: FontConfig(
              fontSize: infoFontSize,
              fontColor: Colors.deepOrange,
              borderColor: Colors.orange.shade100),
        ));
      }
    }
    items.add(Column(children: locBtnItems));
    items.add(createResColumn(location.cheapResources, "downarrow"));
    items.add(createResColumn(location.expensiveResources, "uparrow"));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items);
  }

  Widget createResColumn(List<DopeWarsResourceType> res, String arrowImgName) {
    List<Widget> items = [];
    for (DopeWarsResourceType t in res) {
      items.add(createResRow(t, arrowImgName));
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items);
  }

  Widget createResRow(DopeWarsResourceType res, String arrowImgName) {
    List<Widget> items = [];
    var allContainerWidth = screenDimensions.dimen(27);
    var imgDimen = screenDimensions.dimen(5);
    items.add(MyText(
      width: allContainerWidth - imgDimen * 1.1,
      text: res.resourceLabel,
      fontSize: FontConfig.getCustomFontSize(0.8),
      maxLines: 1,
    ));
    items.add(imageService.getSpecificImage(
        maxWidth: imgDimen,
        module: "general",
        imageName: arrowImgName,
        imageExtension: "png"));
    return SizedBox(
        width: allContainerWidth,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items));
  }
}