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
      print("update database uid: ${user.uid}");
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
              title: doc['title'],
              address: doc['address'],
              latitude: doc['latitude'],
              longitude: doc['longitude'],
              visited: doc['visited'],
              photos: photos
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
}
