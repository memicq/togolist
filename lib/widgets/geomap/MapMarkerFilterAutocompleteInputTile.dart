

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MapMarkerFilterAutocompleteInputTile extends StatefulWidget {
  IconData iconData;
  String title;
  String description;

  MapMarkerFilterAutocompleteInputTile({
    this.iconData,
    this.title,
    this.description
  });

  @override
  State<StatefulWidget> createState() => MapMarkerFilterAutocompleteInputTileState();
}

class MapMarkerFilterAutocompleteInputTileState extends State<MapMarkerFilterAutocompleteInputTile> {
  TextEditingController _input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _input,
                    decoration: InputDecoration(hintText: "相手のポケモン名"),
                    onChanged: (value){},
                  ),
                  suggestionsCallback: (pattern) {
                    return ["東京駅", "渋谷駅"];
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion)
                    );
                  },
                  onSuggestionSelected: (suggestion) async {

                  },
                ),
              )
          )
        ],
      ),
    );
  }
}