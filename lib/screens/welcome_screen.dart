import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
      body: Center(
        child: FloatingActionButton(
          tooltip: 'Generate',
          onPressed: () {
            Navigator.pushNamed(context, GenerateScreen.id);
          },
        ),
      ),
    );
  }
}
