import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';

class PlaceViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();

  List<MapMarker> viewMarkers = List();

  Future<void> fetchMarkers() async {
    this.viewMarkers = await _markerRepositoryFB.listMarker();
    this._sort(PlaceListSortingKey.PLACE_NAME, PlaceListSortingOrder.ASC);
    notifyListeners();
  }

  Future<void> addMarker(MapMarker marker) async {
    await _markerRepositoryFB.createMarker(marker);
    await fetchMarkers();
    notifyListeners();
  }

  Future<void> deleteMarker(MapMarker marker) async {
    await _markerRepositoryFB.deleteMarker(marker);
    await fetchMarkers();
    notifyListeners();
  }

  void sortMarkers({
    PlaceListSortingKey sortingKey = PlaceListSortingKey.PLACE_NAME,
    PlaceListSortingOrder sortingOrder = PlaceListSortingOrder.ASC
  }) {
    this._sort(sortingKey, sortingOrder);
    notifyListeners();
  }

  void _sort(PlaceListSortingKey sortingKey, PlaceListSortingOrder sortingOrder) {
    if (sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.title.compareTo(b.title));
      } else {
        this.viewMarkers.sort((b, a) => a.title.compareTo(b.title));
      }
    } else if (sortingKey == PlaceListSortingKey.DISTANCE) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.distanceFromMe.compareTo(b.distanceFromMe));
      } else {
        this.viewMarkers.sort((b, a) => a.distanceFromMe.compareTo(b.distanceFromMe));
      }
    }
  }
}