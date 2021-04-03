import 'package:flutter/material.dart';

/**
 * Singleton な 親コンテントの Backdrop を開く機能を担うクラス
 */
class BackdropService {
  static final BackdropService _backdropService = BackdropService._internal();

  factory BackdropService() {
    return _backdropService;
  }

  BackdropService._internal();

  Function openBackdrop = ({Widget page, double height}) { print("openBackDrop is null"); };
  void setOpenBackdropFunction(Function openBackdrop){
    this.openBackdrop = openBackdrop;
  }
}