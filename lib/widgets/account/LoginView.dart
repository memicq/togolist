import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:togolist/view_models/MapViewModel.dart';
import 'package:togolist/view_models/UserViewModel.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isButtonDisplayed = true;

  Future<FirebaseUser> doSignIn() async {
    GoogleSignInAccount googleCurrentUser = googleSignIn.currentUser;
    try {
      if (googleCurrentUser == null)
        googleCurrentUser = await googleSignIn.signInSilently();
      if (googleCurrentUser == null)
        googleCurrentUser = await googleSignIn.signIn();
      if (googleCurrentUser == null) return null;

      GoogleSignInAuthentication googleAuth = await googleCurrentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await auth.signInWithCredential(credential)).user;



      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void processSignIn() async {
    setState(() {
      isButtonDisplayed = false;
    });

    await doSignIn().then((FirebaseUser user) {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.setUser(user);

      if (userViewModel.user != null) {
        final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
        mapViewModel.updateUserDatabase();

        Navigator.of(context, rootNavigator: true).pop();
      } else {
        setState(() {
          isButtonDisplayed = true;
        });
      }
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    if (!isButtonDisplayed) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () => {},
                      child: SizedBox(
                          width: 140,
                          child: Center(
                              child: Text("Login by Email")
                          )
                      ),
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                      onPressed: () => processSignIn(),
                      child: SizedBox(
                          width: 140,
                          child: Center(
                            child: Text("Login by Google"),
                          )
                      ),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                      onPressed: () => {},
                      child: SizedBox(
                          width: 140,
                          child: Center(
                            child: Text("Login by Facebook"),
                          )
                      ),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                    )
                  ]
              )
          )
      );
    }
  }
}
