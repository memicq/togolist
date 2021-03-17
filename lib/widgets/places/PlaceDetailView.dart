import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';

class PlaceDetailView extends StatelessWidget {

  MapMarker marker;
  PlaceDetailView({this.marker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("detail"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text(
              this.marker.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontSize: 15
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              this.marker.address,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      )
    );
  }
}