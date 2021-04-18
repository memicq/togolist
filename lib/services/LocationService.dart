import 'package:location/location.dart';

class LocationService {
//   for singleton
  static final LocationService _locationService = LocationService._internal();
  factory LocationService() => _locationService;
  LocationService._internal() {
    initLocation();
  }

  Location _location;
  final double _latitudeThreshold = 0.0001;
  final double _longitudeThreshold = 0.0001;

  LocationData currentLocation;

  void initLocation() {
    _location = new Location();

    Future(() async {
      currentLocation = await _location.getLocation();
    });

    _location.onLocationChanged().listen((LocationData newLocation) {
      if ((currentLocation.latitude - newLocation.latitude).abs() > _latitudeThreshold
          || (currentLocation.longitude - newLocation.longitude).abs() > _longitudeThreshold) {
        currentLocation = newLocation;
      }
    });
  }
}