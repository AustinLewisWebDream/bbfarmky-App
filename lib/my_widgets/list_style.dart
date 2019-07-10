import 'package:flutter/material.dart';

class ListStyle extends StatelessWidget {
  final String text;
  final String imagePath;

  ListStyle({this.text, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(text, style: TextStyle(color: Color.fromRGBO(252, 172, 25, 1)) ,)
    ],);
  }
}