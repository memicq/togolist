import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/MapMarkerFilterCondition.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';

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

  void setVisitedCondition(MapMarkerFilterVisited cond) {
    setState(() {
      this.condition.visitedCondition = cond;
    });
  }

  void applyFilterCondition() async {
    MapViewModel mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    mapViewModel.updateCondition(this.condition);
    await mapViewModel.fetchMarkers();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: SheetShape.defaultRoundedRadius),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("フィルターを選択"), // TODO: 「キー」という言葉はおそらくわかりにくいので修正する
          Divider(),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            defaultColumnWidth: IntrinsicColumnWidth(),
            children: [
              TableRow(
                  children: [
                    Text("行ったこと", style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Radio(
                          value: MapMarkerFilterVisited.NOT_SET,
                          groupValue: this.condition.visitedCondition,
                          onChanged: setVisitedCondition,
                        ),
                        Text("未設定"),
                        Radio(
                          value: MapMarkerFilterVisited.VISITED,
                          groupValue: this.condition.visitedCondition,
                          onChanged: setVisitedCondition,
                        ),
                        Text("あり"),
                        Radio(
                          value: MapMarkerFilterVisited.NOT_VISITED,
                          groupValue: this.condition.visitedCondition,
                          onChanged: setVisitedCondition,
                        ),
                        Text("なし"),
                      ],
                    )
                  ]
              )
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
                    text: '適用',
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