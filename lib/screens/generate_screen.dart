import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/resources/enums.dart';
import 'package:name_generator/resources/source.dart';

import 'package:name_generator/services/names.dart';
import 'package:name_generator/services/usage_search.dart';

class GenerateScreen extends StatefulWidget {
  //GenerateScreen({Key key, this.title}) : super(key: key);
  static String id = 'generate_screen';

  final String title = app_name;

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  NameRetriever nr = NameRetriever();
  String names = '';
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

  Source nameSource = defaultSource;
  String usage = '';

  int nameCount = 3;
  double sliderVal = 7.0;
  double numberCap = 12.0;

  bool surname = false;

  void _newNamePress() async {
    print('button hit');
    var nameArr;
    if (nameCount < 6) {
      var nd =
          await nr.getRandomNames(gender.string, usage, nameCount, surname);
      nameArr = nr.nameDataToString(nd, nameCount);
    } else {
      var nd = await nr.getRandomNames(gender.string, usage, 6, surname);
      nameArr = nr.nameDataToString(nd, 6);
      for (int i = 1; i < nameCount / 6; i++) {
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, 6, surname);
        nameArr += nr.nameDataToString(currentBatch, 6);
      }

      int remainder = nameCount % 6;
      for (int i = 0; i < remainder; i++) {
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, remainder, surname);
        nameArr += nr.nameDataToString(currentBatch, remainder);
      }
    }
    //print('running lastNames');
    //var ln = await _lastName();
    //lastNames.add(ln);
    print('sending to newName');
    _newName(nameArr);
  }

  void _newName(List nameArr) {
    print('Method called');
    names = '';
    setState(() {
      if (nameArr == null) {
        names = 'oops!';
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
      names += finalName;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            Row(
              children: <Widget>[
                Text("Names should be "),
                DropdownButton(
                  items: genders,
                  value: gender,
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                  onChanged: (dynamic chosen) {
                    setState(() {
                      gender = chosen;
                    });
                  },
                ),
                Text(" names."),
              ],
            ),
            Row(
              children: [
                Text(nameSource.display),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    nameSource = await showSearch(
                        context: context, delegate: UsageSearch());
                    if (nameSource == null) {
                      nameSource = defaultSource;
                    }
                    usage = nameSource.getCode();
                  },
                ),
              ],
            ),
            Text(
              'The names are: $names',
              style: Theme.of(context).textTheme.headline4,
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
              divisions: numberCap.round(),
              label: sliderVal.round().toString() + " names",
              min: 1.0,
              max: numberCap,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newNamePress,
        tooltip: 'New Names',
        child: Icon(Icons.add),
      ),
    );
  }
}
