import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:name_generator/components/popup_dialog.dart';
import 'package:name_generator/resources/constants.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class NameTile extends StatefulWidget {
  String name;
  String usage;
  String gender;
  User currentUser;
  bool isFavorited;

  @override
  _NameTileState createState() => _NameTileState(
      this.name, this.usage, this.gender, this.currentUser, this.isFavorited);

  NameTile(
      this.name, this.usage, this.gender, this.currentUser, this.isFavorited);
}

class _NameTileState extends State<NameTile> {
  String name;
  String usage;
  String gender;
  User currentUser;
  bool isFavorited;

  _NameTileState(
      this.name, this.usage, this.gender, this.currentUser, this.isFavorited);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "$name, $usage, $gender, $isFavorited";
  }

  // void changeFavorited(bool favoriteStatus) {
  //   isFavorited = favoriteStatus;
  // }

  void favoritingError(Error e) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopUp(
          'Favoriting Error'.toUpperCase(),
          'Error: ' + e.toString() + '\n Try again?'),
    );
  }

  void updateFavorites(String name, String usage, String gender) {
    isFavorited = !isFavorited;
    if (isFavorited) {
      try {
        _firestore.collection('favorite_names').add({
          'name': name,
          'usages': usage,
          'gender': gender,
          'user': currentUser.email
        });
      } catch (e) {
        isFavorited = false;
        favoritingError(e);
      }
    } else {
      try {
        // TODO: find ID of document
        String docId = null;
        _firestore.collection('favorite_names').doc(docId).delete();
      } catch (e) {
        isFavorited = true;
        favoritingError(e);
      }
    }
  }

  Icon tileIcon() {
    return (isFavorited) ? Icon(Icons.star) : Icon(Icons.star_border);
  }

  //TODO: make everything line up all nicely
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$gender.',
                      style: TextStyle(
                        fontSize: 9.0,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 270,
                  child: Text(
                    '$usage',
                    style: TextStyle(
                      fontSize: 9.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: tileIcon(),
            color: kCopper,
            onPressed: () {
              setState(() {
                print(name);
                changeFavorited(!isFavorited);
                updateFavorites(this.name, this.usage, this.gender);
              });
            },
          ),
        ],
      ),
    );
  }
}
