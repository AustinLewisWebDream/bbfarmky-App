import 'package:bbfarmky/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(4, 116, 188, 1),
        accentColor: Color.fromRGBO(252, 172, 25, 1),
        textTheme: TextTheme(
          title: TextStyle(color: Color.fromRGBO(252, 172, 25, 1), fontFamily: 'Lato',fontSize: 50.0),
          body2: TextStyle(color: Colors.white),
          subtitle: TextStyle(fontSize: 25.0)
        )
      ),
      home: HomeMenu(),
    );
  }
}