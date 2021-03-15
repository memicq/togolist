class MapMarker {
  String markerId;
  String title;
  String address;
  double latitude;
  double longitude;

  MapMarker({this.markerId = null, this.title, this.address, this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}