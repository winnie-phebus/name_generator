import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/resources/enums.dart';
import 'package:name_generator/resources/source.dart';
import 'package:name_generator/resources/usage_search.dart';
import 'package:name_generator/services/names.dart';

class GenerateScreen extends StatefulWidget {
  GenerateScreen({Key key, this.title}) : super(key: key);
  static String id = 'generate_screen';

  final String title;

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
      nameArr = nameDataToString(nd, nameCount);
    } else {
      var nd = await nr.getRandomNames(gender.string, usage, 6, surname);
      nameArr = nameDataToString(nd, 6);
      for (int i = 1; i < nameCount / 6; i++) {
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, 6, surname);
        nameArr += nameDataToString(currentBatch, 6);
      }

      int remainder = nameCount % 6;
      for (int i = 0; i < remainder; i++) {
        var currentBatch =
            await nr.getRandomNames(gender.string, usage, remainder, surname);
        nameArr += nameDataToString(currentBatch, remainder);
      }
    }
    //print('running lastNames');
    //var ln = await _lastName();
    //lastNames.add(ln);
    print('sending to newName');
    _newName(nameArr);
  }

  List nameDataToString(dynamic nameData, int length) {
    var generatedNames = new List(length);
    for (int i = 0; i < length; i++) {
      generatedNames[i] = nameData['names'][i];
    }
    return generatedNames;
  }

  void _newName(List nameArr) {
    print('Method called');
    names = '';
    setState(() {
      if (nameArr == null) {
        names = 'oops!';
        return;
      }
      // TODO: adjust this so that 6 cap is worked around
      for (int i = 0; i < nameCount - 1; i++) {
        //String lastname = lastNames[i];
        String name = nameArr[i] + '';
        print(name);
        names += '$name, ';
      }
      //print(names);
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
