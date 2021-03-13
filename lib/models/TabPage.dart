
import 'package:flutter/material.dart';

class TabPage {
  TabPage({
    this.title,
    this.content,
    this.baseIcon,
    this.activeIcon,
  });

  String title;
  Widget content;
  Icon baseIcon;
  Icon activeIcon;
}