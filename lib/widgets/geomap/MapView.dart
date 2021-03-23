import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
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
  void initState(){
    super.initState();

    initLocation();
    Future(() async {
      _locationService.onLocationChanged().listen((LocationData result) async {
        setState(() {
          _currentLocation = result;
        });
      });

      await Future.delayed(Duration(seconds: 1));
      if (_currentLocation != null) {
        initCameraPosition();
      }
    });
  }

  Future<void> initCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    _currentLocation.latitude,
                    _currentLocation.longitude
                ),
                zoom: 17
            )
        )
    );
  }

  Future<void> pointCamera(MapMarker marker) async {
    final GoogleMapController controller = await _controller.future;
    final currentZoomLevel = await controller.getZoomLevel();
    const double targetZoomLavel = 15.0;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    marker.latitude,
                    marker.longitude
                ),
                zoom: (currentZoomLevel > targetZoomLavel) ? currentZoomLevel : targetZoomLavel
            )
        )
    );
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
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    markers: model.markers
                        .map((marker) =>
                        Marker(
                          markerId: MarkerId(marker.address),
                          position: LatLng(marker.latitude, marker.longitude),
                          infoWindow: InfoWindow(
                              title: marker.title,
                              snippet: marker.address
                          ),
                          flat: true,
                          icon: BitmapDescriptor.defaultMarker,
                          anchor: Offset(0.5, 0.8),
                          onTap: () => pointCamera(marker)
                        )
                    ).toSet()),
              ),
            ),
          ],
        );
      },
    ));
  }
}
