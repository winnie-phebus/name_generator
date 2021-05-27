import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/back_button.dart';
import 'package:name_generator/components/password_textfield.dart';
import 'package:name_generator/components/popup_dialog.dart';
import 'package:name_generator/components/rounded_button.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/settings_screen.dart';
import 'package:name_generator/screens/user_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String targetScreen = UserScreen.id;

  bool showSpinner = false;
  String email;
  String password;

  bool hidePassword = true;
  IconData passwordVisual = Icons.remove_red_eye_outlined;

  void loginPress() async {
    print("login press, $email and $password");
    setState(() {
      Text('Please Wait.');
      showSpinner = true;
    });
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Firestore comm done');
      if (newUser != null) {
        Navigator.pushNamed(context, targetScreen);
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print('LOGIN ERROR: ');
      print('Is this device connected to the internet?');
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            'LogIn Error'.toUpperCase(),
            'Error: ' + e.toString() + '\n Try connecting to the internet?'),
      );
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Log In'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 30,
                        color: theme.accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 2,
                    color: theme.accentColor,
                  ),
                ],
              ),
            ),
            ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.right,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          //prefixText: 'Email:',
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: 'email, please'.toUpperCase()),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    PassTextField(
                      'password, please',
                      onChanged: ((String value) => (password = value)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackArrowButton(),
                        RoundedButton(
                            color: theme.buttonColor,
                            title: 'Log In',
                            onPressed: () {
                              loginPress();
                            }),
                        IconButton(
                          color: theme.accentColor,
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pushNamed(context, SettingsScreen.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
