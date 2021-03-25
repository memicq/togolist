import 'package:flutter/material.dart';
import 'package:togolist/const/Style.dart';

class MapAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => MapAppBarState();

  Size get preferredSize => Size.fromHeight(110.0);
}

class MapAppBarState extends State<MapAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(110.0),
      child: AppBar(
        title: Text("Map", style: AppBarTitleStyle.textStyle),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text("マップからフィルタリング"),
            )
        ),
      ),
    );
  }
}