import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/view_models/UserViewModel.dart';

class SwitchLoginOrHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwitchLoginOrHomeState();
}

class SwitchLoginOrHomeState extends State<SwitchLoginOrHome> {
  void checkUser() async{
    final currentUser = await FirebaseAuth.instance.currentUser();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if(currentUser == null){
      Navigator.pushReplacementNamed(context,"/login");
    }else{
      userViewModel.setUser(currentUser);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}