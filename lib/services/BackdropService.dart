import 'package:flutter/material.dart';

class BackdropService {
  static final BackdropService _backdropService = BackdropService._internal();
  factory BackdropService() => _backdropService;
  BackdropService._internal();

  Function openBackdrop = ({Widget page, double height}) { print("openBackDrop is null"); };
  void setOpenBackdropFunction(Function openBackdrop){
    if (this.openBackdrop == null) {
      this.openBackdrop = openBackdrop;
    }
  }
}