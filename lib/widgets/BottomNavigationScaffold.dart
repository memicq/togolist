import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/widgets/common/CommonTab.dart';
import 'package:togolist/widgets/geomap/MapView.dart';
import 'package:togolist/widgets/places/PlaceView.dart';

class BottomNavigationScaffold extends StatefulWidget {
  BottomNavigationScaffold();

  @override
  State<StatefulWidget> createState() => BottomNavigationScaffoldState();
}

class BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  Widget buildTabViews(BuildContext context, int index) {
    switch (index) {
      case 0:
        Widget body = MapView();
        return CommonTab(title: 'マップ', body: body);
      case 1:
        Widget body = PlaceView();
        return CommonTab(title: '場所一覧', body: body);
      case 2:
        Widget body = Center(child: Text('アカウント設定'));
        return CommonTab(title: 'アカウント設定', body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.pin_drop_outlined),
                title: Text('マップ')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                title: Text('場所一覧')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text('アカウント')
            )
          ],
        ),
        tabBuilder: (context, index) => buildTabViews(context, index)
    );
  }
}