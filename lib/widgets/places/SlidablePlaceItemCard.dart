
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/places/PlaceItemCard.dart';

import 'PlaceView.dart';

class SlidablePlaceItemCard extends StatefulWidget {
  MapMarker marker;
  LocationData location;
  SlidablePlaceItemCard({Key key, this.marker, this.location}): super(key: key);

  @override
  State<StatefulWidget> createState() => SlidablePlaceItemCardState();
}


class SlidablePlaceItemCardState extends State<SlidablePlaceItemCard> {

  SlidableController slidableController;

  GlobalKey<PlaceItemCardState> placeItemCardGlobalKey = GlobalKey();
  PlaceViewState placeViewState;

  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(
      // NOTE(kamiura): onSlideAnimationChanged に空の関数を与えないとなぜか onSlideIsOpenChanged も動かなくなるので必要
      onSlideAnimationChanged: (Animation<double> slideAnimation){},
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeViewState = context.findAncestorStateOfType<PlaceViewState>();
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    if (isOpen) {
      placeViewState?.notifySlididableCardOpened(widget.key);
    } else {
      placeViewState?.notifySlididableCardClosed(widget.key);
    }
  }

  void closeSlidable() {
    placeItemCardGlobalKey.currentState?.closeSlidable();
  }

  void deleteMarker(MapViewModel model) async {
    await model.deleteMarker(widget.marker);
    placeViewState?.notifySlididableCardClosed(widget.key);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      child: PlaceItemCard(
          key: placeItemCardGlobalKey,
          marker: widget.marker,
          location: widget.location
      ),
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
            );;
          }),
        )
      ],
    );
  }
}