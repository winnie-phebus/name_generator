import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/resources/constants.dart';

class PassTextField extends StatefulWidget {
  Function(String) onChanged;
  String text;

  PassTextField(this.text, {@required this.onChanged});

  @override
  _PassTextFieldState createState() =>
      _PassTextFieldState(this.text, this.onChanged);
}

class _PassTextFieldState extends State<PassTextField> {
  Function(String) onChanged;
  String text;
  bool hidePassword = true;
  IconData passwordVisual = Icons.remove_red_eye_outlined;

  _PassTextFieldState(this.text, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidePassword,
      textAlign: TextAlign.right,
      onChanged: (value) {
        onChanged(value);
      },
      decoration: kTextFieldDecoration.copyWith(
        prefixIcon: IconButton(
          icon: Icon(passwordVisual),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
              passwordVisual = hidePassword
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye;
            });
          },
        ),
        hintText: text.toUpperCase(),
        //prefixText: 'Password:',
      ),
    );
  }
}
