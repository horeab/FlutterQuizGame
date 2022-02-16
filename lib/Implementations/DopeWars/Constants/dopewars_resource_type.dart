import 'package:flutter_app_quiz_game/Implementations/DopeWars/Service/dopewars_price_service.dart';

class DopeWarsResourceType {
  static late DopeWarsResourceType res0;
  static late DopeWarsResourceType res1;
  static late DopeWarsResourceType res2;
  static late DopeWarsResourceType res3;
  static late DopeWarsResourceType res4;
  static late DopeWarsResourceType res5;
  static late DopeWarsResourceType res6;
  static late DopeWarsResourceType res7;
  static late DopeWarsResourceType res8;
  static late DopeWarsResourceType res9;
  static late DopeWarsResourceType res10;
  static late DopeWarsResourceType res11;

  static List<DopeWarsResourceType> resources = [
    res0 = DopeWarsResourceType(0, "gems", "Gems", 600),
    res1 = DopeWarsResourceType(1, "car", "Cars", 240),
    res2 = DopeWarsResourceType(2, "electronics", "Electronics", 100),
    res3 = DopeWarsResourceType(3, "medicine", "Medicine", 60),
    res4 = DopeWarsResourceType(4, "iron", "Iron", 40),
    res5 = DopeWarsResourceType(5, "perfume", "Perfume", 22),
    res6 = DopeWarsResourceType(6, "oil", "Oil", 20),
    res7 = DopeWarsResourceType(7, "wheat", "Wheat", 18),
    res8 = DopeWarsResourceType(8, "clothing", "Clothes", 8),
    res9 = DopeWarsResourceType(9, "fruits", "Fruit", 5),
    res10 = DopeWarsResourceType(10, "coal", "Coal", 4),
    res11 = DopeWarsResourceType(11, "coffee", "Coffee", 3),
  ];

  int index;
  String resourceImgName;
  String resourceLabel;
  final int _standardPricePercent;

  DopeWarsResourceType(this.index, this.resourceImgName, this.resourceLabel,
      this._standardPricePercent);

  int get standardPrice =>
      DopeWarsPriceService.getPriceBasedOnStartingBudgetWithPercent(
          _standardPricePercent);

  DopeWarsResourceType.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        resourceImgName = json['resourceImgName'],
        resourceLabel = json['resourceLabel'],
        _standardPricePercent = json['_standardPricePercent'];

  Map<String, dynamic> toJson() => {
        'index': index,
        'resourceImgName': resourceImgName,
        'resourceLabel': resourceLabel,
        '_standardPricePercent': _standardPricePercent,
      };
}
