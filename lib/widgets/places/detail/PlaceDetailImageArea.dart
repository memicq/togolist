
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class PlaceDetailImageArea extends StatelessWidget {
  List<MapMarkerPhoto> googlePhotos;
  PlaceDetailImageArea({this.googlePhotos});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black12,
      child: Container(child: Image.network(
          "https://maps.googleapis.com/maps/api/place/photo"
              "?maxwidth=400"
              "&photoreference=${this.googlePhotos[0].photoReference}"
              "&key=${Credentials.googleApiKeyIOS}"
      )),
    );
  }
}