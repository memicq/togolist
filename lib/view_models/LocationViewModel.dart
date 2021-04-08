import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationViewModel extends ChangeNotifier {
  Location _locationService = Location();

  LocationData currentLocation;

  final double _latitudeThreshold = 0.0001;
  final double _longitudeThreshold = 0.0001;

  LocationViewModel() {
    Future(() async {
      updateLocation(await _locationService.getLocation());

      _locationService.onLocationChanged().listen((LocationData result) {
        if ((currentLocation.latitude - result.latitude).abs() > _latitudeThreshold
            || (currentLocation.longitude - result.longitude).abs() > _longitudeThreshold) {
          updateLocation(result);
        }
      });
    });
  }

  void updateLocation(LocationData newLocation) {
    currentLocation = newLocation;
    notifyListeners();
  }
}
