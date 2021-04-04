import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/view_models/UserViewModel.dart';
import 'package:togolist/widgets/account/AccountView.dart';
import 'package:togolist/widgets/account/LoginSwitcher.dart';
import 'package:togolist/widgets/account/LoginView.dart';
import 'package:togolist/widgets/friends/FriendView.dart';
import 'package:togolist/widgets/layouts/MultipleChangeNotifierProviderWrapper.dart';
import 'package:togolist/widgets/geomap/MapView.dart';
import 'package:togolist/widgets/layouts/TabAndBackdropLayout.dart';
import 'package:togolist/widgets/places/PlaceView.dart';

import 'models/TabPage.dart';

void main() {
  runApp(ToGoApp());
}

final backdropService = BackdropService();

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
          scaffold: MapView(),
        ),
        baseIcon: Icon(Icons.map_outlined, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.map_sharp, color: ColorSettings.primaryColor, size: 30)),
    2: TabPage(
        title: "places",
        content: TabAndBackdropLayoutContent(
          title: "places",
          scaffold: PlaceView(),
        ),
        baseIcon:
            Icon(Icons.format_list_bulleted, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.view_list, color: ColorSettings.primaryColor, size: 30)),
//    3: TabPage(
//      title: "friends",
//      content: TabAndBackdropLayoutContent(
//        title: "friends",
//        scaffold: FriendView()
//      ),
//      baseIcon: Icon(Icons.people_alt_outlined, color: Colors.grey, size: 25),
//      activeIcon: Icon(Icons.people_alt_rounded, color: ColorSettings.primaryColor, size: 30)),
    4: TabPage(
        title: "accounts",
        content: TabAndBackdropLayoutContent(
          title: "accounts",
          scaffold: AccountView(),
        ),
        baseIcon: Icon(Icons.settings, color: Colors.grey, size: 25),
        activeIcon:
            Icon(Icons.settings, color: ColorSettings.primaryColor, size: 30))
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
