import 'package:bbfarmky/home/home.dart';
import 'package:flutter/material.dart';

class CompleteRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Container(margin: EdgeInsets.all(10.0) ,child: Text('Order Complete!', style: Theme.of(context).textTheme.title,),),
          Container(margin: EdgeInsets.all(10.0) ,child: Text('You will be contacted soon regarding your order', style: Theme.of(context).textTheme.body2),),
          RaisedButton(child: Text('Go Home'), onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeMenu()));
          },)
        ],),),
    ),);
  }
}