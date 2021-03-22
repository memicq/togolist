
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {
  static final LocationService _locationService = LocationService._internal();

  factory LocationService() {
    return _locationService;
  }

  LocationService._internal();

  Location _location = new Location();
  String _errorText = null;

  Future<LocationData> getCurrentLocation() async {
    LocationData location;

    try {
      location = await _location.getLocation();
    } on PlatformException catch(e) {
      if (e.code == 'PERMISSION_DENITED')
        _errorText = 'Permission denited';
      else if (e.code == 'PERMISSION_DENITED_NEVER_ASK')
        _errorText = 'Permission denited - please ask the user to enable it from the app settings';

      location = null;
    }

    return location;
  }
}