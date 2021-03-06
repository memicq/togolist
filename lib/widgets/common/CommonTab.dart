import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTab extends StatelessWidget {
  String title;
  Widget body;
  CommonTab({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(this.title),// ページのヘッダ左のアイコン
            ),
            child: this.body
        );
      },
    );
  }
}