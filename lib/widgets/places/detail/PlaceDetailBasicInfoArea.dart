import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/services/ExternalUrlLaunchService.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailBasicInfoArea extends StatelessWidget {
  MapMarker marker;
  PlaceDetailBasicInfoArea({this.marker});

  ExternalUrlLaunchService _launchService = ExternalUrlLaunchService();

  Widget buildOpeningHoursTable() {
    if (this.marker.openingHoursJson != null) {
      return PlaceDetailItemCard(
        title: "営業情報",
        content: Container(
            padding: EdgeInsets.only(left: 40),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: buildOpeningHourTableRows(),
            )
        ),
      );
    } else return Container();
  }

  List<TableRow> buildOpeningHourTableRows() {
    return this.marker.getOpeningHours().entries.map((e) {
      return TableRow(
        children: [
          Text(e.key),
          Text(e.value)
        ]
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaceDetailItemCard(
              title: "住所",
              content: Text(this.marker.adrAddress, style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            PlaceDetailItemCard(
              title: "コンタクト",
              content: Row(
                children: [
                  IconButton(icon: Icon(Icons.phone_forwarded), onPressed: () {
                    _launchService.launchPhone(this.marker.phoneNumber);
                  }),
                  IconButton(icon: Icon(Icons.open_in_new), onPressed: () {
                    _launchService.launchInBrowser(this.marker.website);
                  }),
                  IconButton(icon: Icon(FontAwesomeIcons.instagram), onPressed: () {}),
                  IconButton(icon: Icon(FontAwesomeIcons.twitter), onPressed: () {}),
                  IconButton(icon: Icon(FontAwesomeIcons.facebook), onPressed: () {}),
                ],
              ),
            ),
            buildOpeningHoursTable(),
            PlaceDetailItemCard(
              title: "場所タイプ",
              content: Text(this.marker.types.join(", "), style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            SizedBox(
              height: 200,
            )
          ],
        ));
  }
}
