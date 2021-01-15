import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/screens/generate_screen.dart';
import 'package:name_generator/screens/signup_screen.dart';
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
  NameRetriever nr = new NameRetriever();
  NameTile testTile = NameTile('Jamie', 'eng', 'mf', true);

  void setTestTile() async {
    testTile = await nr.nameTileBuilder('Sandra', true);
  }

  @override
  void initState() {
    super.initState();
    //setTestTile();
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
      for (var message in snapshot.docs) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          NameTile(
              'Sandra',
              'Italian, English, French, Spanish, Portuguese, German, Dutch, Swedish, Norwegian, Danish, Icelandic, Latvian, Lithuanian, Polish, Slovene, Croatian, Serbian, Macedonian, Czech, Romanian',
              'f',
              true),
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SizedBox(
              height: 300,
              child: CustomScrollView(
                shrinkWrap: false,
              ),
            ),
          ),
          FloatingActionButton(onPressed: () {
            setState(() {
              setTestTile();
            });
            print(nr.nameTileBuilder('Sandra', true));
          })
        ],
      ),
    );
  }
}
