
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';

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
    return Consumer<MapViewModel>(builder: (context, model, child) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children:<Widget> [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: FlatButton(
                    child: buildIcon(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      model.toggleVisited(widget.marker);
                    },
                  ),
                ),
                Text(
                  widget.marker.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Text(
              widget.marker.address,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    });
  }
}