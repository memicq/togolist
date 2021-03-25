import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';

class PlaceAppBarBottom extends StatelessWidget {

  void openSortingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: Center(
              child: Text("ソートを設定するダイアログが表示される"),
          )
          );
        }
    );
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
                    style: TextStyle(
                        fontSize: 14.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "名前・住所で検索（見た目だけ）",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        isDense: true),
                  ))),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: ButtonTheme(
              minWidth: 0,
              child: RaisedButton(
                elevation: 0,
                color: ColorSettings.primaryColor['lighten2'],
                onPressed: () => {
                  openSortingDialog(context)
                },
                child: Icon(Icons.sort_rounded),
                textColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
