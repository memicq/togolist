import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:togolist/models/MapMarker.dart';

class MapViewModel extends ChangeNotifier {
  String text = "変更したいテキスト";
  List<MapMarker> markers = List();
  MapMarker marker;

  Future<void> fetchMarkers() async {
    final res = await Firestore.instance.collection('markers').getDocuments();
    final markers = res.documents.map((doc) =>
        MapMarker(
            title: doc['title'],
            address: doc['address'],
            latitude: doc['latitude'],
            longitude: doc['longitude']
        )
    );
    this.markers = markers.toList();
    notifyListeners();
  }

  Future<void> addMarker() async {
    await Firestore.instance.collection('markers').add(marker.toJson());
    await fetchMarkers();
    notifyListeners();
  }
}