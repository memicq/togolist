import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/services/LocationService.dart';
import 'package:togolist/utils/ListUtil.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/ad/PlaceListCardAd.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/places/addition_form/PlaceAdditionBackdrop.dart';
import 'package:togolist/widgets/places/PlaceAppBarBottom.dart';

import 'PlaceListHeaderArea.dart';
import 'SlidablePlaceItemCard.dart';

class PlaceView extends StatefulWidget {
  PlaceView();

  @override
  State<StatefulWidget> createState() => PlaceViewState();
}

class PlaceViewState extends State<PlaceView> {
  GlobalKey<SlidablePlaceItemCardState> openingSlidableCardState = null;

  BackdropService _backdropService = BackdropService();
  LocationService _locationService = LocationService();

  bool _isFocusingSearchArea = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PlaceViewModel>(context, listen: false).fetchMarkers();
  }

  List<Widget> buildCardList(PlaceViewModel pModel) {
    List<Widget> cards = pModel.viewMarkers.map((marker) {
      GlobalKey<SlidablePlaceItemCardState> key = GlobalKey();
      return SlidablePlaceItemCard(key: key, marker: marker);
    }).toList();

    List<Widget> ads = (cards.isEmpty)
        ? List()
        : List.filled(((cards.length - 1) / 10).floor(), PlaceListCardAd());

    return ListUtil.insertWithStride(cards, ads, 10).toList();
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

  void toggleFocusingSearchArea(bool hasFocus) {
    setState(() {
      this._isFocusingSearchArea = hasFocus;
    });
  }

  Widget buildFloatingElements() {
    if (this._isFocusingSearchArea) {
      return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        left: 0,
        child: GestureDetector(
          onTap: () {
            toggleFocusingSearchArea(false);
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
            constraints: BoxConstraints.expand(),
          ),
        ),
      );
    } else {
      return Positioned(
        right: 20,
        bottom: 20,
        child: GradatedIconButton(
          icon: Icon(Icons.add),
          onPressed: () => {
            _backdropService.openBackdrop(page: PlaceAdditionBackdrop(), height: 435.0)
          },
        ),
      );
    }
  }

  Widget buildNonExistentView(PlaceViewModel model) {
    if (!model.isEmptyMarker()) {
      return Positioned(
        top: 120,
        left: 0,
        right: 0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_location_alt_outlined,
                color: Colors.black38,
                size: 70,
              ),
              SizedBox(height: 10),
              Text("???????????????????????????????????????", style: TextStyle(color: Colors.black38, fontSize: 12)),
              Text("????????????????????????????????????????????????????????????", style: TextStyle(color: Colors.black38, fontSize: 12))
            ],
          ),
        ),
      );
    } else if (!model.isEmptyViewMarker()) {
      return Positioned(
        top: 120,
        left: 0,
        right: 0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.not_listed_location_outlined,
                color: Colors.black38,
                size: 70,
              ),
              SizedBox(height: 10),
              Text("???????????????????????????????????????", style: TextStyle(color: Colors.black38, fontSize: 12)),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          title: Text("????????????", style: AppBarTitleStyle.textStyle),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: PlaceAppBarBottom()),
        ),
      ),
      body: Consumer<PlaceViewModel>(builder: (context, model, child) {
          return Stack(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ListView(
                      children: [
                        SizedBox(height: 10),
                        PlaceListHeaderArea(
                          placeViewModel: model,
                          locationDisabled: (_locationService.currentLocation == null),
                        ),
                        ...buildCardList(model)
                      ]
                  )
              ),
              buildNonExistentView(model),
              buildFloatingElements()
            ],
          );
      }),
      resizeToAvoidBottomInset: false,
    );
  }
}
