import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/places/PlaceAdditionBackdrop.dart';
import 'package:togolist/widgets/places/PlaceAppBarBottom.dart';

import 'SlidablePlaceItemCard.dart';

class PlaceView extends StatelessWidget {
  BackdropService backdropService = BackdropService();

  PlaceView();

  GlobalKey<SlidablePlaceItemCardState> openingSlidableCardState = null;

  List<Widget> buildCardList(List<MapMarker> markers) {
    return markers.map((marker) {
      GlobalKey<SlidablePlaceItemCardState> key = GlobalKey();
      return SlidablePlaceItemCard(key: key, marker: marker);
    }).toList();
  }

  // 子供をチェックして開いているやつを閉める
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
            child: PlaceAppBarBottom()
          ),
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
                      height: 400.0
                  )
                },
              ),
            )
          ],
        );
      }),
      resizeToAvoidBottomInset: false,
    );
  }
}
