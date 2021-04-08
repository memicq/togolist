import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';
import 'package:togolist/widgets/geomap/MapMarkerFilterItemTile.dart';

class MapMarkerFilterBackdrop extends StatefulWidget {
  MapMarkerFilterBackdrop();

  @override
  State<StatefulWidget> createState() => MapMarkerFilterBackdropState();
}

class MapMarkerFilterBackdropState extends State<MapMarkerFilterBackdrop> {
  MapMarkerFilterCondition condition;

  @override
  void initState() {
    super.initState();
    MapViewModel mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    condition = mapViewModel.condition;
  }

  void setVisitedCondition(int visitedIndex) {
    setState(() {
      this.condition.visitedCondition = MapMarkerFilterVisited.values[visitedIndex];
    });
  }

  void applyFilterCondition() async {
    MapViewModel mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    mapViewModel.updateCondition(this.condition);
    await mapViewModel.fetchMarkers();
    Navigator.of(context).pop();
  }

  Widget buildVisitedTile() {
    return MapMarkerFilterItemTile(
      iconData: FontAwesomeIcons.shoePrints,
      title: '足跡',
      description: '行った / 行ってない で絞り込む',
      items: [
        DropdownMenuItem(
            child: Text(
              "条件なし",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            value: MapMarkerFilterVisited.NOT_SET.index
        ),
        DropdownMenuItem(
            child: Text(
              "行った",
              style: TextStyle(fontSize: 15),
            ),
            value: MapMarkerFilterVisited.VISITED.index
        ),
        DropdownMenuItem(
            child: Text(
              "行ってない",
              style: TextStyle(fontSize: 15),
            ),
            value: MapMarkerFilterVisited.NOT_VISITED.index
        ),
      ],
      selected: this.condition.visitedCondition.index,
      onChanged: setVisitedCondition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: SheetShape.defaultRoundedRadius),
      ),
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        children: [
          Text("フィルターを選択"),
          Divider(),
          Column(
            children: [
              buildVisitedTile(),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: 100,
                  padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: GradatedTextButton(
                    text: '閉じる',
                    onPressed: applyFilterCondition,
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}