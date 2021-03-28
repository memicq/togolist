
import 'package:flutter/material.dart';
import 'package:togolist/const/PlaceListSortingKey.dart';
import 'package:togolist/const/Shape.dart';

class PlaceListSortingDialog extends StatefulWidget {
  PlaceListSortingKey initialSortingKey;
  Function onSortingKeyChanged = (PlaceListSortingKey sortingKey){};

  PlaceListSortingDialog({this.initialSortingKey, this.onSortingKeyChanged});

  @override
  State<StatefulWidget> createState() => PlaceListSortingDialogState();
}

class PlaceListSortingDialogState extends State<PlaceListSortingDialog> {
  String _selected;

  @override
  void initState() {
    this._selected = widget.initialSortingKey.code;
    super.initState();
  }

  void onChangeRadio(String value) {
    setState(() {
      this._selected = value;
    });
    widget.onSortingKeyChanged(PlaceListSortingKeyUtil.fromCode(value));
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(SheetShape.defaultRoundedRadius)),
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("ソートのキーを選択"),
              Divider(),
              Column(
                children: [
                  RadioListTile(
                    secondary: Icon(Icons.title),
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text('名前'),
                    subtitle: Text('名前の50音で並び替え', style: TextStyle(fontSize: 12)),
                    activeColor: Colors.orange,
                    value: PlaceListSortingKey.PLACE_NAME.code,
                    groupValue: _selected,
                    onChanged: (value) => onChangeRadio(value),
                  ),
                  RadioListTile(
                    secondary: Icon(Icons.near_me_outlined),
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text('距離'),
                    subtitle: Text('現在地からの距離を使って並び替え', style: TextStyle(fontSize: 12)),
                    activeColor: Colors.orange,
                    value: PlaceListSortingKey.DISTANCE.code,
                    groupValue: _selected,
                    onChanged: onChangeRadio,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}