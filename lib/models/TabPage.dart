
import 'package:flutter/material.dart';

class TabPage {
  String title;
  Widget content;
  Icon baseIcon;
  Icon activeIcon;

  TabPage({
    this.title,
    this.content,
    this.baseIcon,
    this.activeIcon,
  });
}