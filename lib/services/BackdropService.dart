import 'package:flutter/material.dart';

class BackdropService {
  static final BackdropService _backdropService = BackdropService._internal();
  factory BackdropService() => _backdropService;
  BackdropService._internal();

  bool isAlreadySet = false;
  Function openBackdrop = ({Widget page, double height}) { print("openBackDrop is null"); };
  void setOpenBackdropFunction(Function openBackdrop){
    if (!this.isAlreadySet) {
      this.openBackdrop = openBackdrop;
      this.isAlreadySet == true;
    }
  }
}