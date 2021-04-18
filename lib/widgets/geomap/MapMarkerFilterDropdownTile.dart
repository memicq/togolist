import 'package:flutter/material.dart';

class MapMarkerFilterDropdownTile extends StatefulWidget {
  IconData iconData;
  String title;
  String description;
  List<DropdownMenuItem> items;
  int selected;
  Function onChanged = (int value){};

  MapMarkerFilterDropdownTile({
    this.iconData,
    this.title,
    this.description,
    this.items,
    this.selected,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => MapMarkerFilterDropdownTileState();
}

class MapMarkerFilterDropdownTileState extends State<MapMarkerFilterDropdownTile>{
  void onChangeValue(dynamic value) {
    setState(() {
      widget.selected = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 50,
              child: Icon(
                widget.iconData,
                size: 18,
                color: Colors.black54,
              )
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyle(fontSize: 16),),
                  Text(widget.description, style: TextStyle(fontSize: 12, color: Colors.black38),)
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 15),
                child: DropdownButton(
                  isExpanded: true,
                  items: widget.items,
                  value: widget.selected,
                  onChanged: this.onChangeValue,
                ),
              )
          )
        ],
      ),
    );
  }
}