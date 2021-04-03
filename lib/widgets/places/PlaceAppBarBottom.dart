import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/FontSettings.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';

class PlaceAppBarBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlaceAppBarBottomState();
}

class PlaceAppBarBottomState extends State<PlaceAppBarBottom> {
  TextEditingController queryString = TextEditingController();
  PlaceViewModel placeViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeViewModel = Provider.of<PlaceViewModel>(context, listen: false);
    queryString.text = placeViewModel.getFilterQuery();
  }

  void filterByQuery() {
    placeViewModel.filterMarkers(queryString.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(2))),
                  child: TextField(
                    controller: queryString,
                    onEditingComplete: filterByQuery,
                    style: TextStyle(
                        fontSize: 14.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "名前・住所で検索",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        isDense: true),
                  ))),
        ],
      ),
    );
  }
}
