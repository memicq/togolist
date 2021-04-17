import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';

class PlaceDetailTitleArea extends StatefulWidget {
  MapMarker marker;
  PlaceDetailTitleArea({this.marker});
  @override
  State<StatefulWidget> createState() => PlaceDetailTitleAreaState();
}
class PlaceDetailTitleAreaState extends State<PlaceDetailTitleArea> {

  Widget buildIcon(){
    if (widget.marker.visited == true)
      return Icon(Icons.place_rounded, color: ColorSettings.primaryColor);
    else return Icon(Icons.place_outlined, color: ColorSettings.primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceViewModel>(builder: (context, model, child) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 3),
                  child: buildIcon()
                ),
                Text(
                  widget.marker.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(
              widget.marker.address,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      );
    });
  }
}