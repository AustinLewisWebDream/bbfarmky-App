import 'package:flutter/material.dart';

class Badge extends StatefulWidget {
  int number;
  Badge(this.number);

  @override
  _BadgeState createState() => _BadgeState(number: this.number);
}

class _BadgeState extends State<Badge> {
  int number;
  _BadgeState({this.number});
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Number recieved by the Badge Class: ' + this.number.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.topCenter,
      child: new Container(
        padding: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 12,
          minHeight: 12,
        ),
        child: new Text(
          this.number.toString(),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
