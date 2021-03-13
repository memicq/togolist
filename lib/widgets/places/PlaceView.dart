import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/places/PlaceItemCard.dart';

class PlaceView extends StatelessWidget {

  PlaceView();

  List<Widget> buildCardList(List<MapMarker> markers){
    return markers.map((marker) =>
        PlaceItemCard(marker: marker)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Consumer<MapViewModel>(
            builder: (context, model, child){
              return Center(
                  child: ListView(
                    children: buildCardList(model.markers),
                  )
              );
            })
    );
  }
}