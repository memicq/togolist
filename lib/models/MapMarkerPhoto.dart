class MapMarkerPhoto {
  String photoReference;
  int height;
  int width;

  MapMarkerPhoto({this.photoReference, this.height, this.width});

  Map<String, dynamic> toJson() {
    return {
      'photoReference': this.photoReference,
      'height': this.height,
      'width': this.width
    };
  }
}
