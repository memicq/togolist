import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/places/PlaceAdditionBackdrop.dart';
import 'package:togolist/widgets/places/PlaceItemCard.dart';

class PlaceView extends StatelessWidget {

  BackdropService backdropService = BackdropService();

  PlaceView();

  List<Widget> buildCardList(List<MapMarker> markers) {
    return markers.map((marker) => PlaceItemCard(marker: marker)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Places",
            style: AppBarTitleStyle.textStyle
        ),
      ),
      body: Consumer<MapViewModel>(builder: (context, model, child) {
        return Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                    child: ListView(children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      ...buildCardList(model.markers),
                    ]))),
            Positioned(
              right: 20,
              bottom: 20,
              child: GradatedIconButton(
                icon: Icon(Icons.add),
                onPressed: () => {
                  backdropService.openBackdrop(
                      page: PlaceAdditionBackdrop(),
                      height: 200.0
                  )
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
