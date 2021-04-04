import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/models/PlaceItem.dart';
import 'package:togolist/repositories/GooglePlacesRepositoryApi.dart';

class PlaceAdditionFormDialog extends StatefulWidget {
  Function updateSelectedItem;

  PlaceAdditionFormDialog({this.updateSelectedItem});

  @override
  State<PlaceAdditionFormDialog> createState() =>
      PlaceAdditionFormDialogState();
}

class PlaceAdditionFormDialogState extends State<PlaceAdditionFormDialog> {
  bool isSearchedOnce = false;
  var searchQuery = TextEditingController();
  GooglePlacesRepositoryApi _placesRepositoryApi = GooglePlacesRepositoryApi();

  List<PlaceItem> placeItems = [];

  Future<void> fetchPlaces() async {
    List<PlaceItem> items = await _placesRepositoryApi.searchPlaceByText(searchQuery.text);

    setState(() {
      this.isSearchedOnce = true;
      placeItems = items;
    });
  }

  void onPressedPlaceItem(PlaceItem item) {
    widget.updateSelectedItem(item);
    Navigator.of(context).pop();
  }

  List<Widget> buildPlacesList() {
    return placeItems
        .map((item) => FlatButton(
            onPressed: () => onPressedPlaceItem(item),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      item.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                      item.address,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black26, fontSize: 10),
                    )
                  ],
                ))))
        .toList();
  }

  Widget buildResultArea() {
    if (this.isSearchedOnce && this.placeItems.isNotEmpty) {
      return Scrollbar(
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Column(
              children: buildPlacesList(),
            ),
          )
      );
    } else if (this.isSearchedOnce && this.placeItems.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.not_listed_location_outlined, size: 70, color: Colors.black26),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
                "結果なし",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 13
                )
            ),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 70, color: Colors.black26),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
                "こちらに検索結果が表示されます",
                style: TextStyle(
                    color: Colors.black45,
                  fontSize: 13
                )
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(SheetShape.defaultRoundedRadius)),
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 350,
              width: 300,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("名前で場所検索"),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(2))),
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 14.0, height: 1.2, color: Colors.black),
                      controller: searchQuery,
                      onEditingComplete: () => fetchPlaces(),
                      decoration: InputDecoration(
                          hintText: "検索",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 13),
                          isDense: true),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(child: buildResultArea())
                ],
              ))
        ]);
  }
}
