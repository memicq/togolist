
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  FirebaseUser user;

  void initUser() {

  }


  void setUser(FirebaseUser currentUser){
    user = currentUser;
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }
}