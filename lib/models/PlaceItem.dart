
import 'package:flutter/services.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class PlaceItem {
  String name;

  String address;

  double latitude;
  double longitude;

  String googlePlaceId;

  PlaceItemDetail placeItemDetail;

  bool permanentlyClosed;

  PlaceItem({
    this.googlePlaceId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.permanentlyClosed
  });

  void setPlaceItemDetail(PlaceItemDetail detail){
    this.placeItemDetail = detail;
  }

  @override
  String toString() {
    return "$name, $address, ($latitude, $longitude)";
  }
}

class PlaceItemDetail {
  String name;
  String website;
  String phoneNumber;
  String adrAddress;
  String formattedAddress;
  List<String> types;
  List<MapMarkerPhoto> photos;

  PlaceItemDetail({
    this.name,
    this.website,
    this.phoneNumber,
    this.adrAddress,
    this.formattedAddress,
    this.types,
    this.photos,
  });

  @override
  String toString() {
    return "$name, $website, $phoneNumber, $adrAddress, $formattedAddress with ${photos.length} photos";
  }
}