import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:name_generator/components/popup_dialog.dart';

import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/resources/constants.dart';

final _firestore = FirebaseFirestore.instance;
CollectionReference favorites = _firestore.collection('favorite_names');

class FavoritesStream extends StatelessWidget {
  final User loggedInUser;

  FavoritesStream(this.loggedInUser);

  Stream<QuerySnapshot> userFavorites() {
    return favorites
        .where(kFAVEUSER, isEqualTo: loggedInUser.email)
        .snapshots(); //where(kFAVEUSER, loggedInUser.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userFavorites(),
      builder: (context, snapshot) {
        List<NameTile> tilesArr = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            ),
          );
        }
        try {
          final favorites = snapshot.data.documents;
          print(favorites.length);
          for (var fav in favorites) {
            if (fav.data()[kFAVEUSER] == loggedInUser.email) {
              final favoriteName = fav.data()[kFAVENAME];
              final favoriteUsage = fav.data()[kFAVEUSAGE];
              final favoriteGender = fav.data()[kFAVEGENDER];

              final currentUser = loggedInUser;

              final favNameTile = NameTile(favoriteName, favoriteUsage,
                  favoriteGender, currentUser, true);
              tilesArr.add(favNameTile);
            }
          }
        } catch (e) {
          print(e);
          ErrorPopUp('Favorites Error', e.toString()).show(context);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: tilesArr,
          ),
        );
      },
    );
  }
}
