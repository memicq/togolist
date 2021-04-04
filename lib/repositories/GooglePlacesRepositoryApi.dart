import 'dart:io';

import 'package:google_maps_webservice/places.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';
import 'package:togolist/models/PlaceItem.dart';

class GooglePlacesRepositoryApi {
  // for singleton
  static GooglePlacesRepositoryApi _instance = GooglePlacesRepositoryApi._internal();
  factory GooglePlacesRepositoryApi() => _instance;
  GooglePlacesRepositoryApi._internal(){
    initApiKey();
    initPlacesClient();
  }

  String apiKey;
  GoogleMapsPlaces places;

  void initApiKey() {
    this.apiKey = (Platform.isIOS)
        ? Credentials.googleApiKeyIOS
        : Credentials.googleApiKeyAndroid;
  }

  void initPlacesClient() {
    this.places = GoogleMapsPlaces(apiKey: this.apiKey);
  }

  Future<List<PlaceItem>> searchPlaceByText(String text) async {
    PlacesSearchResponse response = await places.searchByText(text, language: 'ja');
    return response.results.map((res) => PlaceItem(
        googlePlaceId: res.placeId,
        name: res.name,
        address: res.formattedAddress,
        latitude: res.geometry.location.lat,
        longitude: res.geometry.location.lng,
        permanentlyClosed: res.permanentlyClosed
      )).toList();
  }

  Future<PlaceItemDetail> fetchPlaceDetailByPlaceId(String placeId) async {
    PlacesDetailsResponse response = await places.getDetailsByPlaceId(placeId);
    PlaceDetails res = response.result;

    List<MapMarkerPhoto> photos = (res.photos != null ? res.photos : List())
        .map((photo) => MapMarkerPhoto(
        photoReference: photo.photoReference,
        height: photo.height.toInt(),
        width: photo.width.toInt()))
        .toList();

    return PlaceItemDetail(
      name: res.name,
      website: res.website,
      phoneNumber: res.formattedPhoneNumber,
      adrAddress: res.adrAddress,
      formattedAddress: res.formattedAddress,
      types: res.types,
      photos: photos,
    );
  }
}