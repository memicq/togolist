
import 'package:flutter/material.dart';
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
      body: Stack(
        children: [
          Center(
            child: Text("friends"),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: GradatedIconButton(
              icon: Icon(Icons.person_add),
              onPressed: () => {},
            ),
          )
        ],
      )
    );
  }
}