
import 'package:flutter/material.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class PlaceDetailImageArea extends StatelessWidget {
  List<MapMarkerPhoto> googlePhotos;
  List<Image> images = List();

  PlaceDetailImageArea({this.googlePhotos}){
    images = fetchImages();
  }

  List<Image> fetchImages() {
    return this.googlePhotos.map((photo) {
      return Image.network(
          "https://maps.googleapis.com/maps/api/place/photo"
              "?maxwidth=400"
              "&photoreference=${photo.photoReference}"
              "&key=${Credentials.googleApiKeyIOS}");
    }).toList();
  }

  List<Widget> buildImages() {
    List<Widget> images = this.images.map((image) {
      return Padding(
        padding: EdgeInsets.only(left: 10),
        child: image,
      );
    }).toList();
    images.shuffle();
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buildImages(),
      ),
    );
  }
}