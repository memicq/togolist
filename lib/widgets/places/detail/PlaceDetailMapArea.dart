import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailMapArea extends StatelessWidget {
  MapMarker marker;
  PlaceDetailMapArea({this.marker});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaceDetailItemCard(
                  title: "近傍マップ",
                  content: Container(
                    width: double.infinity,
                    height: 200,
                    child: GoogleMap(
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      markers: [
                        Marker(
                          markerId: MarkerId(marker.googlePlaceId),
                          position: LatLng(marker.latitude, marker.longitude),
                        )
                      ].toSet(),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(marker.latitude, marker.longitude),
                        zoom: 15
                      ),
                    )
                  )
              ),
              PlaceDetailItemCard(
                  title: "最寄り駅",
                  content: ColoredBox(color: Colors.red)
              )
            ]
        )
    );
  }
}