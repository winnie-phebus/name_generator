import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// A good portion of this implementation can be accredited to:
// https://medium.com/flutter-community/authenticate-with-a-gmail-account-in-your-flutter-apps-using-firebase-authentication-9cbf95796157
class GoogleScreen extends StatefulWidget {
  static String id = 'google_signin_screen';
  @override
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;

  bool isUserSignedIn = false;

  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    // immediately check whether the user is signed in
    //checkIfUserIsSignedIn();
  }

  Future<User> _handleSignIn() async {
    // hold the instance of the authenticated user
    User user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    // setState(() {
    // isUserSignedIn = userSignedIn;
    //});
    if (isSignedIn) {
      // if so, return the current user
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;
      /**userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });**/
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    /**User user = await _handleSignIn();
    var userSignedIn = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WelcomeUserWidget(user, _googleSignIn)));
    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });**/
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
