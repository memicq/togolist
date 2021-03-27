import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationViewModel extends ChangeNotifier {
  Location _locationService = Location();

  LocationData currentLocation;

  LocationViewModel() {
    Future(() async {
      updateLocation(await _locationService.getLocation());

      _locationService.onLocationChanged().listen((LocationData result) {
        updateLocation(result);
      });
    });
  }

  void updateLocation(LocationData newLocation) {
    currentLocation = newLocation;
    notifyListeners();
  }
}
