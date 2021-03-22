
import 'package:flutter/services.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class PlaceItem {
  String name;

  String address;

  double latitude;
  double longitude;

  List<MapMarkerPhoto> photos = List();

  PlaceItem({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.photos
  });

  @override
  String toString() {
    return "$name, $address, ($latitude, $longitude) with ${photos.length} photos";
  }
}