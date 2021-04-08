
import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';

class PlaceDetailTabBarItem extends StatefulWidget {
  IconData iconData;
  String label;
  bool isActive;
  Function onTap;

  PlaceDetailTabBarItem({
    this.iconData,
    this.label,
    this.onTap,
    this.isActive = false
  });

  @override
  State<StatefulWidget> createState() => PlaceDetailTabBarItemState();
}

class PlaceDetailTabBarItemState extends State<PlaceDetailTabBarItem> {

  Border switchBorderBottom() {
    if (widget.isActive) {
      return Border(
          bottom: BorderSide(
              color: ColorSettings.primaryColor,
              width: 2
          )
      );
    } else {
      return Border(
          bottom: BorderSide(
              color: Colors.black26,
              width: 0.3
          )
      );
    }
  }

  Color switchColor() {
    if (widget.isActive) {
      return ColorSettings.primaryColor;
    } else {
      return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: switchBorderBottom(),
        ),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.iconData, color: switchColor(), size: 20),
            Text(widget.label, style: TextStyle(fontSize: 11, color: switchColor()))
          ],
        ),
      ),
    );
  }
}