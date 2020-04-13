import 'dart:convert';
import 'package:flutter/material.dart';

class ScheduleItem {
  final List<String> months = [
    "Jan.",
    "Feb.",
    "Mar.",
    "Apr.",
    "May",
    "Jun.",
    "July",
    "Aug.",
    "Sep.",
    "Oct.",
    "Nov.",
    "Dec."
  ];

  String id;
  String date;
  String city;
  String location;
  String time;

  ScheduleItem.fromJson(Map<String, dynamic> jsonMap) {
    this.id = jsonMap['_id'];
    this.date = formatDate(jsonMap['date']);
    this.city = jsonMap['city'];
    this.location = jsonMap['location'];
    this.time = jsonMap['time'];

    print(this.time);

    if (this.city == null) this.city = '';
    if (this.location == null) this.location = '';
    if (this.time == null) this.time = '';

  }
  
  String formatDate(String date) {
    String year, month, day;
    List<String> splitDate = date.split('-');
    year = splitDate[0];
    month = splitDate[1];
    day = splitDate[2];
    month =  months[int.parse(month) - 1];

    // Ex. Nov 19, 2020
    String formatted = month + " " + day + ", " + year;
    return formatted;  
  }

  void debugPrint() {
    print('ID: ' + this.id);
    print('City: ' + this.city);
    print('Location: ' + this.location);
    print('Date: ' + this.date);
  }
}

class ItemList {
  List<ScheduleItem> list = [];

  ItemList.fromJson(response) {
    final _scheduleList = jsonDecode(response.body);
    for (var i = 0; i < (_scheduleList.length); i++) {
      ScheduleItem newItem = ScheduleItem.fromJson(_scheduleList[i]);
      this.list.add(newItem);
    }
  }
}

class ScheduleItemWidget extends StatelessWidget {
  final ScheduleItem item;

  ScheduleItemWidget({this.item});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            print('Tapped');
          },
          child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(5.0),
        child: Container(
          margin: EdgeInsets.all(8.0),

          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          item.date,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(item.time,
                            style: TextStyle(fontSize: 11.0))),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(item.city, style: TextStyle(fontSize: 11.0),),
                    ),

                    Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(item.location,
                            style: TextStyle(fontSize: 11.0))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
