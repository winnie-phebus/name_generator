import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/rounded_button.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';

//TODO: catch errors and display them on the screen instead of hanging
class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String targetScreen = GenerateScreen.id;

  bool showSpinner = false;
  String email;
  String password;

  bool hidePassword = true;
  IconData passwordVisual = Icons.remove_red_eye_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("$app_name"),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email', prefixText: 'Email:'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: hidePassword,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.',
                  prefixText: 'Password:',
                ),
              ),
              IconButton(
                icon: Icon(passwordVisual),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                    passwordVisual = hidePassword
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye;
                  });
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Theme.of(context).bottomAppBarColor,
                title: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
