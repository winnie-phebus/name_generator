import 'package:flutter/material.dart';
import 'package:name_generator/components/back_button.dart';
import 'package:name_generator/components/popup_dialog.dart';
import 'package:name_generator/components/rounded_button.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:name_generator/screens/welcome_screen.dart';
import 'package:name_generator/services/favorites_stream.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  void logout() {
    setState(() {
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }

  void deleteAccount() {
    bool confirmed = false;
    ConfirmationPopUp('Delete Account?',
        'Hey, deleting your account is a big deal! You\'ll lose all your favorites. Are you sure?',
        () {
      confirmed = true;
      print('delete!, $confirmed');
      FavoritesStream(user).clearFavorites();
      /*Stream<QuerySnapshot> userFavorites =
          FavoritesStream(user).userFavorites();
      var favorites = snapshot.data.documents;*/
      /*for (var fav in userFavorites) {
        print(fav.data);
      }*/
      //user.delete();
      //Navigator.pushNamed(context, WelcomeScreen.id);
    }).show(context);
    //print('confirmed = $confirmed');
    /* if (confirmed == true) {
      print('Now switch');
    } */
    setState(() {
      // Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color divColor = theme.accentColor;
    double divSize = 3;

    String acctEmail = user.email;
    return Scaffold(
      /*appBar: AppBar(
        title: Text(app_name),
      ),*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings'.toUpperCase(),
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    BackArrowButton(),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: divSize,
            color: divColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              'Account: $acctEmail'.toUpperCase(),
              softWrap: true,
              style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  title: 'Log Out',
                  onPressed: () {
                    logout();
                  },
                ),
                RoundedButton(
                  title: 'Delete Account',
                  onPressed: () {
                    deleteAccount();
                  },
                ),
              ],
            ),
          ),
          Divider(
            thickness: divSize,
            color: divColor,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Bug Reporting + Troubleshoot Tips'.toUpperCase(),
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Right now I don\'t have a fun, quick and easy way to handle this, but I\'m working on it! \nYou can email windorland7@gmail.com to report a bug, and please make sure the subject starts with \'[NAMELEON BUG]:\' so I see it. \nThank you!',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
