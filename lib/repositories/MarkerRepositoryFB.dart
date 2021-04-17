import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class MarkerRepositoryFB {
  // for singleton
  static MarkerRepositoryFB _instance = MarkerRepositoryFB._internal();
  factory MarkerRepositoryFB() => _instance;
  MarkerRepositoryFB._internal(){
    this._initUserDatabase();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId;

  Future<void> _initUserDatabase() async {
    final FirebaseUser user = await auth.currentUser();
    if (user != null) {
      print("MarkerRepositoryFB update database uid: ${user.uid}");
      this.userId = user.uid;
    }
  }

  Future<void> updateUser() async {
    await _initUserDatabase();
  }

  Future<List<MapMarker>> listMarker() async {
    final markersSnapshot = await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .getDocuments();
    final markers = Future.wait(
        markersSnapshot.documents.map((doc) async {
          final photos = await listMarkerPhotos(doc.documentID);
          return MapMarker(
              markerId: doc.documentID,
              googlePlaceId: doc['googlePlaceId'],
              name: doc['name'],
              latitude: doc['latitude'],
              longitude: doc['longitude'],
              address: doc['address'],
              adrAddress: doc['adrAddress'],
              website: doc['website'],
              phoneNumber: doc['phoneNumber'],
              openingHoursJson: doc['openingHoursJson'],
              types: (doc['typeString'] != null) ? (doc['typeString'] as String).split(',') : List(),
              photos: photos,
              permanentlyClosed: doc['permanentlyClosed'],
              stationIds: (doc['stationIdsString'] != null) ? (doc['stationIdsString'] as String).split(',') : List(),
              visited: doc['visited'],
              memo: doc['memo']
          );
        }).toList()
    );
    return markers;
  }

  Future<List<MapMarkerPhoto>> listMarkerPhotos(String markerId) async {
    final photosSnapshot = await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .document('${markerId}')
        .collection('photos')
        .getDocuments();
    final photos = photosSnapshot.documents.map((doc) => MapMarkerPhoto(
        photoReference: doc['photoReference'],
        height: doc['height'],
        width: doc['width']
    )).toList();
    return photos;
  }

  Future<void> createMarker(MapMarker marker) async {
    final markerReference = await Firestore.instance
        .collection('users')
        .document('${userId}')
        .collection('markers')
        .add(marker.toJson());
    await marker.photos.forEach((photo) async {
      await markerReference
          .collection('photos')
          .add(photo.toJson());
    });
  }

  Future<void> deleteMarker(MapMarker marker) async {
    await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .document('${marker.markerId}')
        .collection('photos')
        .getDocuments()
        .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.documents) ds.reference.delete();
        });
    await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .document('${marker.markerId}')
        .delete();
  }

  Future<void> updateVisited(MapMarker marker, bool visited) async {
    await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .document('${marker.markerId}')
        .updateData({
          "visited": visited
        });
  }

  Future<void> updateMemo(MapMarker marker, String memo) async {
    await Firestore.instance
        .collection('users')
        .document('${this.userId}')
        .collection('markers')
        .document('${marker.markerId}')
        .updateData({"memo": memo});
  }
}
