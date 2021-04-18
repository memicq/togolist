import 'package:flutter/material.dart';
import 'package:togolist/const/Shape.dart';
import 'package:togolist/repositories/InquiryRepositoryFB.dart';
import 'package:togolist/widgets/common/GradatedTextButton.dart';

class InquiryDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InquiryDialogState();
}

class InquiryDialogState extends State<InquiryDialog> {
  InquiryRepositoryFB _inquiryRepositoryFB = InquiryRepositoryFB();

  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();

  bool isSubmitDisabled = true;

  void onChangeTitle(String value) {
    checkCanSubmit();
  }

  void onChangeContent(String value) {
    checkCanSubmit();
  }

  void checkCanSubmit() {
    if (isSubmitDisabled && _title.text.isNotEmpty && _content.text.isNotEmpty) {
      setState(() {
        isSubmitDisabled = false;
      });
    }
    if (isSubmitDisabled == false && _title.text.isEmpty && _content.text.isEmpty)  {
      setState(() {
        isSubmitDisabled = true;
      });
    }
  }

  void onSubmit() {
    _inquiryRepositoryFB.saveInquiry(_title.text, _content.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(SheetShape.defaultRoundedRadius)),
      contentPadding: EdgeInsets.zero,
      children: [
        Container(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Center(
              child: Text("お問い合わせ・要望フォーム"),
            )),
        Divider(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text("タイトル", style: TextStyle(fontSize: 13)),
              ),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  child: TextField(
                    controller: _title,
                    onChanged: onChangeTitle,
                    style: TextStyle(
                        fontSize: 14.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "例）〇〇な機能がほしい等",
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
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  child: TextField(
                    controller: _content,
                    minLines: 10,
                    maxLines: 10,
                    onChanged: onChangeContent,
                    style: TextStyle(
                        fontSize: 14.0, height: 1.2, color: Colors.black),
                    decoration: InputDecoration(
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
          padding: EdgeInsets.only(right: 10, bottom: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
                width: 60,
                child: GradatedTextButton(
                  text: '送信',
                  onPressed: (isSubmitDisabled) ? null : onSubmit,
                )),
          ]),
        )
      ],
    );
  }
}
