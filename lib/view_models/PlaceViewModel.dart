import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/models/Station.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';
import 'package:togolist/repositories/StationRepositoryFB.dart';

class PlaceViewModel extends ChangeNotifier {
  MarkerRepositoryFB _markerRepositoryFB = MarkerRepositoryFB();
  StationRepositoryFB _stationRepositoryFB = StationRepositoryFB();

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

  Future<void> addMarker(MapMarker marker, List<Station> stations) async {
    marker.stationIds = await saveStations(stations);
    await _markerRepositoryFB.createMarker(marker);
    await fetchMarkers();
  }

  Future<void> deleteMarker(MapMarker marker) async {
    await _stationRepositoryFB.decrementCount(marker.stationIds);
    List<Station> stations = await _stationRepositoryFB.listStationsByIds(marker.stationIds);
    List<String> deleteIds = stations
        .where((station) => station.markerCounts == 0)
        .map((station) => station.stationId).toList();
    await _stationRepositoryFB.batchDelete(deleteIds);

    await _markerRepositoryFB.deleteMarker(marker);
    await fetchMarkers();
  }

  Future<void> toggleVisited(MapMarker marker) async {
    bool updated = !marker.visited;
    await _markerRepositoryFB.updateVisited(marker, updated);
    MapMarker m = this.viewMarkers.firstWhere((m) => m.markerId == marker.markerId);
    if (m != null){ m.visited = updated; }
    notifyListeners();
  }

  Future<MapMarker> saveMemo(MapMarker marker, String memo) async {
    await _markerRepositoryFB.updateMemo(marker, memo);
    marker.memo = memo;
    notifyListeners();
    return marker;
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

  void _sort(){
    if (_sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => a.name.compareTo(b.name));
      } else {
        this.viewMarkers.sort((b, a) => a.name.compareTo(b.name));
      }
    } else if (_sortingKey == PlaceListSortingKey.DISTANCE) {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        this.viewMarkers.sort((a, b) => _compareWithNull(a.distanceFromMe, b.distanceFromMe));
      } else {
        this.viewMarkers.sort((b, a) => _compareWithNull(a.distanceFromMe, b.distanceFromMe));
      }
    }
  }

  Future<List<String>> saveStations(List<Station> stations) async {
    List<Station> existingStations = await _stationRepositoryFB.listStations();

    List<Station> commonStations = existingStations
        .where((station) => stations.indexWhere((s) => Station.checkSameStation(s, station)) != -1)
        .toList();
    List<Station> newStations = stations
        .where((station) => commonStations.indexWhere((s) => Station.checkSameStation(s, station)) == -1)
        .toList();
    List<String> newStationIds = (await _stationRepositoryFB.saveStations(newStations)).whereType<String>().toList();
    List<String> commonIds = commonStations.map((s) => s.stationId).whereType<String>().toList();
    List<String> bindingIds = newStationIds + commonIds;

    await _stationRepositoryFB.incrementCount(bindingIds);

    return bindingIds;
  }

  int _compareWithNull(double a, double b) {
    if (b == null) return -1;
    else if (a == null) return 1;
    else return a.compareTo(b);
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

  bool isEmptyMarker() {
    return _fullMarkers.isNotEmpty;
  }

  bool isEmptyViewMarker() {
    return viewMarkers.isNotEmpty;
  }

  int getTotalCount() {
    return _fullMarkers.length;
  }

  int getDisplayCount() {
    return viewMarkers.length;
  }
}