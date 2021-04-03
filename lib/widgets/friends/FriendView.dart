
import 'package:flutter/material.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';

class FriendView extends StatefulWidget {
  @override
  State<FriendView> createState() => FriendViewState();
}

class FriendViewState extends State<FriendView> {

  BackdropService backdropService = BackdropService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        actions: [
          FlatButton(
              onPressed: (){},
              child: Icon(
                Icons.person_add,
                color: ColorSettings.primaryColor['lighten'],
              )
          )
        ],
      ),
      body: Center(
        child: Text("friends"),
      ),
    );
  }
}