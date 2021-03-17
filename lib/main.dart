import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/view_models/UserViewModel.dart';
import 'package:togolist/widgets/account/AccountView.dart';
import 'package:togolist/widgets/account/LoginSwitcher.dart';
import 'package:togolist/widgets/account/LoginView.dart';
import 'package:togolist/widgets/layouts/MultipleChangeNotifierProviderWrapper.dart';
import 'package:togolist/widgets/geomap/MapView.dart';
import 'package:togolist/widgets/layouts/TabAndBackdropLayout.dart';
import 'package:togolist/widgets/places/PlaceView.dart';

import 'models/TabPage.dart';

void main() {
  runApp(ToGoApp());
}

bool isReleaseMode() {
  bool _bool;
  bool.fromEnvironment('dart.vm.product') ? _bool = true : _bool = false;
  return _bool;
}

class ToGoApp extends StatelessWidget {
  Map<int, TabPage> tabViews = {
    1: TabPage(
        title: "map",
        content: TabAndBackdropLayoutContent(
          title: "map",
          body: MapView(),
        ),
        baseIcon: Icon(Icons.map_outlined, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.map_sharp, color: ColorSettings.primaryColor, size: 30)),
    2: TabPage(
        title: "places",
        content: TabAndBackdropLayoutContent(
          title: "places",
          body: PlaceView(),
          showFloatingButton: true,
        ),
        baseIcon:
            Icon(Icons.format_list_bulleted, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.view_list, color: ColorSettings.primaryColor, size: 30)),
    3: TabPage(
        title: "accounts",
        content: TabAndBackdropLayoutContent(
          title: "accounts",
          body: AccountView(),
        ),
        baseIcon: Icon(Icons.person_outline, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.person, color: ColorSettings.primaryColor, size: 30))
  };

  @override
  Widget build(BuildContext context) {
    return MultipleChangeNotifierProviderWrapper(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case "/login":
                  return MaterialPageRoute(
                      builder: (context) => LoginView(),
                      fullscreenDialog: true);
              }
            },
            theme: ThemeData(
                backgroundColor: Colors.white,
                primaryColor: ColorSettings.primaryColor,
                fontFamily: 'Quicksand'),
            home: LoginSwitcher(
              child: TabAndBackdropLayout(
                defaultPage: 1,
                views: tabViews,
              ),
            )));
  }
}
