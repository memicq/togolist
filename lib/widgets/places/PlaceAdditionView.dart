import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/MapViewModel.dart';

class PlaceAdditionView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _address;
  String _latitude;
  String _longitude;

  Future<void> postPlace(BuildContext context, MapViewModel model) async {
    double latitude;
    double longitude;

    if (_title.isEmpty ||
        _address.isEmpty ||
        _latitude.isEmpty ||
        _longitude.isEmpty
    ) {
      print("none");
    } else {
      try {
        latitude = double.parse(_latitude);
        longitude = double.parse(_longitude);
      } catch (e) {
        print(e.toString());
      } finally {
        model.marker = MapMarker(_title, _address, latitude, longitude);
        await model.addMarker();
        await Navigator.of(context).pop();
        await model.fetchMarkers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(
        builder: (context, model, child) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                trailing: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 33),
                  child: CupertinoButton(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    borderRadius: BorderRadius.circular(90),
                    color: ColorSettings.primaryColor,
                    disabledColor: ColorSettings.primaryColor,
                    child: Text("場所を追加", style: TextStyle(fontSize: 15)),
                    onPressed: () => postPlace(context, model),
                  ),
                )
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CupertinoTextField(
                          placeholder: "タイトル",
                          onChanged: (value) => { _title = value },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CupertinoTextField(
                          placeholder: "住所",
                          onChanged: (value) => { _address = value },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CupertinoTextField(
                          placeholder: "緯度",
                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                          onChanged: (value) => { _latitude = value },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CupertinoTextField(
                          placeholder: "経度",
                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                          onChanged: (value) => { _longitude = value },
                        ),
                      ),
                    ],
                  )
              ),
            ),
          );
        }
    );
  }
}