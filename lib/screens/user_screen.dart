import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/signup_screen.dart';
import 'package:name_generator/services/favorites_stream.dart';
import 'package:name_generator/services/names.dart';

final _firestore = FirebaseFirestore.instance;
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

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void favoritesStream() async {
    await for (var snapshot
        in _firestore.collection('favorite_names').snapshots()) {
      for (var favorite in snapshot.docs) {
        print(favorite.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information Page'),
      ),
      body: Column(
        children: [
          Text("Favorites: ".toUpperCase()),
          FavoritesStream(loggedInUser),
          FloatingActionButton(
              child: Text('Press'.toUpperCase()),
              onPressed: () {
                setState(
                  () {
                    // setTestTile();
                  },
                );
              })
        ],
      ),
    );
  }
}
