import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/geomap/MapMarkerFilterBackdrop.dart';

class MapAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => MapAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class MapAppBarState extends State<MapAppBar> {
  BackdropService _backdropService = BackdropService();

  Widget buildIcon(MapMarkerFilterCondition condition) {
    if (condition.isDefault()) {
      return Icon(
        Icons.filter_alt_outlined,
        color: ColorSettings.primaryColor['lighten'],
      );
    } else {
      return Icon(
        Icons.filter_alt,
        color: ColorSettings.primaryColor['lighten'],
      );
    }
  }

  void openMapMarkerFilterBackdrop() {
    _backdropService.openBackdrop(
        page: MapMarkerFilterBackdrop(), height: 180.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(builder: (context, model, child) {
      return AppBar(
        title: Text("Map", style: AppBarTitleStyle.textStyle),
        actions: [
          FlatButton(
              onPressed: () => openMapMarkerFilterBackdrop(),
              child: buildIcon(model.condition))
        ],
      );
    });
  }
}
