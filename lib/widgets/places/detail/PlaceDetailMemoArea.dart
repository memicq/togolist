import 'package:flutter/material.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailMemoArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlaceDetailMemoAreaState();
}

class PlaceDetailMemoAreaState extends State<PlaceDetailMemoArea> {
  FocusNode _focus = FocusNode();
  bool _hasFocus;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _hasFocus = _focus.hasFocus;
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focus.hasFocus;
    });
  }

  Widget switchShowSaveIconButton() {
    if (_hasFocus) {
      return Container(
        alignment: Alignment.bottomRight,
        width: 30,
        height: double.infinity,
        child: IconButton(
          icon: Icon(Icons.save_alt),
          onPressed: (){},
        ),
      );
    } else return null;
  }

  Widget buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200),
        child: Scrollbar(
          child: TextField(
            focusNode: _focus,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              suffixIcon: switchShowSaveIconButton(),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            maxLines: 10,
            minLines: 10,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PlaceDetailItemCard(
            title: "メモ",
            content: buildTextField(),
          ),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}