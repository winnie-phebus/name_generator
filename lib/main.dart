import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';
import 'package:name_generator/resources/enums.dart';
import 'package:name_generator/resources/source.dart';
import 'package:name_generator/services/names.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NameRetriever nr = NameRetriever();
  String names = '';
  List<String> lastNames = [];

  Gender gender = Gender.male;
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
  String usage = 'anci';

  int nameCount = 3;
  double sliderVal = 6.0;
  double numberCap = 12.0;

  bool surname = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
    });
  }

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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                nameSource =
                    await showSearch(context: context, delegate: UsageSearch());
                usage = nameSource.getCode();
              },
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

class UsageSearch extends SearchDelegate<Source> {
  // Search Delegate is a built in Flutter library / class
  // Credited towards MTECHVIRAL for majority of the use of this class.
  List<Source> nameSources = allNameSources;

  List<Source> recents = [];
  List<Source> favorites = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Source chosen = Source.displayToSource(query);
          if (chosen != null) {
            print('$query, ' + chosen.display);
            recents.add(chosen);
            close(context, chosen);
          } else {
            showResults(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation, // a given property
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Query is a property of the class, and is automatically generated.
    return Text('Seems like that is not a valid choice! Try again.');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? Source.sourceConverter(recents)
        : Source.sourceConverter(allNameSources)
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
        ),
        onTap: () {
          query = suggestionList[index];
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
