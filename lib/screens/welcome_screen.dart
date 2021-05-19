import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:name_generator/components/rounded_button.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/signup_screen.dart';

import 'google_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Align(
        //alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Text(
                      ' Welcome to: ', // $app_name',
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 30,
                          color: theme.accentColor,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '$app_name'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Divider(
                thickness: 2,
                color: theme.accentColor,
              ),
              height: 5,
            ),
            /**OutlinedButton(
              child: Text('Google Sign In'.toUpperCase()),
              onPressed: () {
                print('Google');
                Navigator.pushNamed(context, GoogleScreen.id);
              },
            ),**/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedButton(
                    title: 'Log In'.toUpperCase(),
                    color: theme.buttonColor,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  RoundedButton(
                    title: 'Sign Up'.toUpperCase(),
                    color: theme.buttonColor,
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                thickness: 2,
                color: theme.accentColor,
              ),
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Text(
                  'by Windorland',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      color: theme.accentColor,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
