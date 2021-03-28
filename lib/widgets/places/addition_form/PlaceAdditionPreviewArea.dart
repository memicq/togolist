import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/PlaceItem.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailImageArea.dart';

class PlaceAdditionPreviewArea extends StatelessWidget {

  PlaceItem placeItem = null;

  PlaceAdditionPreviewArea({this.placeItem});

  Widget buildPlacePreviewImageArea() {
    if (this.placeItem != null && this.placeItem.photos != null) {
      return PlaceDetailImageArea(googlePhotos: this.placeItem.photos);
    } else {
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.black12.withOpacity(0.05),
        child: Icon(Icons.image_not_supported_outlined, color: Colors.black38, size: 70),
      );
    }
  }

  Widget buildPlacePreviewTitleArea() {
    Icon icon = (this.placeItem != null)
        ? Icon(Icons.add_location_alt_outlined, color: ColorSettings.primaryColor)
        : Icon(Icons.add_location_alt_outlined, color: Colors.black54);
    Widget name = (this.placeItem != null && this.placeItem.name != null)
        ? Text(this.placeItem.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)
        : Text("場所が選択されていません", style: TextStyle(fontSize: 16));

    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: name
              )
            ],
          ),
          if (this.placeItem != null)
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                this.placeItem.address,
                style: TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildPlacePreviewImageArea(),
          buildPlacePreviewTitleArea(),
        ],
      ),
    );
  }
}
