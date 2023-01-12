import 'package:flutter/material.dart';
// import 'package:name_generator/resources/constants.dart';

// based off of the tutorial found:
// https://dev.to/fluttercorner/how-to-create-popup-in-flutter-popup-menu-example-fluttercorner-com-373e
class ErrorPopUp extends StatelessWidget {
  final String title;
  final String body;
  void show(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(body),
        ],
      ),
      actions: <Widget>[
        /* new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.close),
        ),*/
      ],
    );
  }

  ErrorPopUp(this.title, this.body);
}

class ConfirmationPopUp extends StatelessWidget {
  final String title;
  final String body;
  final Function confirmFunction;

  void show(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(body),
        ],
      ),
      actions: <Widget>[
        /* new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.close),
        ),
        new FlatButton(
          child: Icon(Icons.check),
          onPressed: () {
            print('confirmed');
            confirmFunction();
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
        )*/
      ],
    );
  }

  ConfirmationPopUp(this.title, this.body, this.confirmFunction);
}
