import 'dart:convert';

import 'package:geodesy/geodesy.dart';
import 'package:http/http.dart' as http;
import 'package:togolist/models/Station.dart';

// @see(http://express.heartrails.com/api.html)
// @see(http://express.heartrails.com/api/json?method=getStations)

class ExpressHeartrailsRepositoryApi {
  // for singleton
  static ExpressHeartrailsRepositoryApi _instance = ExpressHeartrailsRepositoryApi._internal();
  factory ExpressHeartrailsRepositoryApi() => _instance;
  ExpressHeartrailsRepositoryApi._internal();

  Future<List<Station>> listNearestStations(double latitude, double longitude) async {
    String url = "https://togolistapi.herokuapp.com/near_stations?latitude=${latitude}&longitude=${longitude}";
    http.Response res = await http.get(url);
    List<dynamic> stations = json.decode(res.body)['response']['station'];
    return stations.map((station) {
      return Station(
        name: station['name'],
        prefecture: station['prefecture'],
        line: station['line'],
        latitude: station['y'],
        longitude: station['x'],
        markerCounts: 0
      );
    }).toList();
  }
}