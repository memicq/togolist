import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailImageArea.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailTitleArea.dart';

class PlaceDetailView extends StatelessWidget {
  MapMarker marker;

  PlaceDetailView({this.marker});

  List<String> tags = ["tag1", "tag2", "tag3"];

  List<Widget> buildTags() {
    return tags
        .map((tag) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Chip(
                label: Text(
                  tag,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                backgroundColor: Colors.deepOrange.shade500,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("detail"),
          backgroundColor: Colors.white,
        ),
        body: Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Column(children: [
              PlaceDetailTitleArea(marker: this.marker),
              if (this.marker.photos.length != 0)
                PlaceDetailImageArea(googlePhotos: this.marker.photos),
              Container(
                child: Row(
                  children: buildTags(),
                ),
              ),
            ])
        )
    );
  }
}
