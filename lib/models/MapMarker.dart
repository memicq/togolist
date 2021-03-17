class MapMarker {
  String markerId;
  String title;
  String address;
  double latitude;
  double longitude;
  bool isShared = false;

  MapMarker({this.markerId = null, this.title, this.address, this.latitude, this.longitude, this.isShared = false});

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'isShared': this.isShared
    };
  }
}