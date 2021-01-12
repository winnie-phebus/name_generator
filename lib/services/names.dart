import 'package:flutter/material.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/services/networking.dart';

const btnApiKey = 'wi948351677';
const JSONbtnUrl = 'https://www.behindthename.com/api/';

class NameRetriever {
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

  List nameDataToNameTiles(dynamic nameData, int length) {
    print(nameData);
    List<Widget> nameTiles = new List<Widget>(length);
    for (int i = 0; i < length; i++) {
      NameTile currentName =
          NameTile(nameData['names'][i], 'eng', 'ambiguous', false);
      nameTiles[i] = (currentName);
    }
    return nameTiles;
  }
}
