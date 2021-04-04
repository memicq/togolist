import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailImageArea.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailTitleArea.dart';

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

  void onChangeVisitedSwitch(bool visited) {
    _placeViewModel.toggleVisited(widget.marker);
    setState(() {
      this._isVisited = visited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("detail"),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Switch(
              value: this._isVisited,
              onChanged: onChangeVisitedSwitch,
              activeColor: ColorSettings.primaryColor,
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Column(children: [
              PlaceDetailTitleArea(marker: widget.marker),
              if (widget.marker.photos.length != 0) PlaceDetailImageArea(googlePhotos: widget.marker.photos),
            ])
        )
    );
  }
}
