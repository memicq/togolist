
import 'package:flutter/material.dart';
import 'package:togolist/models/Station.dart';
import 'package:togolist/repositories/StationRepositoryFB.dart';

class StationViewModel extends ChangeNotifier {
  StationRepositoryFB _stationRepositoryFB = StationRepositoryFB();

  List<Station> _stations;

  Future<void> fetchStations() async {
    this._stations = await _stationRepositoryFB.listStations();
    notifyListeners();
  }

  List<Station> getFilteredStations(List<String> stationIds) {
    fetchStations();
    if (this._stations != null) {
      return _stations.where((s) => stationIds.contains(s.stationId)).whereType<Station>().toList();
    } else {
      return List();
    }
  }
}