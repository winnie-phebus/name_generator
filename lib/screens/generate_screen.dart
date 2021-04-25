import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/name_tile.dart';
import 'package:name_generator/components/popup_dialog.dart';

import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/resources/enums.dart';
import 'package:name_generator/resources/source.dart';

import 'package:name_generator/screens/settings_screen.dart';
import 'package:name_generator/screens/user_screen.dart';

import 'package:name_generator/services/names.dart';
import 'package:name_generator/services/usage_search.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
NameRetriever nr;

class GenerateScreen extends StatefulWidget {
  static String id = 'generate_screen';

  final String title = app_name;

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final _auth = FirebaseAuth.instance;
  User currentUser = loggedInUser;

  String names = '';
  List<Widget> nameTiles = [Text('No Names Yet.')];
  List<String> lastNames = [];

  Gender gender = Gender.either;
  List<DropdownMenuItem> genders = [
    DropdownMenuItem<Gender>(
      value: Gender.male,
      child: Text('male'),
    ),
    DropdownMenuItem<Gender>(
      value: Gender.female,
      child: Text('female'),
    ),
    DropdownMenuItem<Gender>(
      value: Gender.either,
      child: Text('either'),
    )
  ];

  Origin nameSource = defaultSource;
  String usage = '';

  int nameCount = 7;
  double sliderVal = 7.0;
  double numberCap = 12.0;

  bool surname = false;
  bool showSpinner = false;

  void _newNamePress() async {
    print('button hit');
    var nameArr;
    var tilesArr;

    setState(() {
      showSpinner = true;
    });
    // for when name count is less than 6
    if (nameCount < 6) {
      var nd =
          await nr.getRandomNames(gender.string, usage, nameCount, surname);
      print('nd is getting passed');
      nameArr = nr.nameDataToString(nd, nameCount);
      tilesArr = await nr.nameDataToNameTiles(nd, nameCount);
      print(tilesArr[1]);
    } else {
      var nd = await nr.getRandomNames(gender.string, usage, 6, surname);
      nameArr = nr.nameDataToString(nd, 6);
      tilesArr = await nr.nameDataToNameTiles(nd, 6);

      for (int i = 2; i <= nameCount / 6; i++) {
        //this goes as many times as 6 is a multiple of namecount
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, 6, surname);
        nameArr += nr.nameDataToString(currentBatch, 6);
        tilesArr += await nr.nameDataToNameTiles(currentBatch, 6);
      }

      // and this just accounts for the remainder
      int remainder = nameCount % 6;
      var currentBatch =
          await nr.getRandomNames(gender.string, usage, remainder, surname);
      nameArr += nr.nameDataToString(currentBatch, remainder);
      tilesArr += await nr.nameDataToNameTiles(currentBatch, remainder);
    }
    //print('running lastNames');
    //var ln = await _lastName();
    //lastNames.add(ln);
    print('sending to newName');
    _newName(nameArr, tilesArr);
  }

  void _newName(List nameArr, List tilesArr) {
    print('Method called');
    names = '';
    nameTiles = [];
    setState(() {
      if (nameArr == null || tilesArr == null) {
        names = 'oops!';
        nameTiles = [Text("There's an error. oops!")];
        return;
      }

      for (int i = 0; i < nameCount - 1; i++) {
        //String lastname = lastNames[i];
        String name = nameArr[i] + '';
        print(name);
        names += '$name, ';
      }

      String finalName = nameArr[nameArr.length - 1];
      print(finalName);
      setState(() {
        names += finalName;
        nameTiles = tilesArr;
        showSpinner = false;
      });
      //names +=
      // nameData['names'][nameCount - 1] + ' ' + lastNames[nameCount - 1];
    });
  }

  Future<dynamic> _lastName() async {
    var ln = await nr.getLastName('fre');
    String lastName = ln['names'][1];
    print(lastName);
    return lastName;
  }

  Future<dynamic> _lastNames() async {
    for (int i = 0; i < nameCount - 1; i++) {
      lastNames.add(await _lastName());
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    print(loggedInUser);
    nr = NameRetriever(loggedInUser);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      print(loggedInUser.email);
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            'LogIn Error'.toUpperCase(),
            'Error: ' + e.toString() + '\n Try logging in again?'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.house_rounded),
            onPressed: () {
              Navigator.pushNamed(context, UserScreen.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.id);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExpandablePanel(
              iconColor: Theme.of(context).accentColor,
              header: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Adjust Conditions'.toUpperCase()),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    'Tap the arrow to change the gender, source, and number of names generated.'),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Desired Gender: "),
                      DropdownButton(
                        items: genders,
                        value: gender,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        onChanged: (dynamic chosen) {
                          setState(() {
                            gender = chosen;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Current Source: '),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          nameSource = await showSearch(
                              context: context, delegate: UsageSearch());
                          if (nameSource == null) {
                            nameSource = defaultSource;
                          }
                          setState(() {
                            usage = nameSource.getCode();
                          });
                        },
                      ),
                      Text(nameSource.display),
                    ],
                  ),
                  Slider(
                    value: sliderVal,
                    onChanged: (double v) {
                      setState(() {
                        sliderVal = v;
                      });
                    },
                    onChangeEnd: (double) {
                      setState(() {
                        nameCount = sliderVal.round();
                        print(nameCount);
                      });
                    },
                    divisions: numberCap.round() - 1,
                    label: sliderVal.round().toString() + " names",
                    min: 1.0,
                    max: numberCap,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: ModalProgressHUD(
                    inAsyncCall: showSpinner,
                    color: Theme.of(context).bottomAppBarColor,
                    child: CustomScrollView(
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Theme.of(context).accentColor,
                          floating: true,
                          pinned: true,
                          title: Text('The names are:'.toUpperCase()),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              nameTiles,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            OutlinedButton(
              child: Text('GENERATE'),
              onPressed: () {
                setState(() {
                  nameTiles = [];
                  _newNamePress();
                });
              },
              style: ButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
