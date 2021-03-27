import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/geomap/MapAppBar.dart';

class MapView extends StatefulWidget {
  MapView();

  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  static const double DEFAULT_MAP_ZOOM_LEVEL = 13.0;
  static const double PLACE_FOCUS_ZOOM_LEVEL = 15.0;
  static const Offset GOOGLE_ANCHOR_OFFSET = Offset(0.5, 0.8);

  // TODO(kamiura): 初期カメラ位置が特に意味のない値になっているので、そのうち修正する
  final CameraPosition INITIAL_CAMERA_POSITION =
      CameraPosition(zoom: 4.5, target: LatLng(35.41, 139.41));

  CameraPosition currentCameraPosition;
  Location _locationService = Location();
  StreamSubscription _onLocationChangeSubscription;
  LocationData _currentLocation;
  bool isCameraInitialized = false;
  double markerRotation = 0.0;

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();

    Future(() async {
      _currentLocation = await _locationService.getLocation();

      _onLocationChangeSubscription = _locationService
          .onLocationChanged()
          .listen((LocationData result) async {
        setState(() {
          _currentLocation = result;
        });

        if (!isCameraInitialized) {
          initCameraPosition();
          isCameraInitialized = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _onLocationChangeSubscription?.cancel();
  }

  Future<void> initCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: DEFAULT_MAP_ZOOM_LEVEL)));
  }

  Future<void> currentPlaceCamera() async {
    final GoogleMapController controller = await _controller.future;
    final currentZoomLevel = await controller.getZoomLevel();

    if (_currentLocation != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: (currentZoomLevel > PLACE_FOCUS_ZOOM_LEVEL)
            ? currentZoomLevel
            : PLACE_FOCUS_ZOOM_LEVEL,
        bearing: currentCameraPosition.bearing,
      )));
    }
  }

  Future<void> pointCamera(MapMarker marker) async {
    final GoogleMapController controller = await _controller.future;
    final currentZoomLevel = await controller.getZoomLevel();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(marker.latitude, marker.longitude),
        zoom: (currentZoomLevel > PLACE_FOCUS_ZOOM_LEVEL)
            ? currentZoomLevel
            : PLACE_FOCUS_ZOOM_LEVEL)));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  void setMarkerRotation(CameraPosition cameraPosition) {
    setState(() {
      this.markerRotation = cameraPosition.bearing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MapAppBar(),
        body: Center(
          child: Consumer<MapViewModel>(builder: (context, model, child) {
            return Stack(alignment: Alignment.topLeft, children: [
              Scaffold(
                body: Container(
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      onCameraMove: (CameraPosition cameraPosition) {
                        currentCameraPosition = cameraPosition;
                        setMarkerRotation(cameraPosition);
                      },
                      initialCameraPosition: INITIAL_CAMERA_POSITION,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
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
                              anchor: GOOGLE_ANCHOR_OFFSET,
                              onTap: () => pointCamera(marker),
                              rotation: markerRotation))
                          .toSet()),
                ),
              ),
              Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: GradatedIconButton(
                      icon: Icon(FontAwesomeIcons.locationArrow, size: 16,),
                      onPressed: () => currentPlaceCamera()))
            ]);
          }),
        ));
  }
}
