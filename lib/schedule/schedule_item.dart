import 'dart:convert';
import 'package:flutter/material.dart';

class ScheduleItem {
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  String id;
  String date;
  String city;
  String location;
  int time;
  String formattedTime;
  String _rawDate;

  ScheduleItem.fromJson(Map<String, dynamic> jsonMap) {
    this.id = jsonMap['id'];
    final _fields = jsonMap['fields'];
    this.date = _fields['Date'];
    final cityList = _fields['City'];
    this.location = _fields['Location'];
    this.time = _fields['Time Frame'];

    if (this.date != null && this.date != '') {
      this._rawDate = date;
      formatDate();
    } else
      this.date = '';

    if (cityList == null)
      this.city = '';
    else
      this.city = cityList[0];

    if (this.location == null) this.location = '';
    if (this.time == null) this.time = 7200;

    formatTime();
  }

  void formatTime() {
    int hours = int.parse(_rawDate.substring(11, 13)) - 4;
    String minutes = _rawDate.substring(14, 16);

    String cycle;
    if (hours > 12) {
      hours -= 12;
      cycle = 'pm';
    } else if (hours == 12) {
      cycle = 'pm';
    } else {
      cycle = 'am';
    }
    formattedTime = (hours.toString() +
        ':' +
        minutes.padLeft(2, '0').padRight(2, '0') +
        cycle);
  }

  void debugPrint() {
    print('ID: ' + this.id);
    print('City: ' + this.city.toString());
    print('Location: ' + this.location);
    print('Date: ' + this.date);
  }

  void formatDate() {
    // Input date: 2019-07-03T16:00:00.000Z
    final strippedDate = date.substring(0, 10);
    String year = strippedDate.substring(0, 4);
    String month = months[int.parse(strippedDate.substring(5, 7)) - 1];
    String day = strippedDate.substring(9, 10);

    date = (day + ' ' + month + ' ' + year);
  }
}

class ItemList {
  List<ScheduleItem> list = [];

  ItemList.fromJson(response) {
    final _decoded = jsonDecode(response.body);
    final _scheduleList = _decoded['records'];
    for (var i = 0; i < (_scheduleList.length); i++) {
      ScheduleItem newItem = ScheduleItem.fromJson(_scheduleList[i]);
      this.list.add(newItem);
    }
  }
}

class ScheduleItemWidget extends StatelessWidget {
  final ScheduleItem item;

  // Vars - item.formattedTime, date, location

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
          margin: EdgeInsets.all(10.0),

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
                        child: Text(item.formattedTime,
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
