import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';

class PlaceViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();

  List<MapMarker> viewMarkers = List();

  PlaceListSortingKey _sortingKey = PlaceListSortingKey.PLACE_NAME;
  PlaceListSortingOrder _sortingOrder = PlaceListSortingOrder.ASC;

  Future<void> fetchMarkers() async {
    this.viewMarkers = await _markerRepositoryFB.listMarker();
    this._sort();
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
    this._sortingKey = sortingKey;
    this._sortingOrder = sortingOrder;
    this._sort();
    notifyListeners();
  }

  void _sort() {
    if (_sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.title.compareTo(b.title));
      } else {
        this.viewMarkers.sort((b, a) => a.title.compareTo(b.title));
      }
    } else if (_sortingKey == PlaceListSortingKey.DISTANCE) {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.distanceFromMe.compareTo(b.distanceFromMe));
      } else {
        this.viewMarkers.sort((b, a) => a.distanceFromMe.compareTo(b.distanceFromMe));
      }
    }
  }

  PlaceListSortingKey getCurrentSortingKey() {
    return _sortingKey;
  }

  PlaceListSortingOrder getCurrentSortingOrder() {
    return _sortingOrder;
  }
}