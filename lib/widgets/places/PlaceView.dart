import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/view_models/LocationViewModel.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionBackdrop.dart';
import 'package:togolist/widgets/places/PlaceAppBarBottom.dart';

import 'PlaceListSortingArea.dart';
import 'SlidablePlaceItemCard.dart';

class PlaceView extends StatefulWidget {
  PlaceView();

  @override
  State<StatefulWidget> createState() => PlaceViewState();
}

class PlaceViewState extends State<PlaceView> {
  GlobalKey<SlidablePlaceItemCardState> openingSlidableCardState = null;

  BackdropService backdropService = BackdropService();

  List<Widget> buildCardList(List<MapMarker> markers) {
    return markers.map((marker) {
      GlobalKey<SlidablePlaceItemCardState> key = GlobalKey();
      return Consumer<LocationViewModel>(builder: (context, model, child) {
        return SlidablePlaceItemCard(
            key: key, marker: marker, location: model.currentLocation);
      });
    }).toList();
  }

  void notifySlididableCardOpened(GlobalKey<SlidablePlaceItemCardState> key) {
    if (openingSlidableCardState != null && openingSlidableCardState != key) {
      openingSlidableCardState.currentState?.closeSlidable();
    }
    openingSlidableCardState = key;
  }

  void notifySlididableCardClosed(GlobalKey<SlidablePlaceItemCardState> key) {
    if (openingSlidableCardState == key) {
      openingSlidableCardState = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          title: Text("Places", style: AppBarTitleStyle.textStyle),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: PlaceAppBarBottom()),
        ),
      ),
      body: Consumer<MapViewModel>(builder: (context, model, child) {
        return Consumer<LocationViewModel>(builder: (lcontext, lmodel, lchild) {
          return Stack(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                      child: ListView(children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        PlaceListSortingArea(
                      mapViewModel: model,
                      locationDisabled: (lmodel.currentLocation == null),
                    ),
                    ...buildCardList(model.markers),
                  ]))),
              Positioned(
                right: 20,
                bottom: 20,
                child: GradatedIconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {
                    backdropService.openBackdrop(
                        page: PlaceAdditionBackdrop(), height: 435.0)
                  },
                ),
              )
            ],
          );
        });
      }),
      resizeToAvoidBottomInset: false,
    );
  }
}
