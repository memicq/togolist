import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailMemoArea extends StatefulWidget {
  MapMarker marker;
  PlaceDetailMemoArea({this.marker});

  @override
  State<StatefulWidget> createState() => PlaceDetailMemoAreaState();
}

class PlaceDetailMemoAreaState extends State<PlaceDetailMemoArea> {
  FocusNode _focus = FocusNode();
  bool _hasFocus;
  PlaceViewModel _placeViewModel;

  TextEditingController _memoValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _hasFocus = _focus.hasFocus;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _memoValue.text = widget.marker.memo;
    _placeViewModel = Provider.of<PlaceViewModel>(context, listen: false);
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focus.hasFocus;
    });
  }

  Future<void> saveMemo() async {
    MapMarker updated = await _placeViewModel.saveMemo(widget.marker, _memoValue.text);
    widget.marker = updated;
    FocusScope.of(context).unfocus();
  }

  Widget switchShowSaveIconButton() {
    if (_hasFocus) {
      return Container(
        alignment: Alignment.bottomRight,
        width: 30,
        height: double.infinity,
        child: IconButton(
          icon: Icon(Icons.save_alt),
          onPressed: () { saveMemo(); },
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
            controller: _memoValue,
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
            maxLines: 15,
            minLines: 15,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87
            ),
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
          SizedBox(height: 200)
        ],
      ),
    );
  }
}