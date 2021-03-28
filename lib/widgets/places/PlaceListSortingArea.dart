import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:togolist/const/PlaceListSortingKey.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/widgets/places/PlaceListSortingDialog.dart';

class PlaceListSortingArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlaceListSortingAreaState();
}

class PlaceListSortingAreaState extends State<PlaceListSortingArea> {

  Icon buildIcon() {
    return Icon(
      FontAwesomeIcons.sortNumericDown,
      color: Colors.deepOrange.shade400,
      size: 17,
    );
  }

  void openSortingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return PlaceListSortingDialog(
            initialSortingKey: PlaceListSortingKey.PLACE_NAME,
            onSortingKeyChanged: onSortingKeyChanged
          );
        }
    );
  }

  void onSortingKeyChanged(PlaceListSortingKey sortingKey) {
    print(sortingKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 35,
              child: TextButton(
                child: Text(
                    "名前順",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )
                ),
                onPressed: openSortingDialog,
              ),
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: TextButton(
                child: buildIcon(),
                onPressed: (){},
              ),
            ),
          ]
      ),
    );
  }
}