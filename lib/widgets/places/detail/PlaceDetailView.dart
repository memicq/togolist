import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailImageArea.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailTitleArea.dart';

import 'PlaceDetailTabLayout.dart';

class PlaceDetailView extends StatefulWidget {
  MapMarker marker;

  PlaceDetailView({this.marker});

  @override
  State<PlaceDetailView> createState() => PlaceDetailViewState();
}

class PlaceDetailViewState extends State<PlaceDetailView> {
  bool _isVisited;
  PlaceViewModel _placeViewModel;

  @override
  void initState() {
    super.initState();
    this._isVisited = widget.marker.visited;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _placeViewModel = Provider.of<PlaceViewModel>(context, listen: false);
  }

  void onChangeVisitedSwitch(bool isVisited) {
    _placeViewModel.toggleVisited(widget.marker);
    setState(() {
      this._isVisited = isVisited;
    });
  }

  Widget buildCheckButtonAndText() {
    if (this._isVisited) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_box, color: ColorSettings.primaryColor),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("行った", style: TextStyle(color: ColorSettings.primaryColor)),
          )
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_box_outline_blank, color: ColorSettings.primaryColor),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("行った", style: TextStyle(color: ColorSettings.primaryColor)),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("詳細", style: AppBarTitleStyle.textStyle),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Switch(
            value: this._isVisited,
            onChanged: (value) { onChangeVisitedSwitch(value); },
            activeColor: ColorSettings.primaryColor,
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
     onNotification: (notification) => true,
          child:
          Scrollbar(
            isAlwaysShown: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    PlaceDetailTitleArea(marker: widget.marker),
                    if (widget.marker.photos.length != 0)
                      PlaceDetailImageArea(googlePhotos: widget.marker.photos),
                    PlaceDetailTabLayout(marker: widget.marker)
                  ])),
            ),
          ),
      )
    );
  }
}
