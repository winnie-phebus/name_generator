import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:name_generator/resources/constants.dart';

class NameTile extends StatefulWidget {
  String name;
  String usage;
  String gender;
  bool isFavorited;

  @override
  _NameTileState createState() =>
      _NameTileState(name, usage, gender, isFavorited);

  NameTile(this.name, this.usage, this.gender, this.isFavorited);
}

class _NameTileState extends State<NameTile> {
  String name;
  String usage;
  String gender;
  bool isFavorited;

  _NameTileState(this.name, this.usage, this.gender, this.isFavorited);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    // TODO: implement toString
    return "$name, $usage, $gender, $isFavorited";
  }

  void changeFavorited(bool favoriteStatus) {
    isFavorited = favoriteStatus;
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

                /// isFavorited = !isFavorited;
              });
            },
          ),
        ],
      ),
    );
  }
}
