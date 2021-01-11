import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:name_generator/components/rounded_button.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/signup_screen.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome to $app_name!'),
            SizedBox(
              height: 10,
            ),
            Text('Please log in or sign up to get started.'),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              child: Text('Sign in using Google.'),
              onPressed: () {
                print('Google');
              },
            ),
            OutlinedButton(
              child: Text('Log In'),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            TextButton(
              child: Text('Sign Up / Create an Account'),
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
