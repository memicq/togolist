import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:togolist/const/ColorSetting.dart';
import 'package:togolist/const/Style.dart';
import 'package:togolist/view_models/UserViewModel.dart';
import 'package:togolist/widgets/account/InquiryDialog.dart';
import 'package:togolist/widgets/account/PrivacyPolicyView.dart';

import 'AccountViewItemCard.dart';

class AccountView extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();


  void openPrivacyPolicy(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) {
          return PrivacyPolicyView();
        })
    );
  }

  void openInquiryDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return InquiryDialog();
        });
  }

  void _requestReview() {
    AppReview.requestReview.then((onValue) {
      print(onValue);
    });
  }

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
                        child: Icon(Icons.person_pin, color: ColorSettings.primaryColor),
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
              child: Text("このアプリについて", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            AccountViewItemCard(
                elevation: 1.0,
                content: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.privacy_tip_outlined),
                    ),
                    Text("プライバシーポリシー")
                  ],
                ),
                onTap: () { openPrivacyPolicy(context); }
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
                onTap: () { openInquiryDialog(context); }
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
              onTap: () { _requestReview(); }
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
              child: Text("その他", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ),
            AccountViewItemCard(
              elevation: 1.0,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.logout, color: Colors.red),
                  ),
                  Text("ログアウト", style: TextStyle(color: Colors.red),)
                ],
              ),
              onTap: () async {
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
