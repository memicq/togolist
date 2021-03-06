
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/places/PlaceAdditionView.dart';

class PlaceView extends StatelessWidget {

  PlaceView();

  void navigateToAddPlaceView(BuildContext context) {
    Navigator.of(
        context,
        rootNavigator: true
    ).push(
        CupertinoPageRoute(
            builder: (context) => PlaceAdditionView(),
            fullscreenDialog: true
        )
    );
  }

  List<Widget> createTextList(List<MapMarker> markers){
    return markers.map((marker) =>
        Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(marker.title),
          )
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Consumer<MapViewModel>(
              builder: (context, model, child){
                return Center(
                    child: ListView(
                      children: createTextList(model.markers),
                    )
                );
              }
          )
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorSettings.primaryColor,
          child: Icon(Icons.add),
          onPressed: () => navigateToAddPlaceView(context),
        ),
      ),
    );
  }
}