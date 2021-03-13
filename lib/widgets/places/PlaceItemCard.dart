
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';

class PlaceItemCard extends StatelessWidget {
  MapMarker marker;

  PlaceItemCard({this.marker});

  void openPlaceDetailPage(BuildContext context) {
    Navigator.of(
        context,
        rootNavigator: true
    ).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("detail"),
            ),
            body: Center(
              child: Text("detail"),
            ),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        child: InkWell(
          onTap: () => openPlaceDetailPage(context),
          onLongPress: () => { print("long pressed!") },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.place, color: ColorSettings.primaryColor, size: 18),
                    ),
                    Expanded(
                      child: Text(
                        marker.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Text(
                    marker.address,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}
