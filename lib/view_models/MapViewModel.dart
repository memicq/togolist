import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';

class MapViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();

  MapMarker marker;
  List<MapMarker> markers = List();
  MapMarkerFilterCondition condition = MapMarkerFilterCondition();

  Future<void> fetchMarkers() async {
    this.markers = await _markerRepositoryFB.listMarker();
    this._filter(this.condition);
    this._sort(PlaceListSortingKey.PLACE_NAME, PlaceListSortingOrder.ASC);
    notifyListeners();
  }

  Future<void> addMarker() async {
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

  void updateCondition(MapMarkerFilterCondition condition) {
    this.condition = condition;
  }

  void _sort(PlaceListSortingKey sortingKey, PlaceListSortingOrder sortingOrder) {
    if (sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.markers.sort((a, b) => a.title.compareTo(b.title));
      } else {
        this.markers.sort((b, a) => a.title.compareTo(b.title));
      }
    } else if (sortingKey == PlaceListSortingKey.DISTANCE) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.markers.sort((a, b) => a.distanceFromMe.compareTo(b.distanceFromMe));
      } else {
        this.markers.sort((b, a) => a.distanceFromMe.compareTo(b.distanceFromMe));
      }
    }
  }

  void _filter(MapMarkerFilterCondition condition) {
    var filteredMarkers = this.markers;

    if (condition.visitedCondition == MapMarkerFilterVisited.VISITED) {
      filteredMarkers = this.markers.where((m) => m.visited == true).toList();
    } else if (condition.visitedCondition == MapMarkerFilterVisited.NOT_VISITED) {
      filteredMarkers = this.markers.where((m) => m.visited == false).toList();
    }

    this.markers = filteredMarkers;
  }
}
