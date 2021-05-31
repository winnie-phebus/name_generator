import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:name_generator/components/popup_dialog.dart';

import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/resources/enums.dart';
import 'package:name_generator/resources/source.dart';

import 'package:name_generator/screens/settings_screen.dart';
import 'package:name_generator/screens/user_screen.dart';

import 'package:name_generator/services/names.dart';
import 'package:name_generator/services/usage_search.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
  List<Widget> nameTiles = [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'No Names Yet. \nPress GO to get started!'.toUpperCase(),
        style: TextStyle(
          color: kSandyBrown, //TODO: [THEME] update in the overhaul
          letterSpacing: 2,
        ),
      ),
    )
  ];
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

  int nameCount = 6;
  double sliderVal = 7.0;
  double numberCap = 12.0;

  bool surname = false;
  bool showSpinner = false;

  void errDialog(String title, String body) {
    ErrorPopUp(title, body).show(context);
  }

  Widget generateButton() {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        //elevation: 5.0,
        color: theme.primaryColor,
        child: MaterialButton(
          child: Text(
            'GO',
            style: TextStyle(
                color: theme.backgroundColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          minWidth: 20,
          onPressed: () {
            setState(() {
              print('---------------------------------');
              nameTiles = [];
              _newNamePress();
            });
          },
        ),
      ),
    );
  }

  void _newNamePress() async {
    print('button hit');
    var nameArr;
    var tilesArr;
    Origin nameOrigin;

    setState(() {
      showSpinner = true;
    });

    if (tag_fun.contains(nameSource)) {
      nameOrigin = nameSource;
    } else {
      nameOrigin = null;
    }

    try {
      // for when name count is less than 6
      if (nameCount < 6) {
        var nd =
            await nr.getRandomNames(gender.string, usage, nameCount, surname);
        print('nd is getting passed');
        nameArr = nr.nameDataToString(nd, nameCount);
        tilesArr = await nr.nameDataToNameTiles(nd, nameOrigin, nameCount);
        print('tiles arr[1]: ' + tilesArr[1]);
      } else {
        var nd = await nr.getRandomNames(gender.string, usage, 6, surname);
        nameArr = nr.nameDataToString(nd, 6);
        tilesArr = await nr.nameDataToNameTiles(nd, nameOrigin, 6);

        for (int i = 2; i <= nameCount / 6; i++) {
          //this goes as many times as 6 is a multiple of name count
          var currentBatch =
              await nr.getRandomNames(gender.string, usage, 6, surname);
          nameArr += nr.nameDataToString(currentBatch, 6);
          tilesArr += await nr.nameDataToNameTiles(currentBatch, nameOrigin, 6);
        }

        // and this just accounts for the remainder
        int remainder = nameCount % 6;
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, remainder, surname);
        nameArr += nr.nameDataToString(currentBatch, remainder);
        tilesArr +=
            await nr.nameDataToNameTiles(currentBatch, nameOrigin, remainder);
      }
    } catch (e) {
      errDialog('Name Retrieval Error', e.toString());
      setState(() {
        showSpinner = false;
      });
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
        showSpinner = false;
        nameTiles = [
          SizedBox(
            height: 10,
          ),
          Text(
            "There's an error. Oops! \n\n Please head to bug reporter in settings so Winn can know!",
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ];
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

  /*Future<dynamic> _lastName() async {
    var ln = await nr.getLastName('fre');
    String lastName = ln['names'][1];
    print(lastName);
    return lastName;
  }*/

  /*Future<dynamic> _lastNames() async {
    for (int i = 0; i < nameCount - 1; i++) {
      lastNames.add(await _lastName());
    }
  }*/

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    print(loggedInUser);
    nr = NameRetriever(loggedInUser);
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
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
    ThemeData theme = Theme.of(context);
    Color divColor = theme.accentColor; //theme.highlightColor;
    Color iconColor = theme.primaryColor;

    double divSize = 3;
    double letterSpaces = 2;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '   $app_name'.toUpperCase(),
                //textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    color: theme.accentColor,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Generate'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 28,
                        color: theme.accentColor,
                        fontWeight: FontWeight.normal),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.house_rounded),
                        color: iconColor,
                        onPressed: () {
                          Navigator.pushNamed(context, UserScreen.id);
                        },
                      ),
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
              Divider(
                thickness: divSize,
                color: divColor,
              ),
            ],
          ),
          ExpandablePanel(
            iconColor: theme.primaryColor,
            header: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                'Filters'.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    color: theme.primaryColor,
                    letterSpacing: letterSpaces,
                    fontWeight: FontWeight.bold),
              ),
            ),
            /*collapsed: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  'Tap the arrow to change the gender, source, and number of names generated.'),
            ),*/
            expanded: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Gender:".toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          items: genders,
                          value: gender,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: iconColor,
                          ),
                          style: TextStyle(
                            color: theme.primaryColor,
                          ),
                          dropdownColor: theme.buttonColor,
                          onChanged: (dynamic chosen) {
                            setState(() {
                              gender = chosen;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Source:'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          nameSource.display.toLowerCase(),
                          style: TextStyle(color: theme.primaryColor),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          color: iconColor,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Number:'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              nameCount.toString(),
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          ],
                        ),
                        SliderTheme(
                          child: Slider(
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
                            divisions: numberCap.round(),
                            label: sliderVal.round().toString() + " names",
                            min: 0.0,
                            max: numberCap,
                          ),
                          data: SliderTheme.of(context).copyWith(
                            valueIndicatorColor: theme.buttonColor,
                            valueIndicatorTextStyle: TextStyle(
                                color: theme
                                    .hintColor), // This is what you are asking for
                            thumbColor:
                                theme.accentColor, // Custom Thumb overlay Color
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 9.0),
                            overlayColor: theme.accentColor,
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
            child: Divider(
              thickness: divSize,
              color: divColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              color: theme.bottomAppBarColor,
              child: CustomScrollView(
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    /* leading: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        print('boop');
                      },
                    ),*/
                    backgroundColor: theme.buttonColor,
                    floating: true,
                    pinned: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('names:'.toUpperCase(),
                            style: TextStyle(
                                letterSpacing: letterSpaces,
                                color: theme.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    actions: [
                      generateButton(),
                    ],
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
          ),
          /*RoundedButton(
            title: 'GENERATE',
            onPressed: () {
              setState(() {
                print('---------------------------------');
                nameTiles = [];
                _newNamePress();
              });
            },
            //style: ButtonStyle(),
          ),*/
          Divider(
            color: divColor,
            thickness: divSize,
          ),
        ],
      ),
    );
  }
}
