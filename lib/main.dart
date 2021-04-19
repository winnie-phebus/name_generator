import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/google_screen.dart';
import 'package:name_generator/screens/login_screen.dart';
import 'package:name_generator/screens/settings_screen.dart';
import 'package:name_generator/screens/signup_screen.dart';
import 'package:name_generator/screens/user_screen.dart';
import 'package:name_generator/screens/welcome_screen.dart';

void main() => runApp(NameGen());

// TODO: look into testing when you're ready for publish!
class NameGen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      theme: ThemeData.from(colorScheme: kdefaultScheme),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        GoogleScreen.id: (context) => GoogleScreen(),
        UserScreen.id: (context) => UserScreen(),
        GenerateScreen.id: (context) => GenerateScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}
