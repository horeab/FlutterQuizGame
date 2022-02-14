import 'package:flutter_app_quiz_game/Implementations/DopeWars/Constants/dopewars_resource_type.dart';

class DopeWarsLocation {
  static late DopeWarsLocation location0;
  static late DopeWarsLocation location1;
  static late DopeWarsLocation location2;
  static late DopeWarsLocation location3;
  static late DopeWarsLocation location4;
  static late DopeWarsLocation location5;

  List<DopeWarsLocation> locations = [
    location0 = DopeWarsLocation(
        0,
        "New York",
        [
          DopeWarsResourceType.res4,
          DopeWarsResourceType.res5,
        ],
        [
          DopeWarsResourceType.res0,
        ],
        null,
        3),
    location1 = DopeWarsLocation(
        1,
        "Rio de Janeiro",
        [
          DopeWarsResourceType.res11,
          DopeWarsResourceType.res9,
        ],
        [
          DopeWarsResourceType.res0,
          DopeWarsResourceType.res1,
          DopeWarsResourceType.res2,
        ],
        75,
        3),
    location2 = DopeWarsLocation(
        2,
        "Beijing",
        [
          DopeWarsResourceType.res8,
        ],
        [
          DopeWarsResourceType.res6,
          DopeWarsResourceType.res7,
        ],
        150,
        3),
    location3 = DopeWarsLocation(
        3,
        "Sydney",
        [
          DopeWarsResourceType.res8,
          DopeWarsResourceType.res9,
        ],
        [
          DopeWarsResourceType.res10,
        ],
        250,
        3),
    location4 = DopeWarsLocation(
        4,
        "Berlin",
        [
          DopeWarsResourceType.res1,
          DopeWarsResourceType.res10,
        ],
        [
          DopeWarsResourceType.res7,
          DopeWarsResourceType.res9,
        ],
        350,
        3),
    location5 = DopeWarsLocation(
        5,
        "Cape Town",
        [
          DopeWarsResourceType.res0,
          DopeWarsResourceType.res4,
          DopeWarsResourceType.res9,
        ],
        [
          DopeWarsResourceType.res11,
        ],
        800,
        3),
  ];

  int index;
  String locationLabel;
  List<DopeWarsResourceType> cheapResources;
  List<DopeWarsResourceType> expensiveResources;
  int? unlockPricePercent;
  int travelPricePercent;

  DopeWarsLocation(
      this.index,
      this.locationLabel,
      this.cheapResources,
      this.expensiveResources,
      this.unlockPricePercent,
      this.travelPricePercent);
}
