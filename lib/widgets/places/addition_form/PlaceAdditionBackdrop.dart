import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/const/FontSettings.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceItem.dart';
import 'package:togolist/repositories/GooglePlacesRepositoryApi.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionFormDialog.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionPreviewArea.dart';

class PlaceAdditionBackdrop extends StatefulWidget {
  @override
  State<PlaceAdditionBackdrop> createState() => PlaceAdditionBackdropState();
}

class PlaceAdditionBackdropState extends State<PlaceAdditionBackdrop> {
  GooglePlacesRepositoryApi _placesRepositoryApi = GooglePlacesRepositoryApi();

  PlaceItem selectedPlaceItem = null;

  void updateSelectedItem(PlaceItem item) async {
    PlaceItemDetail detail = await _placesRepositoryApi.fetchPlaceDetailByPlaceId(item.googlePlaceId);
    item.setPlaceItemDetail(detail);
    setState(() {
      this.selectedPlaceItem = item;
    });
  }

  void savePlace(BuildContext context, PlaceViewModel model) async {
    if (selectedPlaceItem != null) {
      MapMarker marker = MapMarker(
        googlePlaceId: selectedPlaceItem.googlePlaceId,
        name: selectedPlaceItem.name,
        latitude: selectedPlaceItem.latitude,
        longitude: selectedPlaceItem.longitude,
        address: selectedPlaceItem.address,
        adrAddress: selectedPlaceItem.placeItemDetail.adrAddress,
        website: selectedPlaceItem.placeItemDetail.website,
        phoneNumber: selectedPlaceItem.placeItemDetail.phoneNumber,
        openingHoursJson: selectedPlaceItem.placeItemDetail.openingHoursJson,
        types: selectedPlaceItem.placeItemDetail.types,
        photos: selectedPlaceItem.placeItemDetail.photos,
        permanentlyClosed: selectedPlaceItem.permanentlyClosed,
        visited: false,
      );
      await model.addMarker(marker);
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
        child: Consumer<PlaceViewModel>(
            builder: (context, model, child) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//                    Center(
//                      child: Icon(Icons.drag_handle_rounded, color: Colors.grey),
//                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: FlatButton(
                        color: ColorSettings.primaryColor['lighten'],
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
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 10),
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
