enum PlaceListSortingKey {
  PLACE_NAME,
  DISTANCE,
}

enum PlaceListSortingOrder {
  ASC,
  DESC
}

extension PlaceListSortingKeyExt on PlaceListSortingKey {
  String get code {
    switch (this) {
      case PlaceListSortingKey.PLACE_NAME:
        return "name";
        break;
      case PlaceListSortingKey.DISTANCE:
        return "distance";
        break;
    }
  }

  String get name {
    switch (this) {
      case PlaceListSortingKey.PLACE_NAME:
        return "名前";
        break;
      case PlaceListSortingKey.DISTANCE:
        return "距離";
        break;
    }
  }

  bool get isNumber {
    switch (this) {
      case PlaceListSortingKey.DISTANCE:
        return true;
        break;
      case PlaceListSortingKey.PLACE_NAME:
        return false;
        break;
    }
  }
}

class PlaceListSortingKeyUtil {
  static Map<String, PlaceListSortingKey> _codeKeyMap = Map.fromIterables(
      PlaceListSortingKey.values.map((key) => key.code),
      PlaceListSortingKey.values
  );

  static PlaceListSortingKey fromCode(String code) {
    assert(_codeKeyMap.keys.toList().contains(code));
    return _codeKeyMap[code];
  }
}