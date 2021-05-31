import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/components/popup_dialog.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/settings_screen.dart';
import 'package:name_generator/services/favorites_stream.dart';
import 'package:name_generator/services/names.dart';

User loggedInUser;

class UserScreen extends StatefulWidget {
  static String id = 'user_screen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  NameRetriever nr = new NameRetriever(loggedInUser);
  NameTile testTile = NameTile('Jamie', 'eng', 'mf', loggedInUser, true);

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
      ErrorPopUp('Authentication Error', e.toString()).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double letterSpaces = 2;
    double divSize = 3;
    Color divColor = theme.primaryColor;

    String userDisplayName = loggedInUser.displayName == null
        ? loggedInUser.email
        : loggedInUser.displayName;

    Color iconColor = theme.accentColor;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hey,".toUpperCase(),
                    style: TextStyle(
                        color: theme.accentColor,
                        letterSpacing: letterSpaces,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                Text(userDisplayName.toUpperCase(),
                    style: TextStyle(
                        color: theme.accentColor,
                        letterSpacing: letterSpaces,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Divider(
            thickness: divSize,
            color: divColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Favorites: ".toUpperCase(),
                  style: TextStyle(
                      color: theme.accentColor,
                      letterSpacing: letterSpaces,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add),
                        color: iconColor,
                        onPressed: () {
                          Navigator.pushNamed(context, GenerateScreen.id);
                        }),
                    IconButton(
                      icon: Icon(Icons.settings),
                      color: iconColor,
                      onPressed: () {
                        Navigator.pushNamed(context, SettingsScreen.id);
                      },
                    ),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                'Tap the star to unfavorite, and hit the plus sign to find new names!',
                style: TextStyle(color: theme.primaryColor)),
          ),
          FavoritesStream(
              loggedInUser), // TODO: [BUG] figure out why this can't be put into a flex: 2 Expanded
          Divider(
            thickness: divSize,
            color: divColor,
          ),
        ],
      ),
    );
  }
}
