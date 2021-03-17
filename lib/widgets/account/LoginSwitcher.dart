import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/view_models/UserViewModel.dart';

class LoginSwitcher extends StatefulWidget {
  Widget child;

  LoginSwitcher({this.child});

  @override
  State<StatefulWidget> createState() => LoginSwitcherState();
}

class LoginSwitcherState extends State<LoginSwitcher> {

  bool isLoading = false;

  void checkUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);

    if(currentUser == null){
      Navigator.of(context, rootNavigator: true).pushNamed("/login");
    } else {
      await userViewModel.setUser(currentUser);
      await mapViewModel.updateUserDatabase();
      setState(() {
        this.isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: ColorSettings.primaryColor,
            ),
            Text("Loading...")
          ],
        ),
      );
    } else {
      return widget.child;
    }
  }
}