import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togolist/models/GooglePlaceType.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/services/ExternalUrlLaunchService.dart';
import 'package:togolist/utils/ListUtil.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailBasicInfoArea extends StatelessWidget {
  MapMarker marker;

  PlaceDetailBasicInfoArea({this.marker});

  ExternalUrlLaunchService _launchService = ExternalUrlLaunchService();

  Widget buildTypeRow() {
    // TODO: 色を変えることで必要な情報とそうでない情報が区別できそうだったが印象が整わないので後回しにする
    TextStyle greyStyle = TextStyle(fontSize: 13, color: Color(0x99000000));
    TextStyle sepStyle = TextStyle(fontSize: 13, color: Colors.black38);
    TextStyle emStyle = TextStyle(fontSize: 13, color: Color(0x99000000));

    List<SelectableText> typeList = this
        .marker
        .types
        .map((code) => GooglePlaceTypeExt.fromCode(code))
        .toList()
        .where((type) => type != null)
        .map((type) => (type.category == 0)
            ? SelectableText(type.japaneseName, style: emStyle)
            : SelectableText(type.japaneseName, style: greyStyle))
        .toList();

    if (typeList.isNotEmpty) {
      List<Text> separators = List.generate(typeList.length-1, (index) => Text(" / ", style: sepStyle));
      return Row(children: ListUtil.zip(typeList, separators).toList());
    } else {
      return Row(children: [Text("-", style: greyStyle)]);
    }
  }

  Widget buildOpeningHoursTable() {
    if (this.marker.openingHoursJson != null) {
      return PlaceDetailItemCard(
        title: "営業情報",
        content: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildOpeningHourText(),
            )),
      );
    } else
      return Container();
  }

  List<SelectableText> buildOpeningHourText() {
    return this.marker.getOpeningHours().entries.map((e) {
      return SelectableText("・ ${e.key} / ${e.value}", style: TextStyle(fontSize: 13, color: Colors.black54));
    }).toList();
  }

  List<Widget> buildContactButtons() {
    return [
      if (this.marker.phoneNumber != null)
        IconButton(
          icon: Icon(Icons.phone_forwarded),
          onPressed: () {
            _launchService.launchPhone(this.marker.phoneNumber);
          }),
      if (this.marker.website != null)
        IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () {
              _launchService.launchInBrowser(this.marker.website);
            }),
//      IconButton(icon: Icon(FontAwesomeIcons.instagram), onPressed: () {}),
//      IconButton(icon: Icon(FontAwesomeIcons.twitter), onPressed: () {}),
//      IconButton(icon: Icon(FontAwesomeIcons.facebook), onPressed: () {}),
    ].where((type) => type != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlaceDetailItemCard(
          title: "住所",
          content: SelectableText(this.marker.address,
              style: TextStyle(fontSize: 13, color: Colors.black54)),
        ),
        PlaceDetailItemCard(
          title: "コンタクト",
          content: Row(
            children: buildContactButtons()
          ),
        ),
        buildOpeningHoursTable(),
        PlaceDetailItemCard(
          title: "場所タイプ",
          content: buildTypeRow(),
        ),
        SizedBox(height: 200)
      ],
    ));
  }
}
