import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:togolist/const/Credentials.dart';

// app-ads.txt
// google.com, pub-5680575878112984, DIRECT, f08c47fec0942fa0

class PlaceListCardAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlaceListCardAdState();
}

class PlaceListCardAdState extends State<PlaceListCardAd> {
  int height = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: AdmobBanner(
                adUnitId: Credentials.testAdmobUnitIdIOS,
                adSize: AdmobBannerSize(
                    width: MediaQuery.of(context).size.width.toInt(),
                    height: height
                )
            ),
        )
    );
  }
}
