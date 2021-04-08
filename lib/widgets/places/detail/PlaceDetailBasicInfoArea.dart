import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/services/ExternalUrlLaunchService.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailBasicInfoArea extends StatelessWidget {
  MapMarker marker;
  PlaceDetailBasicInfoArea({this.marker});

  ExternalUrlLaunchService _launchService = ExternalUrlLaunchService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaceDetailItemCard(
              title: "住所",
              content: Text(this.marker.address, style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            PlaceDetailItemCard(
              title: "コンタクト",
              content: Row(
                children: [
                  IconButton(icon: Icon(Icons.phone_forwarded), onPressed: () {
                    _launchService.launchPhone(this.marker.phoneNumber);
                  }),
                  IconButton(icon: Icon(Icons.open_in_new), onPressed: () {}),
                ],
              ),
            ),
            PlaceDetailItemCard(
              title: "営業情報",
              content: Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text("月曜日: 9:00 - 20:00", style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ),
            PlaceDetailItemCard(
              title: "場所タイプ",
              content: Text(this.marker.types.join(", "), style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ));
  }
}
