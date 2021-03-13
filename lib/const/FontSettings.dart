
import 'package:flutter/material.dart';

class FontShader {
  static final linearGradientShader = LinearGradient(
    colors: [
      Color(0xffffab88),
      Color(0xffff7f50),
    ]
  ).createShader(
    Rect.fromLTWH(0, 0, 50, 30)
  );
}