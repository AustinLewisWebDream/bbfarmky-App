import 'dart:io';
import 'package:bbfarmky/my_widgets/loading_indicator.dart';
import 'package:bbfarmky/schedule/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ScheduleRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScheduleRoute();
  }
}

class _ScheduleRoute extends State<ScheduleRoute> {
  Future<ItemList> items;

  @override
  void initState() {
    super.initState();
    items = loadSchedule(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Schedule'),),
      body: Container(
            child: FutureBuilder<ItemList>(
              future: loadSchedule(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView(children: snapshot.data.list.map((element) => ScheduleItemWidget(item: element)).toList());
                } else {
                  return LoadingIndicator();
                }
              },
            ),
          ),
    );
  }

  Future<ItemList> loadSchedule() async {
    // https://app.bbfarmky.com/api/pickup
    // Response response = await get('http://10.0.2.2:3001/api/pickup', headers: {HttpHeaders.authorizationHeader: 'Bearer keyeIMUytOcC820fT'});
    Response response = await get('https://app.bbfarmky.com/api/pickup', headers: {HttpHeaders.authorizationHeader: 'Bearer keyeIMUytOcC820fT'});
    if(response.statusCode == 200) {
      return ItemList.fromJson(response);
    } 
    else
      throw Exception('Failed to load post');
  }
}