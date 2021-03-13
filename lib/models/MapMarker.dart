class MapMarker {
  MapMarker({this.title, this.address, this.latitude, this.longitude});

  String title;
  String address;
  double latitude;
  double longitude;

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}