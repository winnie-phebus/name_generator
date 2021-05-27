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

class SignupScreen extends StatefulWidget {
  static String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password_first;
  String password_confirm;
  bool showSpinner = false;
  String targetScreen = UserScreen.id;

  bool hidePassword = true;
  IconData passwordVisual = Icons.remove_red_eye_outlined;

  void registerPress() async {
    setState(() {
      showSpinner = true;
    });

    try {
      if (password_first != password_confirm) {
        showDialog(
          context: context,
          builder: (BuildContext context) => ErrorPopUp(
              'LogIn Error'.toUpperCase(),
              'Error: given passwords don\'t match. Try again.'),
        );
        return;
      }
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password_confirm);
      if (newUser != null) {
        Navigator.pushNamed(context, targetScreen);
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print('REGISTRATION ERROR: ');
      print('Is the device connected to the internet?');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Sign Up'.toUpperCase(),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        hintText: 'desired email, please'.toUpperCase()),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  PassTextField('password, please',
                      onChanged: ((String value) => (password_first = value))),
                  SizedBox(
                    height: 8.0,
                  ),
                  PassTextField('confirm password',
                      onChanged: ((String value) =>
                          (password_confirm = value))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackArrowButton(),
                      RoundedButton(
                          title: 'Register',
                          color: theme.buttonColor,
                          onPressed: () async {
                            registerPress();
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
    );
  }
}
