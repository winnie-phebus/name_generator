import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';

class NameTile extends StatelessWidget {
  final String name;
  final String usage;
  final String gender;
  bool isFavorited;

  NameTile(this.name, this.usage, this.gender, this.isFavorited);

  void changeFavorited(bool favoriteStatus) {
    isFavorited = favoriteStatus;
  }

  Icon tileIcon() {
    return (isFavorited) ? Icon(Icons.star) : Icon(Icons.star_border);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              Text(
                '$usage, $gender',
                style: TextStyle(
                  fontSize: 9.0,
                ),
              ),
            ],
          ),
          IconButton(
            icon: tileIcon(),
            color: kCopper,
            onPressed: () {
              print(name);
            },
          ),
        ],
      ),
    );
  }
}