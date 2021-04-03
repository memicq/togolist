

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlaceViewModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  String userId;

  PlaceViewModel() {
    Future(() async {
      await _updateUserDatabase();
    });
  }

  void _updateUserDatabase() async {
    final FirebaseUser user = await auth.currentUser();
    if (user != null) {
      print("update database uid: ${user.uid}");
      this.userId = user.uid;
//      await fetchMarkers();
    }
  }
}