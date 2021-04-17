import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/places/PlaceListSortingDialog.dart';
import 'package:togolist/widgets/places/PlaceView.dart';

class PlaceListHeaderArea extends StatefulWidget {
  PlaceViewModel placeViewModel;
  bool locationDisabled = false;

  PlaceListHeaderArea({this.placeViewModel, this.locationDisabled = false});

  @override
  State<StatefulWidget> createState() => PlaceListHeaderAreaState();
}

class PlaceListHeaderAreaState extends State<PlaceListHeaderArea> {
  PlaceViewState placeViewState;

  PlaceListSortingKey _sortingKey;
  PlaceListSortingOrder _sortingOrder;

  @override
  void initState() {
    super.initState();
    placeViewState = context.findAncestorStateOfType<PlaceViewState>();

    _sortingKey = widget.placeViewModel.getCurrentSortingKey();
    _sortingOrder = widget.placeViewModel.getCurrentSortingOrder();
  }

  IconData buildIcon() {
    if (_sortingKey.isNumber) {
      if (_sortingOrder == PlaceListSortingOrder.ASC)
        return FontAwesomeIcons.sortNumericDown;
      else
        return FontAwesomeIcons.sortNumericDownAlt;
    } else {
      if (_sortingOrder == PlaceListSortingOrder.ASC) {
        return FontAwesomeIcons.sortAlphaDown;
      } else {
        return FontAwesomeIcons.sortAlphaDownAlt;
      }
    }
  }

  void openSortingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return PlaceListSortingDialog(
            initialSortingKey: _sortingKey,
            onSortingKeyChanged: onSortingKeyChanged,
            distanceDisabled: widget.locationDisabled,
          );
        });
  }

  void onSortingKeyChanged(PlaceListSortingKey sortingKey) {
    setState(() {
      this._sortingKey = sortingKey;
    });

    print("toggleSortingOrder: ${_sortingKey}, ${_sortingOrder}");
    widget.placeViewModel.sortMarkers(
        sortingKey: this._sortingKey, sortingOrder: this._sortingOrder);
  }

  void toggleSortingOrder() {
    if (_sortingOrder == PlaceListSortingOrder.ASC) {
      setState(() {
        _sortingOrder = PlaceListSortingOrder.DESC;
      });
    } else {
      setState(() {
        _sortingOrder = PlaceListSortingOrder.ASC;
      });
    }

    print("toggleSortingOrder: ${_sortingKey}, ${_sortingOrder}");
    widget.placeViewModel.sortMarkers(
        sortingKey: this._sortingKey, sortingOrder: this._sortingOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Consumer<PlaceViewModel>(builder: (context, model, child) {
          return Text(
            "${model.getDisplayCount()}件 / 全${model.getTotalCount()}件",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          );
        }),
        Row(
          children: [
            SizedBox(
              height: 35,
              child: TextButton(
                child: Text("${this._sortingKey.name}順",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                onPressed: openSortingDialog,
              ),
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: TextButton(
                child: Icon(
                  buildIcon(),
                  color: Colors.deepOrange.shade400,
                  size: 17,
                ),
                onPressed: toggleSortingOrder,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
