import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';

class PlaceViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();

  List<MapMarker> _fullMarkers = List();
  List<MapMarker> viewMarkers = List();

  PlaceListSortingKey _sortingKey = PlaceListSortingKey.PLACE_NAME;
  PlaceListSortingOrder _sortingOrder = PlaceListSortingOrder.ASC;
  String _filterQuery = '';

  Future<void> fetchMarkers() async {
    this._fullMarkers = await _markerRepositoryFB.listMarker();
    this.viewMarkers = this._fullMarkers;
    this._filter();
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

  Future<void> toggleVisited(MapMarker marker) async {
    bool updated = !marker.visited;
    await _markerRepositoryFB.updateVisited(marker, updated);
    MapMarker m = this.viewMarkers.firstWhere((m) => m.markerId == marker.markerId);
    if (m != null){ m.visited = updated; }
    notifyListeners();
  }

  void filterMarkers(String query) {
    this._filterQuery = query;
    this._filter();
    this._sort();
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

  void _filter() {
    List<MapMarker> filteredMarkers = this._fullMarkers.where((marker) =>
    marker.name.contains(this._filterQuery) || marker.address.contains(this._filterQuery)
    ).toList();
    this.viewMarkers = filteredMarkers;
  }

  void _sort() {
    if (_sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.name.compareTo(b.name));
      } else {
        this.viewMarkers.sort((b, a) => a.name.compareTo(b.name));
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

  String getFilterQuery() {
    return _filterQuery;
  }
}