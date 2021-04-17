import 'package:flutter/material.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';

class InquiryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(SheetShape.defaultRoundedRadius)),
      contentPadding: EdgeInsets.all(10),
      children: [
        Center(child: Text("お問い合わせ・要望フォーム")),
        Divider(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text("タイトル", style: TextStyle(fontSize: 13)),
              ),
              Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.all(Radius.circular(2))),
                  child: TextField(
                    onChanged: (value) {},
                    style: TextStyle(
                        fontSize: 12.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "例）〇〇な機能がほしい、〇〇なバグを見つけた、等",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  )),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text("内容", style: TextStyle(fontSize: 13)),
              ),
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.all(Radius.circular(2))),
                  child: TextField(
                    minLines: 10,
                    maxLines: 10,
                    onChanged: (value) {},
                    style: TextStyle(
                        fontSize: 12.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
//                      hintText: "画面、時間、",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  )),
            ])),
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: 60,
                    child: GradatedTextButton(
                      text: '送信',
                      onPressed: () {},
                    )
                ),
              ]
          ),
        )
      ],
    );
  }
}
