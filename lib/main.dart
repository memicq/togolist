import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/widgets/layouts/tab_and_backdrop_layout.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/BottomNavigationScaffold.dart';

import 'models/TabPage.dart';


void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.deepOrange
        ),
        home: TabAndBackdropLayout(
          defaultPage: 2,
          views: {
            1: TabPage(
              title: "page1",
              content: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: Text("page1"),
                  ),
                  body: Center(
                    child: Text("page1"),
                  ),
                )
              ),
              icon: Icon(Icons.looks_one_outlined)
            ),
            2: TabPage(
                title: "page2",
                content: MaterialApp(
                  home: Scaffold(
                    appBar: AppBar(
                      title: Text("page2"),
                    ),
                    body: Center(
                      child: Text("page2"),
                    ),
                  )
                ),
                icon: Icon(Icons.looks_two_outlined)
            ),
            3: TabPage(
              title: "page3",
              content: TabAndBackdropLayoutContent(
                title: "page3",
                body: Center(
                  child: Text("page3"),
                ),
              ),
              icon: Icon(Icons.looks_3_outlined)
            )
          },
        )
      )
  );
}

class ToGoListApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapViewModel>(
      create: (_) => MapViewModel()..fetchMarkers(),
      child: CupertinoApp(
          title: 'ToGoList',
          theme: CupertinoThemeData(
              primaryColor:  ColorSettings.primaryColor,
              barBackgroundColor: ColorSettings.barColor
          ),
          home: BottomNavigationScaffold(),
      )
    );
  }
}
