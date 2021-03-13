import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/FontSettings.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceItem.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/places/PlaceAdditionFormDialog.dart';

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

  Widget buildSelectedItem() {
    if (selectedPlaceItem == null)
      return Text("未選択");
    else {
      return Text(selectedPlaceItem.name + " が選択されました");
    }
  }

  void savePlace(BuildContext context, MapViewModel model) async {
    model.marker = MapMarker(
      title: selectedPlaceItem.name,
      address: selectedPlaceItem.address,
      latitude: selectedPlaceItem.latitude,
      longitude: selectedPlaceItem.longitude
    );
    await model.addMarker();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: SheetShape.defaultRoundedRadius),
      ),
      child: Consumer<MapViewModel>(
          builder: (context, model, child){
            return Column(
                children: [
                  Icon(Icons.drag_handle_rounded, color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: FlatButton(
                        minWidth: double.infinity,
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        onPressed: () => {
                          showDialog(
                              context: this.context,
                              builder: (context) {
                                return PlaceAdditionFormDialog(
                                    updateSelectedItem: updateSelectedItem);
                              })
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "場所を検索",
                            textAlign: TextAlign.left,
                          ),
                        )),
                  ),
                  Container(
                    child: buildSelectedItem(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextButton(
                              onPressed: () => savePlace(context, model),
                              child: Center(
                                child: Text(
                                  '保存',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()..shader = FontShader.linearGradientShader
                                  ),
                                ),
                              ),
                            ),
                          )
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
