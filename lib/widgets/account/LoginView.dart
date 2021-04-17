import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:togolist/repositories/MarkerRepositoryFB.dart';
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

  Future<FirebaseUser> doGoogleSignIn() async {
    GoogleSignInAccount googleCurrentUser = googleSignIn.currentUser;
    try {
      if (googleCurrentUser == null) googleCurrentUser = await googleSignIn.signInSilently();
      if (googleCurrentUser == null) googleCurrentUser = await googleSignIn.signIn();
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

  void processGuestSignIn() async {
    setState(() {
      isButtonDisplayed = false;
    });

    final FirebaseUser user = (await auth.signInAnonymously()).user;
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.setUser(user);

    if (userViewModel.user != null) {
      await MarkerRepositoryFB().updateUser();

      Navigator.of(context, rootNavigator: true).pop();
    } else {
      setState(() {
        isButtonDisplayed = true;
      });
    }
  }

  void processGoogleSignIn() async {
    setState(() {
      isButtonDisplayed = false;
    });

    await doGoogleSignIn().then((FirebaseUser user) async {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.setUser(user);

      if (userViewModel.user != null) {
        await MarkerRepositoryFB().updateUser();

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
                      onPressed: () => processGuestSignIn(),
                      child: SizedBox(
                          width: 140,
                          child: Center(
                              child: Text("匿名ログイン")
                          )
                      ),
                      color: Colors.grey,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                      onPressed: () => {},
                      child: SizedBox(
                          width: 140,
                          child: Center(
                              child: Text("Emailでログイン")
                          )
                      ),
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                      onPressed: () => processGoogleSignIn(),
                      child: SizedBox(
                          width: 140,
                          child: Center(
                            child: Text("Googleでログイン"),
                          )
                      ),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ]
              )
          )
      );
    }
  }
}
