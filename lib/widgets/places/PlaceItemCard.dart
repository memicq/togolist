import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:togolist/view_models/MapViewModel.dart';

class PlaceItemCard extends StatefulWidget {
  MapMarker marker;

  PlaceItemCard({this.marker});

  @override
  State<PlaceItemCard> createState() => PlaceItemCardState();
}

class PlaceItemCardState extends State<PlaceItemCard> {
  bool showDeleteButton = false;

  void openPlaceDetailPage(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("detail"),
        ),
        body: Center(
          child: Text("detail"),
        ),
      );
    }));
  }

  void toggleShowDeleteButton() {
    setState(() {
      this.showDeleteButton = !this.showDeleteButton;
    });
  }

  Widget buildCard(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        child: InkWell(
          onTap: () => openPlaceDetailPage(context),
          onLongPress: () => toggleShowDeleteButton(),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.place,
                          color: ColorSettings.primaryColor, size: 18),
                    ),
                    Expanded(
                      child: Text(
                        widget.marker.title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Text(widget.marker.address,
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ));
  }

  void deleteMarker(MapViewModel model) async {
    print("delete button tapped! ${widget.marker.markerId}");
    await model.deleteMarker(widget.marker);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: buildCard(context),
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Consumer<MapViewModel>(builder: (context, model, child) {
            return IconSlideAction(
              caption: '削除',
              color: Colors.red,
              icon: Icons.delete_outline,
              onTap: () => deleteMarker(model),
            );
          }),
        )
      ],
    );
  }
}
