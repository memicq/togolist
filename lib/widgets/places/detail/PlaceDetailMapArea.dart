import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/Station.dart';
import 'package:togolist/utils/GeographUtil.dart';
import 'package:togolist/view_models/StationViewModel.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailMapArea extends StatefulWidget {
  MapMarker marker;
  PlaceDetailMapArea({this.marker});

  @override
  State<StatefulWidget> createState() => PlaceDetailMapAreaState();
}

class PlaceDetailMapAreaState extends State<PlaceDetailMapArea> {

  List<Widget> buildStations(StationViewModel model) {
    List<Station> stations = model.getFilteredStations(widget.marker.stationIds);
    if (stations.isEmpty) {
      return [Container()];
    } else {
      return stations.map((s){
        double dist = GeographUtil.calculateDistanceKm(
            GeoPoint(latitude: s.latitude, longitude: s.longitude),
            GeoPoint(latitude: widget.marker.latitude, longitude: widget.marker.longitude)
        );
        return SelectableText(
            "・ ${s.nameWithSuffix()} / ${s.line} （${dist} km）",
            style: TextStyle(fontSize: 13, color: Colors.black54)
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaceDetailItemCard(
                  title: "近くのマップ",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 200,
                          child: google.GoogleMap(
                            rotateGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            markers: [
                              google.Marker(
                                markerId: google.MarkerId(widget.marker.googlePlaceId),
                                position: google.LatLng(widget.marker.latitude, widget.marker.longitude),
                              )
                            ].toSet(),
                            initialCameraPosition: google.CameraPosition(
                                target: google.LatLng(widget.marker.latitude, widget.marker.longitude),
                                zoom: 14
                            ),
                          )
                      ),
                      Text("地図をタップでマップ画面へ飛びます", style: TextStyle(fontSize: 10, color: Colors.black54))
                    ],
                  )
              ),
              Consumer<StationViewModel>(builder: (context, model, _) {
                return PlaceDetailItemCard(
                    title: "近くの駅",
                    content: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildStations(model)
                      ),
                    )
                );
              }),
              SizedBox(
                height: 100,
              )
            ]
        )
    );
  }
}