import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_game/Lib/Button/my_button.dart';
import 'package:flutter_app_quiz_game/Lib/Font/font_config.dart';
import 'package:flutter_app_quiz_game/Lib/Storage/in_app_purchases_local_storage.dart';
import 'package:flutter_app_quiz_game/Lib/Text/my_text.dart';
import 'package:flutter_app_quiz_game/main.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'my_popup.dart';

class InAppPurchasesPopupService {
  late BuildContext context;

  static final InAppPurchasesPopupService singleton =
      InAppPurchasesPopupService.internal();

  factory InAppPurchasesPopupService({required BuildContext buildContext}) {
    singleton.context = buildContext;
    return singleton;
  }

  InAppPurchasesPopupService.internal();

  void showPopup({String? inAppPurchaseDescription}) {
    Future.delayed(
        Duration.zero,
        () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return InAppPurchasePopup();
            }));
  }
}

class InAppPurchasePopup extends StatefulWidget {
  static const String _kNonConsumableId = 'consumable';
  static const List<String> _kProductIds = <String>[
    _kNonConsumableId,
  ];

  InAppPurchaseLocalStorage _inAppPurchaseLocalStorage =
      InAppPurchaseLocalStorage();
  late InAppPurchase _inAppPurchase;

  InAppPurchasePopup() {
    _inAppPurchase = InAppPurchase.instance;
  }

  @override
  _InAppPurchaseState createState() => _InAppPurchaseState();
}

class _InAppPurchaseState extends State<InAppPurchasePopup> with MyPopup {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    if (!kIsWeb) {
      final Stream<List<PurchaseDetails>> purchaseUpdated =
          widget._inAppPurchase.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
    }
    initStoreInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initPopup(
        context: context,
        backgroundImageName: "popup_in_app_purchases_background");

    List<Widget> stack = [];
    var popupHeight = screenDimensions.h(45);
    if (_queryProductError == null && _products.isNotEmpty) {
      var btnWidth = screenDimensions.w(65);
      var paddingBetween = screenDimensions.w(1);
      var iconWidth = screenDimensions.w(8);
      stack.add(
        SizedBox(
            height: popupHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProductList(btnWidth, iconWidth, paddingBetween),
                SizedBox(
                  height: screenDimensions.h(3),
                ),
                _buildRestoreButton(btnWidth, iconWidth, paddingBetween),
              ],
            )),
      );
    } else if (_queryProductError != null) {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }

    if (_purchasePending || _products.isEmpty) {
      stack.add(
        SizedBox(
          height: popupHeight,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child:
                    const ModalBarrier(dismissible: false, color: Colors.grey),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    }

    return createDialog(Container(
        child: Stack(
      children: stack,
    )));
  }

  Widget _buildRestoreButton(
      double btnWidth, double iconWidth, double paddingBetween) {
    // if (_loading) {
    //   return Container();
    // }

    return MyButton(
      backgroundColor: Colors.lightBlueAccent,
      width: btnWidth,
      customContent: Row(children: [
        SizedBox(width: paddingBetween),
        imageService.getMainImage(
          imageName: "btn_restore_purchase",
          module: "buttons",
          maxWidth: iconWidth,
        ),
        MyText(
          text: label.l_restore_purchase,
          maxLines: 2,
          width: btnWidth - iconWidth - paddingBetween * 5,
          alignmentInsideContainer: Alignment.center,
        ),
      ]),
      onClick: () => widget._inAppPurchase.restorePurchases(),
    );
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await widget._inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = widget._inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    ProductDetailsResponse productDetailResponse = await widget._inAppPurchase
        .queryProductDetails(InAppPurchasePopup._kProductIds.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      if (kIsWeb) {
        _products = [
          ProductDetails(
              id: "1",
              title: "Title",
              description: "Extra Content + Ad free",
              price: "0.99",
              rawPrice: 0.99,
              currencyCode: "EUR")
        ];
      } else {
        _products = productDetailResponse.productDetails;
      }
      _notFoundIds = productDetailResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Container _buildProductList(
      double btnWidth, double iconWidth, double paddingBetween) {
    List<Column> productList = <Column>[];
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        return Column(children: [
          MyText(
            fontSize: FontConfig.bigFontSize,
            text: label.l_extra_content_ad_free,
          ),
          SizedBox(height: screenDimensions.h(5)),
          MyButton(
            backgroundColor: Colors.greenAccent,
            width: btnWidth,
            customContent: Row(children: [
              SizedBox(width: paddingBetween),
              imageService.getMainImage(
                imageName: "btn_in_app_purchases_background",
                module: "buttons",
                maxWidth: iconWidth,
              ),
              SizedBox(width: paddingBetween),
              MyText(
                text: label.l_buy,
                fontSize: FontConfig.getCustomFontSize(1.1),
                width: btnWidth - iconWidth - paddingBetween * 5,
                alignmentInsideContainer: Alignment.center,
              ),
            ]),
            onClick: () {
              late PurchaseParam purchaseParam;

              if (kIsWeb) {
                MyApp.extraContentBought(context);
                widget._inAppPurchaseLocalStorage
                    .savePurchase(productDetails.id);
                closePopup(context);
                return;
              }
              if (Platform.isAndroid) {
                purchaseParam = GooglePlayPurchaseParam(
                  productDetails: productDetails,
                  applicationUserName: null,
                );
              } else {
                purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                  applicationUserName: null,
                );
              }

              if (productDetails.id == InAppPurchasePopup._kNonConsumableId) {
                widget._inAppPurchase
                    .buyNonConsumable(purchaseParam: purchaseParam);
              }
            },
          ),
        ]);
      },
    ));

    return Container(child: Column(children: productList));
  }

  void deliverProduct(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.productID == InAppPurchasePopup._kNonConsumableId) {
      widget._inAppPurchaseLocalStorage
          .savePurchase(purchaseDetails.purchaseID!);
      setState(() {
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
    showSnackBar("Error " + error.message);
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(
      content: MyText(text: message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          deliverProduct(purchaseDetails);
          showSnackBar(label.l_purchased);
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          deliverProduct(purchaseDetails);
          showSnackBar(label.l_purchased);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await widget._inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = widget._inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
