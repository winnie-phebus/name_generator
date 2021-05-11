import 'package:flutter/material.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/resources/source.dart';
import 'package:name_generator/services/networking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const btnApiKey = 'wi948351677';
const JSONbtnUrl = 'https://www.behindthename.com/api/';

class NameRetriever {
  User currentUser;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  NameRetriever(this.currentUser);

  Future<dynamic> lookupName(String name) async {
    String url = JSONbtnUrl + 'lookup.json?name=$name&key=$btnApiKey';
    NetworkHelper networkHelper = NetworkHelper(url);

    print('returning from name lookup');
    return await networkHelper.getData();
  }

  Future<dynamic> getRandomNames(
      String gender, String usage, int number, bool surname) async {
    String surnameString = surname ? 'yes' : 'no';
    String usageSection = (usage == '') ? '' : 'usage=$usage&';

    String url = JSONbtnUrl +
        'random.json?$usageSection' +
        'gender=$gender&number=$number&key=$btnApiKey';
    NetworkHelper networkHelper = NetworkHelper(url);

    print('returning from NameRetriever');
    return await networkHelper.getData();
  }

  Future<dynamic> getLastName(String usage) async {
    return await getRandomNames('', usage, 1, true);
  }

  List nameDataToString(dynamic nameData, int length) {
    print(nameData);
    var generatedNames = new List(length);
    for (int i = 0; i < length; i++) {
      generatedNames[i] = nameData['names'][i];
    }
    return generatedNames;
  }

  Future<NameTile> nameTileBuilder(
      String name, Origin nameOrigin, bool favorited) async {
    String usages = nameOrigin.display;
    String gender = 'mf';
    if (nameOrigin == null) {
      var nd = await lookupName(name);
      print('$nd for $name');
      usages = nd[0]['usages'][0]['usage_full'];
      int cap = nd[0]["usages"].length;
      for (int i = 1; i < cap; i++) {
        usages += ", " + nd[0]['usages'][i]['usage_full'];
      }
      gender = nd[0]["gender"];
    }
    //print(currentUser);
    currentUser = _auth.currentUser;
    //print(currentUser.email);
    return NameTile(name, usages, gender, currentUser, favorited);
  }

  Future<List> nameDataToNameTiles(
      dynamic nameData, Origin nameOrigin, int length) async {
    print(nameData);
    List<Widget> nameTiles = new List<Widget>(length);
    for (int i = 0; i < length; i++) {
      String currname = nameData['names'][i];
      bool isFavorite = await nameInFavorites(currname);
      NameTile currentName =
          await nameTileBuilder(currname, nameOrigin, isFavorite);
      nameTiles[i] = (currentName);
    }
    return nameTiles;
  }

  Future<bool> nameInFavorites(String name) async {
    print('checking favorites for $name');
    bool inFavorites = false;
    try {
      DocumentReference usersRef = _firestore
          .collection('favorite_names')
          .doc(currentUser.email + ' ' + name);

      dynamic doc = await usersRef.get();
      print(doc);
      inFavorites = doc.exists;
    } catch (e) {
      print(e);
    }
    return inFavorites;
  }
}
