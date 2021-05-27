import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Theme.of(context).accentColor,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
