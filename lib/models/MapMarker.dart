import 'package:togolist/models/MapMarkerPhoto.dart';

class MapMarker {
  String markerId;
  String title;
  String address;
  double latitude;
  double longitude;
  bool isShared = false;
  List<MapMarkerPhoto> photos = List();

  MapMarker({
    this.markerId = null,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.isShared = false,
    this.photos
  });

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'isShared': this.isShared
    };
  }
}