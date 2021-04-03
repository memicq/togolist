import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/models/PlaceListSortingKey.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class MapViewModel extends ChangeNotifier {
  String userId;
  FirebaseAuth auth = FirebaseAuth.instance;

  MapMarker marker;
  List<MapMarker> markers = List();

  MapMarkerFilterCondition condition = MapMarkerFilterCondition();

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

    final markers = await Future.wait(
        res.documents.map((doc) async {
          final photosRes = await doc.reference.collection('photos').getDocuments();
          final photos = photosRes.documents.map((doc) => MapMarkerPhoto(
            photoReference: doc['photoReference'],
            height: doc['height'],
            width: doc['width']
          )).toList();
          return MapMarker(
              markerId: doc.documentID,
              title: doc['title'],
              address: doc['address'],
              latitude: doc['latitude'],
              longitude: doc['longitude'],
              visited: doc['visited'],
              photos: photos
          );
        })
    );
    this.markers = markers.toList();
    this._filter(this.condition);
    this._sort(PlaceListSortingKey.PLACE_NAME, PlaceListSortingOrder.ASC);
    notifyListeners();
  }

  Future<void> addMarker() async {
    var res = await Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .add(marker.toJson());
    await marker.photos.forEach((photo) async {
      await _getMarkerDocument(res.documentID)
          .collection('photos')
          .add(photo.toJson());
    });
    await fetchMarkers();
    notifyListeners();
  }

  Future<void> deleteMarker(MapMarker marker) async {
    await _getMarkerDocument(marker.markerId)
        .collection('photos')
        .getDocuments()
        .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.documents) ds.reference.delete();
        });
    await _getMarkerDocument(marker.markerId).delete();
    await fetchMarkers();
    notifyListeners();
  }

  void sortMarkers({
    PlaceListSortingKey sortingKey = PlaceListSortingKey.PLACE_NAME,
    PlaceListSortingOrder sortingOrder = PlaceListSortingOrder.ASC
  }) {
    this._sort(sortingKey, sortingOrder);
    notifyListeners();
  }


  void updateCondition(MapMarkerFilterCondition condition) {
    this.condition = condition;
  }

  void _sort(PlaceListSortingKey sortingKey, PlaceListSortingOrder sortingOrder) {
    if (sortingKey == PlaceListSortingKey.PLACE_NAME) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.markers.sort((a, b) => a.title.compareTo(b.title));
      } else {
        this.markers.sort((b, a) => a.title.compareTo(b.title));
      }
    } else if (sortingKey == PlaceListSortingKey.DISTANCE) {
      if (sortingOrder == PlaceListSortingOrder.ASC) {
        this.markers.sort((a, b) => a.distanceFromMe.compareTo(b.distanceFromMe));
      } else {
        this.markers.sort((b, a) => a.distanceFromMe.compareTo(b.distanceFromMe));
      }
    }
  }

  void _filter(MapMarkerFilterCondition condition) {
    var filteredMarkers = this.markers;

    if (condition.visitedCondition == MapMarkerFilterVisited.VISITED) {
      filteredMarkers = this.markers.where((m) => m.visited == true).toList();
    } else if (condition.visitedCondition == MapMarkerFilterVisited.NOT_VISITED) {
      filteredMarkers = this.markers.where((m) => m.visited == false).toList();
    }

    this.markers = filteredMarkers;
  }

  DocumentReference _getMarkerDocument(String markerId) {
    return Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .document(markerId);
  }
}
