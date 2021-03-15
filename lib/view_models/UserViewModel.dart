
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  FirebaseUser user;
  void setUser(FirebaseUser currentUser){
    user = currentUser;
    notifyListeners();
  }
}