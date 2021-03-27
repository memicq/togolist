import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailView.dart';

class PlaceItemCard extends StatefulWidget {
  MapMarker marker;
  PlaceItemCard({Key key, this.marker}): super(key: key);

  @override
  State<PlaceItemCard> createState() => PlaceItemCardState();
}

class PlaceItemCardState extends State<PlaceItemCard> {

  SlidableState slidable;

  void openPlaceDetailPage(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) {
      return PlaceDetailView(marker: widget.marker);
    }));
  }

  Icon buildIcon() {
    if (widget.marker == null ||
        widget.marker.visited == null ||
        !widget.marker.visited) {
      return Icon(Icons.place_outlined,
          color: ColorSettings.primaryColor, size: 18);
    } else {
      return Icon(Icons.place_rounded,
          color: ColorSettings.primaryColor, size: 18);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (slidable == null) {
      slidable = Slidable.of(context);
    }
  }

  void closeSlidable() {
    slidable.close();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        child: InkWell(
          onTap: () => openPlaceDetailPage(context),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: buildIcon(),
                    ),
                    Expanded(
                      child: Text(
                        widget.marker.title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(widget.marker.address,
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ));
  }
}
