import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/const/FontSettings.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceItem.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionFormDialog.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionPreviewArea.dart';

class PlaceAdditionBackdrop extends StatefulWidget {
  @override
  State<PlaceAdditionBackdrop> createState() => PlaceAdditionBackdropState();
}

class PlaceAdditionBackdropState extends State<PlaceAdditionBackdrop> {
  PlaceItem selectedPlaceItem = null;

  void updateSelectedItem(PlaceItem item) {
    setState(() {
      this.selectedPlaceItem = item;
    });
  }

  void savePlace(BuildContext context, MapViewModel model) async {
    if (selectedPlaceItem != null) {
      model.marker = MapMarker(
          title: selectedPlaceItem.name,
          address: selectedPlaceItem.address,
          latitude: selectedPlaceItem.latitude,
          longitude: selectedPlaceItem.longitude,
          visited: false,
          photos: selectedPlaceItem.photos
      );
      await model.addMarker();
      Navigator.of(context).pop();
    }
  }

  void openPlaceAdditionDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return PlaceAdditionFormDialog(
              updateSelectedItem: updateSelectedItem);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: SheetShape.defaultRoundedRadius),
        ),
        child: Consumer<MapViewModel>(
            builder: (context, model, child) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(Icons.drag_handle_rounded, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: FlatButton(
                        color: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        onPressed: openPlaceAdditionDialog,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_outlined),
                            Text("名前で検索"),
                          ],
                        ),
                      )
                    ),
                    Divider(),
                    Expanded(
                      child: PlaceAdditionPreviewArea(
                          placeItem: this.selectedPlaceItem
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              child: GradatedTextButton(
                                text: '保存',
                                onPressed: () => savePlace(context, model),
                              )
                            ),
                          ]
                      ),
                    )
                  ]
              );
            }
        )
    );
  }
}