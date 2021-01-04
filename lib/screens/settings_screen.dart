import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app_name),
      ),
    );
  }
}
