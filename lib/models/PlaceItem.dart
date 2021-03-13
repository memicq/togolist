
import 'package:flutter/services.dart';

class PlaceItem {
  String name;

  String address;

  double latitude;
  double longitude;

  PlaceItem({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return "$name, $address, ($latitude, $longitude)";
  }
}