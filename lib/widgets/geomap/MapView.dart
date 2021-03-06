import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_webservice/places.dart' as Places;
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/view_models/MapViewModel.dart';

class MapView extends StatefulWidget {
  MapView();

  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Location _locationService = new Location();
  LocationData _currentLocation;
  String _error = '';

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();

    initLocation();
    _locationService.onLocationChanged().listen((LocationData result) async {
      setState(() {
        _currentLocation = result;
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: 17)));
    });
  }

  Future<void> initLocation() async {
    LocationData myLocation;

    try {
      myLocation = await _locationService.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENITED')
        _error = 'Permission denited';
      else if (e.code == 'PERMISSION_DENITED_NEVER_ASK')
        _error =
            'Permission denited - please ask the user to enable it from the app settings';
      myLocation = null;
    }
  }

  Future<void> fetchPlaces(String query) async {
    final places =
        new Places.GoogleMapsPlaces(apiKey: Credentials.googleApiKey);
    Places.PlacesSearchResponse response =
        await places.searchByText(query, language: 'ja');
    print(response.results.map((result) => result.name));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer<MapViewModel>(
      builder: (context, model, child) {
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            Scaffold(
              body: Container(
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                        zoom: 4.5, target: LatLng(35.41, 139.41)
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    markers: model.markers
                        .map((marker) => Marker(
                              markerId: MarkerId(marker.address),
                              position:
                                  LatLng(marker.latitude, marker.longitude),
                              infoWindow: InfoWindow(
                                  title: marker.title, snippet: marker.address),
                              flat: true,
                              icon: BitmapDescriptor.defaultMarker,
                              anchor: Offset(0.5, 0.8),
//                          rotation: _currentLocation.heading
                            ))
                        .toSet()),
              ),
            ),
            Positioned(
              left: 10,
              right: 10.0,
              bottom: 10.0,
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Container(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CupertinoTextField(
                        decoration: BoxDecoration(
                            border: null
                        ),
                    ),
                  )
                )
              )
            ),
          ],
        );
      },
    ));
  }
}
