import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/view_models/UserViewModel.dart';

class AccountView extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Widget switchByLoginCondition(BuildContext context, UserViewModel model) {
    if (model.user != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in as ${model.user.email}'),
            FlatButton(
                onPressed: () async {
                  print("logout");
                  await model.logout();
                  await googleSignIn.signOut();
                  Navigator.of(context, rootNavigator: true).pushNamed("/login");
                },
                child: Text("logout")
            )
          ],
        ),
      );
    } else {
      return Center(
          child: Text("You are not logged in.")
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "アカウント",
            style: AppBarTitleStyle.textStyle
        ),
      ),
      body: Consumer<UserViewModel>(builder: (context, model, child) {
        return switchByLoginCondition(context, model);
      }),
    );
  }
}
