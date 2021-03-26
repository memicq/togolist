import 'package:togolist/models/MapMarkerPhoto.dart';

class MapMarker {
  String markerId;
  String title;
  String address;
  double latitude;
  double longitude;
  bool visited = false;
  List<MapMarkerPhoto> photos = List();

  MapMarker({
    this.markerId = null,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.visited = false,
    this.photos
  });

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'visited': this.visited
    };
  }
}
