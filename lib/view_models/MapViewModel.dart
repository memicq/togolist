import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:togolist/models/MapMarker.dart';

class MapViewModel extends ChangeNotifier {
  String userId;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<MapMarker> markers = List();
  MapMarker marker;

  MapViewModel() {
    Future(() async {
      await updateUserDatabase();
    });
  }

  void updateUserDatabase() async {
    final FirebaseUser user = await auth.currentUser();
    if (user != null) {
      // TODO: 他の関数が呼ばれない保証はこのモデル内にはない
      print("update database uid: ${user.uid}");
      this.userId = user.uid;
      await fetchMarkers();
    }
  }

  Future<void> fetchMarkers() async {
    final res = await Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .getDocuments();

    final markers = res.documents.map((doc) => MapMarker(
        markerId: doc.documentID,
        title: doc['title'],
        address: doc['address'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        isShared: doc['isShared']));
    this.markers = markers.toList();
    notifyListeners();
  }

  Future<void> addMarker() async {
    await Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .add(marker.toJson());
    await fetchMarkers();
    notifyListeners();
  }

  Future<void> deleteMarker(MapMarker marker) async {
    await Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .document(marker.markerId)
        .delete();
    await fetchMarkers();
    notifyListeners();
  }
}
