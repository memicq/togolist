import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';

class MapViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();

  List<MapMarker> viewMarkers = List();
  MapMarkerFilterCondition condition = MapMarkerFilterCondition();

  Future<void> fetchMarkers() async {
    this.viewMarkers = await _markerRepositoryFB.listMarker();
    this._filter(this.condition);
    notifyListeners();
  }

  void updateCondition(MapMarkerFilterCondition condition) {
    this.condition = condition;
  }

  void _filter(MapMarkerFilterCondition condition) {
    var filteredMarkers = this.viewMarkers;

    if (condition.visitedCondition == MapMarkerFilterVisited.VISITED) {
      filteredMarkers = this.viewMarkers.where((m) => m.visited == true).toList();
    } else if (condition.visitedCondition == MapMarkerFilterVisited.NOT_VISITED) {
      filteredMarkers = this.viewMarkers.where((m) => m.visited == false).toList();
    }

    this.viewMarkers = filteredMarkers;
  }
}
