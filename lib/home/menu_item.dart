import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String itemText;
  final String imagePath;
  final route;
  final Function callback;
  MenuItem(
      {this.itemText = 'Menu Item',
      this.imagePath = 'assets/images/about.png',
      this.route,
      this.callback
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (route != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => route),
                  );
                } else callback();
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    height: 50.0,
                    width: 50.0,
                  ),
                  Center(
                      child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      itemText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
