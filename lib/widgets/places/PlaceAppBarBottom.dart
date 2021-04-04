import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/FontSettings.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';

import 'PlaceView.dart';

class PlaceAppBarBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlaceAppBarBottomState();
}

class PlaceAppBarBottomState extends State<PlaceAppBarBottom> {
  TextEditingController queryString = TextEditingController();
  PlaceViewModel placeViewModel;
  PlaceViewState _placeViewState;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _placeViewState = context.findAncestorStateOfType<PlaceViewState>();
    _focus.addListener(_onFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeViewModel = Provider.of<PlaceViewModel>(context, listen: false);
    queryString.text = placeViewModel.getFilterQuery();
  }

  void filterByQuery() {
    placeViewModel.filterMarkers(queryString.text);
  }

  void _onFocusChange() {
    _placeViewState.toggleFocusingSearchArea(_focus.hasFocus);
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
                    focusNode: _focus,
                    controller: queryString,
                    onChanged: (value) => filterByQuery(),
                    style: TextStyle(
                        fontSize: 14.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "一覧から名前・住所で検索",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ))),
        ],
      ),
    );
  }
}
