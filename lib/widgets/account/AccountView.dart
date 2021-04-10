import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/view_models/UserViewModel.dart';

import 'AccountViewItemCard.dart';

class AccountView extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Widget switchByLoginCondition(BuildContext context, UserViewModel model) {
    if (model.user != null) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
              child: Text("ユーザー情報", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            AccountViewItemCard(
              content: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 10),
                        child: Icon(Icons.person_pin, color: Colors.orangeAccent),
                      ),
                      Text('${model.user.email} としてログイン')
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text("aaa"),
                      Text("aaa"),
                      Text("aaa"),
                      Text("aaa"),
                      Text("aaa"),
                      Text("aaa"),
                      Text("aaa"),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              child: Text("デベロッパー情報", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            AccountViewItemCard(
                elevation: 1.0,
                content: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.comment_outlined),
                    ),
                    Text("お問い合わせ・要望フォーム")
                  ],
                ),
                onTap: () {}
            ),
            AccountViewItemCard(
                elevation: 1.0,
              content: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.star_half),
                  ),
                  Text("アプリを評価する")
                ],
              ),
              onTap: () {}
            ),
            AccountViewItemCard(
                elevation: 0.5,
                content: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.notes),
                    ),
                    Text("バージョン情報")
                  ],
                ),
                onTap: null
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 5, bottom: 5, top: 15),
              child: Text("デベロッパー情報", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            AccountViewItemCard(
              elevation: 1.0,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.logout, color: Colors.redAccent),
                  ),
                  Text("ログアウト", style: TextStyle(color: Colors.redAccent),)
                ],
              ),
              onTap: () async {
                print("logout");
                await model.logout();
                await googleSignIn.signOut();
                Navigator.of(context, rootNavigator: true)
                    .pushNamed("/login");
              },
            ),
          ],
        ),
      );
    } else {
      return Center(child: Text("You are not logged in."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("アカウント", style: AppBarTitleStyle.textStyle),
      ),
      body: Consumer<UserViewModel>(builder: (context, model, child) {
        return switchByLoginCondition(context, model);
      }),
    );
  }
}
