
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';

class PlaceDetailTitleArea extends StatelessWidget {
  MapMarker marker;
  PlaceDetailTitleArea({this.marker});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.place_rounded,
                    color: ColorSettings.primaryColor),
              ),
              Text(
                this.marker.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Text(
            this.marker.address,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}