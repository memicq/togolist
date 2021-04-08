import 'package:flutter/material.dart';
import 'package:togolist/models/MapMarker.dart';
import 'package:togolist/widgets/places/detail/PlaceDetailItemCard.dart';

class PlaceDetailMapArea extends StatelessWidget {
  MapMarker marker;
  PlaceDetailMapArea({this.marker});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaceDetailItemCard(
                  title: "近傍マップ",
                  content: ColoredBox(color: Colors.red)
              ),
              PlaceDetailItemCard(
                  title: "最寄り駅",
                  content: ColoredBox(color: Colors.red)
              )
            ]
        )
    );
  }
}