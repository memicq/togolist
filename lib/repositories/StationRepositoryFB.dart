import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:togolist/models/Station.dart';

class StationRepositoryFB {
  // for singleton
  static StationRepositoryFB _instance = StationRepositoryFB._internal();
  factory StationRepositoryFB() => _instance;
  StationRepositoryFB._internal(){
    this._initUserDatabase();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId;

  CollectionReference _stationsCollection;

  Future<void> _initUserDatabase() async {
    final FirebaseUser user = await auth.currentUser();
    if (user != null) {
      print("StationRepositoryFB update database uid: ${user.uid}");
      this.userId = user.uid;
      _stationsCollection = Firestore.instance.collection('users').document('${this.userId}').collection('stations');
    }
  }

  Future<List<Station>> listStations() async {
    final stations = await _stationsCollection.getDocuments();

    return Future.wait(
        stations.documents.map((doc) => doc2Station(doc))
    );
  }

  Future<List<Station>> listStationsByIds(List<String> stationIds) async {
    return Future.wait(
      stationIds.map((stationId) async {
        final snapshot = await _stationsCollection.document(stationId).get();
        return await doc2Station(snapshot);
      })
    );
  }

  Future<List<String>> saveStations(List<Station> stations) async {
    var batch = Firestore.instance.batch();

    List<String> stationIds = await Future.wait(
        stations.map((station) async {
          final ref = _stationsCollection.document();
          batch.setData(ref, station.toJson());
          return ref.documentID;
        })
    );

    await batch.commit();
    return stationIds;
  }
  
  Future<void> incrementCount(List<String> stationIds) async {
    var batch = Firestore.instance.batch();
    await Future.wait(
      stationIds.map((stationId) async {
        final ref = await _stationsCollection.document(stationId);
        final snapshot = await ref.get();
        if (snapshot['markerCounts'] != null) {
          batch.updateData(ref, {'markerCounts': snapshot['markerCounts'] + 1});
        }
      })
    );
    await batch.commit();
  }

  Future<void> decrementCount(List<String> stationIds) async {
    var batch = Firestore.instance.batch();

    await Future.wait(
        stationIds.map((stationId) async {
          final ref = _stationsCollection.document(stationId);
          final snapshot = await ref.get();
          if (snapshot['markerCounts'] != null) {
            batch.updateData(ref, {'markerCounts': snapshot['markerCounts'] - 1});
          }
        })
    );
    await batch.commit();
  }

  Future<void> batchDelete(List<String> stationIds) async {
    var batch = Firestore.instance.batch();

    stationIds.forEach((stationId) {
      final ref = _stationsCollection.document(stationId);
      batch.delete(ref);
    });
    await batch.commit();
  }

  Future<Station> doc2Station(DocumentSnapshot doc) async {
    return Station(
        stationId: doc.documentID,
        name: doc['name'],
        prefecture: doc['prefecture'],
        line: doc['line'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        markerCounts: doc['markerCounts']
    );
  }
}