import 'package:flutter_app_quiz_game/Implementations/DopeWars/Constants/dopewars_resource_type.dart';

import 'dopewars_resource.dart';

class DopeWarsResourceInventory extends DopeWarsResource {
  int amount;

  DopeWarsResourceInventory(
      this.amount, DopeWarsResourceType resourceType, int price)
      : super(resourceType, price);

  DopeWarsResourceInventory.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map.addAll({'amount': amount});
    return map;
  }
}
