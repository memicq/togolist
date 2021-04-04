import 'package:togolist/models/MapMarkerPhoto.dart';

class MapMarker {
  String markerId;
  String googlePlaceId;

  String name;
  double latitude;
  double longitude;
  String address;
  String adrAddress;

  String website;
  String phoneNumber;

  List<String> types;
  List<MapMarkerPhoto> photos = List();
  bool permanentlyClosed;

  bool visited = false;
  String memo = '';
  double distanceFromMe = null;

  MapMarker({
    this.markerId = null,
    this.googlePlaceId,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.adrAddress,
    this.website,
    this.phoneNumber,
    this.types,
    this.photos,
    this.permanentlyClosed,
    this.visited = false,
    this.memo = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'googlePlaceId': this.googlePlaceId,
      'name': this.name,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'address': this.address,
      'adrAddress': this.adrAddress,
      'website': this.website,
      'phoneNumber': this.phoneNumber,
      'typeString': this.types.join(','),
      'permanentlyClosed': this.permanentlyClosed,
      'visited': this.visited,
      'memo': this.memo
    };
  }
}
