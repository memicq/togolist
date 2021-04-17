import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailMemoArea.dart';

import 'PlaceDetailBasicInfoArea.dart';
import 'PlaceDetailMapArea.dart';
import 'PlaceDetailTabBarItem.dart';

class PlaceDetailTabLayout extends StatefulWidget {
  MapMarker marker;
  PlaceDetailTabLayout({this.marker});

  @override
  State<StatefulWidget> createState() => PlaceDetailTabLayoutState();
}

class PlaceDetailTabLayoutState extends State<PlaceDetailTabLayout> {

  int activeIndex = 0;

  void onPressedItem(int index) {
    setState(() {
      this.activeIndex = index;
    });
  }

  Widget buildContent() {
    if (activeIndex == 0) {
      return Center(
        child: PlaceDetailBasicInfoArea(marker: widget.marker),
      );
    } else if (activeIndex == 1) {
      return Center(
        child: PlaceDetailMapArea(marker: widget.marker),
      );
    } else if (activeIndex == 2) {
      return Center(
        child: PlaceDetailMemoArea(marker: widget.marker),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: PlaceDetailTabBarItem(
                      iconData: Icons.info_outlined,
                      label: "基本情報",
                      isActive: (this.activeIndex == 0),
                      onTap: () => onPressedItem(0)
                  )
              ),
              Expanded(
                  child: PlaceDetailTabBarItem(
                      iconData: Icons.map_outlined,
                      label: "マップ情報",
                      isActive: (this.activeIndex == 1),
                      onTap: () => onPressedItem(1)
                  )
              ),
              Expanded(
                  child: PlaceDetailTabBarItem(
                      iconData: Icons.edit_outlined,
                      label: "メモ",
                      isActive: (this.activeIndex == 2),
                      onTap: () => onPressedItem(2)
                  )
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade50,
          padding: EdgeInsets.all(10),
          child: buildContent(),
        )
      ],
    );
  }
}

