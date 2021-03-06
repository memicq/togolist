import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailView.dart';

class PlaceItemCard extends StatefulWidget {
  MapMarker marker;

  PlaceItemCard({Key key, this.marker}) : super(key: key);

  @override
  State<PlaceItemCard> createState() => PlaceItemCardState();
}

class PlaceItemCardState extends State<PlaceItemCard> {
  SlidableState slidable;
  PlaceViewModel _placeViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (slidable == null) {
      slidable = Slidable.of(context);
    }

    _placeViewModel = Provider.of<PlaceViewModel>(context, listen: false);
  }

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

  void closeSlidable() {
    slidable.close();
  }

  Widget buildDistance() {
    if (widget.marker.distanceFromMe != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 2, bottom: 1),
                child: Icon(Icons.directions_walk_rounded, size: 15, color: Color(0xBB000000))
            ),
            Text(
              "${widget.marker.distanceFromMe} km",
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xBB000000)
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void updateVisited() async {
    _placeViewModel.toggleVisited(widget.marker);
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
                      padding: EdgeInsets.only(right: 5),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        splashRadius: 20,
                        constraints: BoxConstraints.tight(Size(18, 18)),
                        onPressed: updateVisited,
                        icon: buildIcon(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.marker.name,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    buildDistance()
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
