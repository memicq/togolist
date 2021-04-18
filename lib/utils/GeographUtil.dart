import 'package:geodesy/geodesy.dart';

class GeoPoint {
  double latitude;
  double longitude;

  GeoPoint({this.latitude, this.longitude});
}

class GeographUtil {
  static double calculateDistanceKm(GeoPoint gp1, GeoPoint gp2) {
    Geodesy geodesy = Geodesy();
    LatLng ll1 = LatLng(gp1.latitude, gp1.longitude);
    LatLng ll2 = LatLng(gp2.latitude, gp2.longitude);
    double distanceMeter = geodesy.distanceBetweenTwoGeoPoints(ll1, ll2);
    return ((distanceMeter / 10.0).roundToDouble() / 100.0);
  }
}